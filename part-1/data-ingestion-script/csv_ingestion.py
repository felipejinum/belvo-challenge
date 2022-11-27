import pandas as pd
import os 
from google.cloud import bigquery
client = bigquery.Client()

default_tables = ['companies_deals_associations','companies','contacts_deals_associations','contacts','customers','deals','owners']

def default_data_prep_and_ingestion(table):
    df = pd.read_csv(folder_path +'/'+ table + '.csv')
    df.columns = map(str.lower,df.columns)
    df.columns = df.columns.str.replace(' ','_')
    df.columns = df.columns.str.replace('.','_')
    df.to_gbq('raw.'+x, project_id='belvo-challenge',if_exists='replace')

folder_path = input('Enter folder path with tables: ')

for x in default_tables:
    df = default_data_prep_and_ingestion(x)
    print(x + ' table ingested succesfully.')