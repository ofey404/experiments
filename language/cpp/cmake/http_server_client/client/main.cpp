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
        auto const host = "localhost";
        auto const port = "8080";
        auto const target = "/";
        int version = 11;

        net::io_context ioc;

        tcp::resolver resolver{ioc};
        beast::tcp_stream stream{ioc};

        auto const results = resolver.resolve(host, port);

        stream.connect(results);

        http::request<http::string_body> req{http::verb::get, target, version};
        req.set(http::field::host, host);
        req.prepare_payload();

        http::write(stream, req);

        beast::flat_buffer buffer;

        http::response<http::dynamic_body> res;

        http::read(stream, buffer, res);

        std::cout << res << std::endl;

        beast::error_code ec;
        stream.socket().shutdown(tcp::socket::shutdown_both, ec);
    }
    catch(std::exception const& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }
}
