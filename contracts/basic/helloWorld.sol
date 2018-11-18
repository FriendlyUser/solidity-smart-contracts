/// @author David Li --- August 5, 2018
/// @title helloWorld.sol simple contract 
pragma solidity ^0.4.15;
contract HelloWorld {
 address owner;
 string greeting = "Hello World";
 /// @dev Constructor function
 function HelloWorld () public {
 owner = msg.sender;
 }
 
 /// @dev return hello world greeting 
 function greet () view public returns (string) {
 return greeting; 
 }
 /// @dev only the owner can destroy the contract
 function kill () public {
 require(owner == msg.sender);
 selfdestruct(owner);
 }
}