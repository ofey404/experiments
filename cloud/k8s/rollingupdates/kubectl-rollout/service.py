from http.server import BaseHTTPRequestHandler, HTTPServer
import os
import logging


try:
    port = int(os.environ["PORT"])
except:
    port = 80
try:
    version = os.environ["VERSION"]
except:
    version = "1.0"

class S(BaseHTTPRequestHandler):
    def do_GET(self):
        logging.info(
            "GET request,\nPath: %s\nHeaders:\n%s\n", str(self.path), str(self.headers)
        )
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(f"GET request for {self.path}, VERSION={version}\n".encode("utf-8"))


def run(
    server_class=HTTPServer,
    handler_class=S,
    port=80,
):
    logging.basicConfig(level=logging.INFO)
    server_address = ("", port)
    httpd = server_class(server_address, handler_class)
    logging.info(f"Starting httpd at {port}...\n")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info("Stopping httpd...\n")


run(
    port=port,
)
