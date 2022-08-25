from flask import Flask, Response
from flask import request
from flask import jsonify 
import pyodbc
from sqlalchemy import create_engine,Integer
import pandas as pd
import urllib

app = Flask(__name__)


params = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};"
                                     "SERVER=172.16.0.5;"
                                     "DATABASE=Dabra;"
                                     "UID=hsosa;"
                                     "PWD=camila")
engine = create_engine('mssql+pymssql://hsosa:camila@172.16.0.5/Dabra')




sql_talle =  "RSCV_TALLE_PARA_CADA_MARCA.sql"
fd1 = open(sql_talle, 'r')
sqlFile1 = fd1.read()
fd1.close()
DF1 = pd.read_sql_query(sqlFile1,engine)
DF1.insert(14, 'PROVEEDOR', DF1.pop('PROVEEDOR'))

periodo=DF1['YEARMONTH_DATE'].drop_duplicates()
NIKE=DF1.loc[DF1['MARCA'] == 'NIKE']
NIKE=NIKE.to_dict('records')





@app.route('/NIKE',methods = ['GET'])
def show_codigo_Agrupador():
    if request.method == 'GET':
        response = jsonify({'NIKE':NIKE})
        response.status_code = 200
        return response

if __name__ == "__main__":
    app.run(debug=True)
