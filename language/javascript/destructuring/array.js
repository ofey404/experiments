#!/usr/bin/env node

[a, b, ...rest] = [10, 20, 30, 40, 50];
console.log("[a, b, ...rest] = [10, 20, 30, 40, 50];");

console.log(`a = ${a}`);
// Expected output: 10
console.log(`b = ${b}`);
// Expected output: 20
console.log(`rest = ${rest}`);
// Expected output: Array [30, 40, 50]
