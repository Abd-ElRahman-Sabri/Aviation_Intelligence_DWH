import json
import psycopg2
import os
import glob


db_host = "localhost"
db_name = "aviation_dwh"
db_user = "postgres"
db_pass = "1599208" 

# تحديد مسار فولدر الداتا
current_dir = os.path.dirname(os.path.abspath(__file__))
landing_path = os.path.join(current_dir, '../../data/landing')

def load_data():
    # 1. البحث عن احدث ملف
    # بنجمع كل ملفات json في ليستة
    files = glob.glob(f'{landing_path}/*.json')
    
    if len(files) == 0:
        print("No JSON files found in data/landing")
        return

    # بنختار احدث ملف بناء على وقت الانشاء
    latest_file = max(files, key=os.path.getctime)
    print(f"Processing file: {os.path.basename(latest_file)}")

    # 2. قراءة الملف
    with open(latest_file, 'r') as f:
        data = json.load(f)

    # التاكد ان الملف فيه بيانات
    flights_list = data.get('states', [])
    if not flights_list:
        print("File is empty")
        return

    print(f"Found {len(flights_list)} flights to insert")

    # 3. الاتصال بقاعدة البيانات
    conn = None
    try:
        conn = psycopg2.connect(
            host=db_host,
            database=db_name,
            user=db_user,
            password=db_pass
        )
        cur = conn.cursor()

        # جملة الادخال
        sql = """
            INSERT INTO landing.flights_raw (
                icao24, callsign, origin_country, time_position, last_contact, 
                longitude, latitude, baro_altitude, on_ground, velocity, 
                true_track, vertical_rate, sensors, geo_altitude, squawk, 
                spi, position_source
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # ادخال البيانات
        for flight in flights_list:
            cur.execute(sql, flight)

        # حفظ التغييرات
        conn.commit()
        print("Data inserted successfully")

        # اغلاق الاتصال
        cur.close()

    except Exception as e:
        print(f"Error: {e}")
        if conn:
            conn.rollback()
    
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    load_data()
