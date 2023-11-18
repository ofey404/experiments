#include <boost/beast/core.hpp>
#include <boost/beast/http.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <string>
#include <iostream>

namespace beast = boost::beast;
namespace http = beast::http;
namespace net = boost::asio;
using tcp = net::ip::tcp;

int main()
{
    try
    {
        auto const address = net::ip::make_address("0.0.0.0");
        auto const port = static_cast<unsigned short>(std::atoi("8080"));

        net::io_context ioc{1};

        tcp::acceptor acceptor{ioc, {address, port}};
        for(;;)
        {
            tcp::socket socket{ioc};

            acceptor.accept(socket);

            beast::flat_buffer buffer;

            http::request<http::dynamic_body> req;
            http::read(socket, buffer, req);

            http::response<http::dynamic_body> res{http::status::ok, req.version()};
            boost::beast::ostream(res.body()) << "Hello, World!";
            res.prepare_payload();

            http::write(socket, res);

            socket.shutdown(tcp::socket::shutdown_send);
        }
    }
    catch(std::exception const& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }
}
