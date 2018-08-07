
import './ERC20.sol';
contract TokenSale {
 enum State { Active, Suspended }
 address public owner;
 ERC20 public token;
 State public state;
 function TokenSale(address tokenContractAddress) {
 owner = msg.sender;
 token = ERC20(tokenContractAddress);
 state = State.Active;
 }
 // 1:1 exchange of ETH for token
 function buy() payable {
 require(state == State.Active);
 token.transfer(msg.sender, msg.value);
 }
 function suspend () {
 require(msg.sender == owner);
 state = State.Suspended;
 }
 function activate () {
 require(msg.sender == owner);
 state = State.Active;
 }
 function withdraw() {
 require(msg.sender == owner);
 owner.transfer(address(this).balance);
 }
}