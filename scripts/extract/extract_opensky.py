import requests
import json
import os
from datetime import datetime

# بيانات حسابك
USERNAME = 'sasoli'
PASSWORD = '6kAesd5D!#XC7_Y' 

URL = "https://opensky-network.org/api/states/all"

# مسار حفظ الملفات (Landing Zone)
OUTPUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../data/landing')
os.makedirs(OUTPUT_DIR, exist_ok=True)

def fetch_data():
    print(f"🚀 Starting data extraction at {datetime.now()}...")
    try:
        response = requests.get(URL)
        if response.status_code == 200:
            data = response.json()
            flight_count = len(data.get('states', []) or [])
            
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"opensky_flights_{timestamp}.json"
            file_path = os.path.join(OUTPUT_DIR, filename)
            
            with open(file_path, 'w') as f:
                json.dump(data, f)
            
            print(f"✅ Success! Captured {flight_count} flights.")
            print(f"📁 Data saved to: {file_path}")
        else:
            print(f"❌ Failed! Status Code: {response.status_code}")
            print(f"Reason: {response.text}")
    except Exception as e:
        print(f"💥 Error occurred: {e}")

if __name__ == "__main__":
    fetch_data()
