import pandas as pd
import os
import random

save_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../data/landing/fuel_consumption.xlsx')

def create_messy_excel():

    data = {
        'Unnamed: 0': [None, None, 'Aircraft', 'SU-GDL', 'A6-EEO', 'N12345'],
        'Unnamed: 1': [None, None, 'Fuel Type', 'Jet-A1', 'Jet-A1', 'Avgas'],
        'Report Date: 2026-01-13': [None, None, 'Gallons', 1500, 2300, 120],
        'Unnamed: 3': [None, None, 'Cost ($)', 4500, 6900, 500],
        'Notes': ['CONFIDENTIAL', None, 'Pilot Comments', 'Good', 'Refuel delay', '']
    }
    
    df = pd.DataFrame(data)
    


    df.to_excel(save_path, index=False)
    print(f"Generated Messy Excel file at: {save_path}")

if __name__ == "__main__":
    create_messy_excel()
