#pragma once
#include <memory>
#include <string>
#include "Expr.h"

class Parser {
public:
    Parser(const std::string &input);
    std::unique_ptr<Expr> parse();
private:
    std::unique_ptr<Expr> parseExpr();
    std::unique_ptr<Expr> parseInteger();

    std::string input;
    int pos;
};
