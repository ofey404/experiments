#pragma once
#include <memory>

class Expr {
public:
    virtual ~Expr() = default;
};

class Integer : public Expr {
public:
    Integer(int value);
    int value;
};

class BinaryExpr : public Expr {
public:
    BinaryExpr(char op, std::unique_ptr<Expr> lhs, std::unique_ptr<Expr> rhs);
    char op;
    std::unique_ptr<Expr> lhs, rhs;
};
