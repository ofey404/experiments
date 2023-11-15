from flask import Flask, request
app = Flask(__name__)

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    file.save(file.filename)  # Save file to disk
    return 'File uploaded successfully'

if __name__ == '__main__':
    app.run(debug=True)
