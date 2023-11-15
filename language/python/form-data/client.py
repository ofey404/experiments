import requests

url = 'http://localhost:5000/upload'
file_path = './commands.sh'
file_name = 'file.txt'

with open(file_path, 'rb') as file:
    files = {'file': (file_name, file)}
    response = requests.post(url, files=files)

print(response.text)
