import xml.etree.ElementTree as ET
import psycopg2
import os
import random
from datetime import datetime

# إعدادات الاتصال
db_params = {"host": "localhost", "database": "aviation_dwh", "user": "postgres", "password": "1599208"}

# مسار الحفظ
landing_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../data/landing/weather.xml')

def generate_mock_xml():
    """محاكاة استخراج بيانات طقس بصيغة XML"""
    root = ET.Element("WeatherReport")
    airports = ["HECA", "KJFK", "EGLL", "OMDB"] # القاهرة، نيويورك، لندن، دبي
    
    for apt in airports:
        report = ET.SubElement(root, "Station", code=apt)
        ET.SubElement(report, "Timestamp").text = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        ET.SubElement(report, "Temperature").text = str(random.randint(10, 40))
        ET.SubElement(report, "WindSpeed").text = str(random.randint(0, 50))
        ET.SubElement(report, "Condition").text = random.choice(["Sunny", "Cloudy", "Rainy"])

    tree = ET.ElementTree(root)
    tree.write(landing_path)
    print(f"Generated XML file at: {landing_path}")

def load_xml_to_db():
    conn = psycopg2.connect(**db_params)
    cur = conn.cursor()
    
    tree = ET.parse(landing_path)
    root = tree.getroot()
    
    sql = "INSERT INTO landing.weather_raw (airport_code, timestamp, temperature, wind_speed, condition, xml_source) VALUES (%s, %s, %s, %s, %s, %s)"
    
    for station in root.findall('Station'):
        code = station.get('code')
        ts = station.find('Timestamp').text
        temp = station.find('Temperature').text
        wind = station.find('WindSpeed').text
        cond = station.find('Condition').text
        
        cur.execute(sql, (code, ts, temp, wind, cond, 'weather.xml'))
    
    conn.commit()
    cur.close()
    conn.close()
    print("Weather XML data loaded successfully!")

if __name__ == "__main__":
    generate_mock_xml()   # 1. توليد الملف
    load_xml_to_db()      # 2. إدخال الداتا
