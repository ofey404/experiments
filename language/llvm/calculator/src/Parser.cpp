#include "Parser.h"
#include <stdexcept>

void Parser::setInput(const std::string& newInput) {
    input = newInput;
    pos = 0;
}

std::unique_ptr<Expr> Parser::parse() {
    auto result = parseExpr();
    if (pos != input.size())
        throw std::runtime_error("Unexpected character");
    return result;
}

std::unique_ptr<Expr> Parser::parseExpr() {
    auto lhs = parseInteger();
    while (pos < input.size() && (input[pos] == '+' || input[pos] == '-')) {
        char op = input[pos++];
        auto rhs = parseInteger();
        lhs = std::make_unique<BinaryExpr>(op, std::move(lhs), std::move(rhs));
    }
    return lhs;
}

std::unique_ptr<Expr> Parser::parseInteger() {
    if (pos >= input.size() || !isdigit(input[pos]))
        throw std::runtime_error("Expected integer");
    int value = 0;
    while (pos < input.size() && isdigit(input[pos])) {
        value = value * 10 + (input[pos++] - '0');
    }
    return std::make_unique<Integer>(value);
}
