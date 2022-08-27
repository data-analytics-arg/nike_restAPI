from flask import Flask, Response
from flask import request
from flask import jsonify 
import pyodbc
from sqlalchemy import create_engine,Integer
import pandas as pd
import urllib

app = Flask(__name__)


@app.route('/NIKE',methods = ['GET'])
def show_codigo_Agrupador():
    if request.method == 'GET':
        response = jsonify({'NIKE':[{'Item' : 'Rice', 'Price':10},{'Item': 'Dal','Price':15},{'Item':'Chicken','Price':20},{'Item':'Mutton', 'Price':25},{'Item':'Fish','Price':20},{'Item':'IceCream','Price':10}]})
        response.status_code = 200
        return response

if __name__ == "__main__":
    app.run(debug=True)
