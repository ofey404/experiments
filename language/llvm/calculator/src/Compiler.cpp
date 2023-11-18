#include "Compiler.h"
#include "Expr.h"
#include <llvm/IR/IRBuilder.h>

Compiler::Compiler()
        : builder(context) {}

llvm::Value *Compiler::compile(const Expr *expr) {
    if (auto intExpr = dynamic_cast<const Integer*>(expr)) {
        return llvm::ConstantInt::get(builder.getInt32Ty(), intExpr->value);
    } else if (auto binExpr = dynamic_cast<const BinaryExpr*>(expr)) {
        auto lhs = compile(binExpr->lhs.get());
        auto rhs = compile(binExpr->rhs.get());
        if (binExpr->op == '+')
            return builder.CreateAdd(lhs, rhs);
        else if (binExpr->op == '-')
            return builder.CreateSub(lhs, rhs);
    }
    throw std::runtime_error("Unknown expression type");
}
