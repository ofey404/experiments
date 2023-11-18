#define CROW_MAIN
#include <crow.h>

// The Crow library does not support automatic conversion from JSON to custom types directly.

int main()
{
    crow::SimpleApp app;

    CROW_ROUTE(app, "/")
            ([](){
                return "Hello from crow_http_server!\n";
            });

    // Define a POST route that accepts a JSON body
    CROW_ROUTE(app, "/json").methods(crow::HTTPMethod::Post)
            ([](const crow::request& req){
                // Log the message or do something with it...
                try {
                    // Parse the JSON body
                    auto body = crow::json::load(req.body);

                    // If parsing fails or it's not an object, return a 400 status code
                    if (!body || body.t() != crow::json::type::Object)
                    {
                        crow::response res(400);
                        res.write("Bad Request");
                        return res;
                    }

                    // Get the "message" field from the JSON object
                    std::string message = body["message"].s();


                    // Respond with a 200 status code and the message received
                    crow::response res(200);
                    res.write("Received message: " + message);
                    return res;
                } catch (std::runtime_error& e) {
                    // Log the error message
                    CROW_LOG_ERROR << "Error: " << e.what();
                    // Return a 400 Bad Request response
                    return crow::response(400, "Bad Request: " + std::string(e.what()));
                }
            });

    app.port(8080).multithreaded().run();
}
