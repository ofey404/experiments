#include <llvm/Support/raw_ostream.h>
#include "Parser.h"
#include "Compiler.h"

int main() {
    // Example usage of parser and compiler
    Parser parser("2+3-4");
    auto expr = parser.parse();

    Compiler compiler;
    auto value = compiler.compile(expr.get());

    value->print(llvm::errs());
    return 0;
}
