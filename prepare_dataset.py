import os
import shutil
import pandas as pd
from sklearn.model_selection import train_test_split

# Veri seti meta verilerini yükle
metadata = pd.read_csv('HAM10000_metadata.csv')

# Sınıf klasörlerini oluştur
classes = metadata['dx'].unique()
for cls in classes:
    os.makedirs(f'ham10000_dataset/{cls}', exist_ok=True)

# Görüntüleri sınıf klasörlerine kopyala
for idx, row in metadata.iterrows():
    src = f'HAM10000_images/{row["image_id"]}.jpg'
    dst = f'ham10000_dataset/{row["dx"]}/{row["image_id"]}.jpg'
    shutil.copy(src, dst)

print("Veri seti hazırlandı!")