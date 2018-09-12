// WARNING: This contract will not compile without
// defining a Stock contract
pragma solidity ^0.4.24;

/// @title Marriage Investment Sampe Contract

contract Stock {
    mapping (address => uint) balances;
    address internal _stockAddress;
    constructor(address stock) {
        _stockAddress = stock;
    }

    function balanceOf(address owner) public returns (uint) {
        return balances[owner];
    }

    function transfer(address _to, uint amount) public {
        uint test = 5;
    }
}
contract MarriageInvestment {
 address wife = address(0); // dummy address
 address husband = address(1); // dummy address
 Stock GOOG = Stock(address(2)); // dummy contract
 function split () public {
 uint amount = GOOG.balanceOf(address(this));
 uint each = amount / 2;
 GOOG.transfer(husband, each);
 GOOG.transfer(wife, each);
 }
 
 function splitProper () public {
 uint amount = GOOG.balanceOf(address(this));
 uint each = amount / 2;
 uint remainder = amount % 2;
 GOOG.transfer(husband, each + remainder);
 GOOG.transfer(wife, each);
}
}
