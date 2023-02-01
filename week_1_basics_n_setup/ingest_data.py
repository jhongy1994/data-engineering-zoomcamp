#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from sqlalchemy import create_engine
import argparse
import os

def main(params) :
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    parquet_name = 'output.parquet'
    
    # download the parquet filw
    os.system(f'wget {url} -O {parquet_name}')
    # to logging: engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}', echo=True)
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    df = pd.read_parquet(parquet_name)
    #ingest data to postgres
    # df = df.head(2)
    # print(df)
    print('start ingest data')
    #Inside the docker, the data isn't inserted into database without chunksize
    df.to_sql(name=table_name, con=engine, if_exists='replace', chunksize=100000)
    print('ingest data complete')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = 'Ingest Parquet data to postgres')

    # user, password,host, port, db, table-name, url
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='databse name for postgres')
    parser.add_argument('--table_name', help='name of the table where we will write the results to')
    parser.add_argument('--url',help='url of the Parquet file')
    parser.add_argument('--user', help='user name for postgres')

    args = parser.parse_args()
    
    main(args)



