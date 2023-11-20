#pragma once
#include <llvm/IR/Value.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/IRBuilder.h>
#include "Expr.h"

class Compiler {
public:
    Compiler();
    llvm::Value *compile(const Expr *expr);
private:
    llvm::LLVMContext context;
    llvm::IRBuilder<> builder;
};
