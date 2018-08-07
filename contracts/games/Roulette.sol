pragma solidity ^0.4.24;

/// @dev simple example 
contract Roulette {
 constructor() {

 }
 mapping(address => uint) balances;
 function betRed () payable {
 bool winner = (randomNumber() % 2 == 0);
 if (winner)
 balances[msg.sender] += msg.value * 2;
 }
 function randomNumber() returns (uint) {
 // we will implement this in a later section
 // for now, imagine it returns a number from
 // 0-36
 }
}