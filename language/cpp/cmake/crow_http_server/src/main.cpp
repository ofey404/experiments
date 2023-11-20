#define CROW_MAIN
#include <stdexcept>
#include <iostream>
#include <yaml-cpp/yaml.h>
#include <crow.h>
#include <nlohmann/json.hpp>
#include <boost/program_options.hpp>

namespace po = boost::program_options;

using json = nlohmann::json;

// Define a Person structure
struct Person {
    std::string name;
    int age;
};

// Define the to_json and from_json functions for Person
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE(Person, name, age)

struct Config {
    int port;
};

Config loadConfig(const std::string &filename) {
    YAML::Node config = YAML::LoadFile(filename);
    Config c;

    if(config["Port"]) {
        c.port = config["Port"].as<int>();
    } else {
        throw std::runtime_error("Missing 'Port' in config file");
    }

    // Add further validations as needed

    return c;
}

void setupRoutes(crow::SimpleApp& app) {
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

    // The new /json_structured route
    CROW_ROUTE(app, "/json_structured").methods(crow::HTTPMethod::Post)
            ([](const crow::request& req) {
                try {
                    // Parse the JSON body into a Person object
                    Person person = json::parse(req.body).get<Person>();
                    person.age++; // increment the age

                    // Convert the updated Person object back into JSON
                    json res_body = person;

                    // Respond with a 200 status code and the updated Person object
                    crow::response res(200);
                    res.write(res_body.dump());
                    return res;
                } catch (std::exception& e) {
                    // Log the error message
                    CROW_LOG_ERROR << "Error: " << e.what();
                    // Return a 400 Bad Request response
                    return crow::response(400, "Bad Request: " + std::string(e.what()));
                }
            });

}

std::string parseCommandLine(int argc, char* argv[]) {
    std::string configFile = "config.yaml"; // default config file

    po::options_description desc("Allowed options");
    desc.add_options()
            ("help", "produce help message")
            ("config", po::value<std::string>(&configFile), "set config file path")
            ;

    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, desc), vm);
    po::notify(vm);

    if (vm.count("help")) {
        std::cout << desc << "\n";
        exit(0);
    }

    return configFile;
}

int main(int argc, char* argv[]) {
    std::string configFilePath = parseCommandLine(argc, argv);

    crow::SimpleApp app;
    setupRoutes(app);

    Config config;
    try {
        config = loadConfig(configFilePath);
    } catch (const std::exception &e) {
        std::cerr << "Failed to load config: " << e.what() << std::endl;
        return 1; // or handle error as appropriate
    }

    app.port(config.port).multithreaded().run();
}
