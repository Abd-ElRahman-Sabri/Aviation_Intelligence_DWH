import requests
import os

# رابط قاعدة بيانات الطائرات (محدث يوميا من OpenSky)
URL = "https://opensky-network.org/datasets/metadata/aircraftDatabase.csv"

# مسار الحفظ
current_dir = os.path.dirname(os.path.abspath(__file__))
save_path = os.path.join(current_dir, '../../data/landing/aircraftDatabase.csv')

def download_file():
    print("Starting download for Aircraft Database (this may take time)...")
    
    try:
        response = requests.get(URL, stream=True)
        response.raise_for_status()
        
        with open(save_path, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        print(f"Download completed. File saved to: {save_path}")
        
    except Exception as e:
        print(f"Error downloading file: {e}")

if __name__ == "__main__":
    download_file()
