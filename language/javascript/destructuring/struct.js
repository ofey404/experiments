#!/usr/bin/env node

const user = {
    firstName: 'Robin',
    lastName: 'Wieruch',
};
function withoutDestructuring(user) {
    console.log("# without destructuring:");
    const firstName = user.firstName;
    const lastName = user.lastName;
    console.log(firstName + ' ' + lastName);
}

function destructuring() {
    console.log("# destructuring:");
    console.log("const { lastName, firstName } = user;");
    console.log("swap the order doesn't matter");

    const { lastName, firstName } = user;
    console.log(`firstName = ${firstName}`);
    console.log(`lastName = ${lastName}`);
}

withoutDestructuring(user)
console.log("")
destructuring(user)
