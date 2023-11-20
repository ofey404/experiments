#include "Expr.h"

Integer::Integer(int value)
        : value(value) {}

BinaryExpr::BinaryExpr(char op, std::unique_ptr<Expr> lhs, std::unique_ptr<Expr> rhs)
        : op(op), lhs(std::move(lhs)), rhs(std::move(rhs)) {}
