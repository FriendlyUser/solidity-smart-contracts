/// @title SimplePonzie, a simple ponzi scheme
/// @author David Li
/// @notice illustrate how a smart contract can be used as a ponzi scheme
contract SimplePonzi {
 address public currentInvestor;
 uint public currentInvestment = 0;
 /// @dev new investments must be 10% greater than current
 function () payable public {
 uint minimumInvestment = currentInvestment * 11/10;
 require(msg.value > minimumInvestment);
 // document new investor
 address previousInvestor = currentInvestor;
 currentInvestor = msg.sender;
 currentInvestment = msg.value;
 // payout previous investor
 previousInvestor.send(msg.value);
 }
}