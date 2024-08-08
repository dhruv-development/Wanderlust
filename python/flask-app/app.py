from flask import Flask, render_template, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/api/status')
def status():
    return jsonify({"message": "The server is up and running"})

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000,debug=True)

