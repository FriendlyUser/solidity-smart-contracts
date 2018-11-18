---
title: Sept Status Report 
author: David Li
authorURL: http://twitter.com/davidLi
authorFBID: 661277176
---
# Solidity

## Solidity Notes 

Solidity receives many comparisons to JavaScript, but its closest
relative is C. Solidity is a strongly typed language with minimal
functionality that emphasizes limiting storage and CPU usage. It supports
256-bit data types for the EVM, unlike most languages, which support only
32- and 64-bit processors.

In general, Solidity development should be treated more like building
a bridge than building a web site. The process is not iterative.

Whenever possible, proven legacy code should be used instead of new,
untested code. Contracts should be thoroughly tested and vetted before
being deployed to the mainnet.

```solidity
pragma solidity ^0.4.15;
contract HelloWorld {
 address owner;
 string greeting = "Hello World";
 // Constructor function
 function HelloWorld () public {
 owner = msg.sender;
 }
 function greet () view public returns (string) {
 return greeting; 
 }
 function kill () public {
 require(owner == msg.sender);
 selfdestruct(owner);
 }
}
```


Visibility modifiers determine the contexts in which a function can be
executed. There are four visibility modifiers in Solidity:

  - **private**: Only the current contract can use the function.

  - **internal**: Only the current contract and contracts inheriting
    from the current contract can execute the function.

  - **external**: The function can be triggered only by a transaction or
    external contract.

  - **public**: There are no restrictions on how the function can be
    called.

Only some functions are permitted to modify the state tree. Functions
declared with one of the following three modifiers cannot modify state
or send ether:

  - view: Can read information from the state tree but cannot modify
    state.

  - pure: Cannot read or modify the state tree. Th return value depends
    on only the function arguments.

  - constant: An alias for view. Deprecated to prevent confusion with
    constant variables.

The modifier payable is special, allowing functions to accept ether.

##### Fallback Functions

Every contract can have one unnamed function that acts as a default
function to execute when no other functions can match the transaction
call or when a transaction is sent to a contract without specifying a
function.

The type mapping is Solidity’s version of a hashmap. It’s a key/value
store in which both the key and the value must adhere to the specified
data type. The value can be any data type, whereas the key type is
restricted to address, bool, the integer types, fixed-size arrays, and
the fixed-size byte types.

|                 |                |
| :-------------: | :------------: |
|   Data Types    |   Zero Value   |
| Integers Values |       0        |
|      bool       |     false      |
|     address     |      0x0       |
|   Bytes types   |       0        |
|      Array      | \[\](length=0) |
|     mapping     |    no keys     |

Variables set or initialized to the zero value in Solidity are not
included in the state tree. The delete keyword in Solidity resets a
variable to its zero value and deletes the variable from the state tree.

Solidity stores locations in two places: in the state tree and in
memory. Storage in the state tree persists on the blockchain, whereas
the memory is cleared after every transaction. Storage on the state tree
is expensive and should be used only when necessary. Memory is cheap and
should be used whenever possible. Solidity refers to these two locations
as storage for the state tree and memory for memory.

```c
    uint a = 3;
    2 + 3; // addition
    a += 3; // shorthand for a = a + 3
    a++; // shorthand for a += 1
    3 - 2; // subtraction
    a -= 1; // shorthand for a = a -1
    a--; // shorthand for a -= 1
    3 * 2; // multiplication
    a *= 3; // shorthand for a = a * 3
    4 / 2; // integer division
    3 / 2; // = 1, no floating point arithmetic
    a /= 2; // shorthand for a = a / 2;
    10 % 2; // modulus
    2**3; // power operator, this is 23
    2e7; // scientific notation, this is 2 * 107
```

```c
uint a = 10;
uint b = 3;
// multiply by 10**n to add n zeros
// if you add n zeros, the last n digits will
// be the decimal digits
uint c = (a * 10**6) / b; // 3333333
```

```c
1 == 1 wei;
1 ether == 10**18 wei;
2 ether == 2e18 wei;
2 finney == .002 ether;
if (msg.value == 1 ether) buyLottoTicket();
msg.value; // 1000000000000000000 a.k.a. 1 ether
```

Improper use of the ether transfer functions are the number one source of
Solidity bugs and hacks. There are three ways to send ether in Solidity:
* address.transfer(value)
* address.send(value)
* address.call.value(value)()


```solidity
// DO NOT USE: BAD CODE
contract TrustFund {
 address[3] children;
 function TrustFund (address[3] _children) {
 children = _children;
 }
 function updateAddress(uint child, address newAddress)
 {
 require(msg.sender == children[child]);
 children[child] = newAddress;
 }
 function disperse () {
 uint balance = address(this).balance;
 children[0].transfer(balance / 2);
 children[1].transfer(balance / 4);
 children[2].transfer(balance / 4);
 }
 function () payable {}
}
```
If I’m the second child and I’m upset that I’m not receiving my fair
share, I can lock up the contract so that no one can access their funds by
updating my address to an empty contract with no fallback function:
contract SaltyChild {}


Safely Dispersing Ether to a Fixed Number of Addresses
```solidity
function disperse () {
 uint balance = address(this).balance;
 children[0].send(balance / 2);
 children[1].send(balance / 4);
 children[2].send(balance / 4);
}
```

Race condition is the general term for the class of bugs that can occur when
calling external contracts. A race condition can occur when any unknown
state change occurs in an external function call. A re-entrancy attack is one
form of race condition. Another form of race condition can occur if two
contracts are both modifying the same variable in a third contract. 

# I love IPFS

### IPFS 

* https://ipfs.github.io/public-gateway-checker/
* https://medium.com/coinmonks/step-by-step-approach-to-create-dapp-using-ethereum-reactjs-ipfs-part-1-42ea4cf69488