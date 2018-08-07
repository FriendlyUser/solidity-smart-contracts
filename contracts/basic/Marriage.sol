pragma solidity ^0.4.24;
/// @title Marriage Contract
contract Marriage {

 mapping (address => uint) balances;
 address wife = address(0); // dummy address
 address husband = address(1); // dummy address
 function withdraw () {
 uint amount = balances[msg.sender];
 balances[msg.sender] = 0;
 msg.sender.transfer(amount);
 }
 function () payable {
 balances[wife] += msg.value / 2;
 balances[husband] += msg.value / 2;
 }
}