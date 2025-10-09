#!/usr/bin/env python3
"""
Подготовка данных для анализа
"""

import pandas as pd
import os
from pathlib import Path

def prepare_data():
    # Пути к файлам
    raw_data_path = Path('data/raw/ml-latest')
    processed_path = Path('data/processed')
    
    # 1. Создаем подвыборку рейтингов
    print("Создание подвыборки ratings...")
    ratings = pd.read_csv(raw_data_path / 'ratings.csv')
    # Берем случайные 500000 строк из таблицы
    # random_state=42 - чтобы при каждом запуске выборка была одинаковой ---?
    ratings_sample = ratings.sample(n=500000, random_state=42)
    ratings_sample.to_csv(processed_path / 'ratings.csv', index=False)
    # index=False - не сохранять номера строк
    
    # 2. Копируем остальные файлы
    for file in ['movies.csv', 'tags.csv', 'links.csv']: # - для каждого файла в списке
        print(f"Копирование {file}...") # выводим какой файл сейчас копируем
        df = pd.read_csv(raw_data_path / file) # читаем файл
        df.to_csv(processed_path / file, index=False) # - сохраняем в новую папку
    
    # 3. Создаем файл с описанием данных
    with open(processed_path / 'DATA_INFO.md', 'w', encoding='utf-8') as f: # - открываем файл для записи ('w')
        f.write(f"""# Информация о данных\n\n")
        ## Подвыборка рейтингов\n")
        - Исходный размер: {len(ratings):,} записей\n") # - вставляем количество записей с разделителями тысяч (1,000,000)
        - Размер подвыборки: {len(ratings_sample):,} записей\n") 
        - Дата создания: {pd.Timestamp.now()}\n") #  - вставляем текущую дату и время
        """)
    
    print("Все данные подготовлены!")
    print(f"Исходные данные: data/raw/ml-latest/")
    print(f"Для анализа: data/processed/")

if __name__ == "__main__":  # "если этот файл запущен напрямую (а не импортирован)"
    prepare_data()