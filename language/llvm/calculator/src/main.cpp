#include <llvm/Support/raw_ostream.h>
#include "Parser.h"
#include "Compiler.h"
#include <iostream>
#include <string>

int main() {
    std::string input;
    Parser parser;
    Compiler compiler;
    while (true) {
        std::cout << "> ";
        std::getline(std::cin, input);
        if (input == "quit" || input == "exit") {
            break;
        }
        parser.setInput(input);
        auto expr = parser.parse();
        auto value = compiler.compile(expr.get());
        value->print(llvm::errs());
        std::cout << "\n";
    }
    return 0;
}
