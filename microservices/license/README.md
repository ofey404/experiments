# license

This directory contains my proof-of-concept for license services.

Features I'll experiment with:

1. Classical online license server, like typora. (Return a license file.)
2. Offline licensing without internet.
3. Machine-locked licensing.
4. Licensing of a k8s based microservice system.

## Discussion

2010: [How to implement a simple licensing scheme? - Stack Overflow](https://stackoverflow.com/questions/4231031/how-to-implement-a-simple-licensing-scheme)

Elliptic curves has numerous advantages: 

1. The key is relatively short (thanks to using EC instead of RSA/DSA)
2. The key is “random” in that a different one is generated every time for the same user name
3. And, crucially, there’s no keygen code in the application and a cracker cannot write a keygen without getting hold of your private key.

The answerer also maintains a Objective-C library: [GitHub - vslavik/ellipticlicense: Short product key generation and validation framework based on elliptic curve digital signatures (ECDSA). (Fork of defunct dchest/ellipticlicense)](https://github.com/vslavik/ellipticlicense)

---

2008: [copy protection - How do you protect your commercial application from being installed on multiple computers with one license? - Stack Overflow](https://stackoverflow.com/questions/175857/how-do-you-protect-your-commercial-application-from-being-installed-on-multiple?rq=1)

> My general rules are
> 
> - Huge deployments in commercial environments - Audit
> - Medium deployments of low value software < $1000 / seat - License key activation
> - Small deployments of high value software > $10,000 / seat - Dongles

---

2018: [How to license protect Golang based software? - Reddit](https://www.reddit.com/r/golang/comments/bgq4we/how_to_license_protect_golang_based_software/)

- Once they have the program, if they really want to reverse engineer it, they will.
- Using MAC address is not a good idea these days for a number of reasons, not least that it's easily changeable.

---

2020: [licensing - What is a good way to make a "software activation code" system? - Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/410606/what-is-a-good-way-to-make-a-software-activation-code-system)

- Therefore, find a simple and well-accepted scheme that you don't have to write from scratch, and which satisfies the requirements that I just spoke of.
- But please don't think that "your revenues depend on its 'security.'"

## Packages

A third party provider: [Software Licensing and Distribution API - Keygen](https://keygen.sh/)

- Not good to outsource it.

---

A golang library with elliptic curve algorithm: [GitHub - hyperboloide/lk: Simple licensing library for golang.](https://github.com/hyperboloide/lk)

---

[ecdh package - crypto/ecdh - Go Packages](https://pkg.go.dev/crypto/ecdh)


## Knowledges

[A (Relatively Easy To Understand) Primer on Elliptic Curve Cryptography](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/)


