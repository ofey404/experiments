from http.server import BaseHTTPRequestHandler, HTTPServer


class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        # Print the contents of the request
        print(f"Request received: {self.path}")
        print(f"Headers: {self.headers}")
        print(f"Body: {self.rfile.read(int(self.headers.get('Content-Length', 0))).decode('utf-8')}")

        # Send a response back to the client
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"Hello, world!")


if __name__ == '__main__':
    # Set up the server
    server_address = ('localhost', 8000)
    httpd = HTTPServer(server_address, RequestHandler)

    # Start the server
    print(f"Server started on {server_address}")
    httpd.serve_forever()
