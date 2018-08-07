contract Welfare {
 address[] recipients;
 uint totalFunding;
 mapping(address => uint) withdrawn;
 function register () {
 recipients.push(msg.sender);
 }
 function () payable {
 totalFunding += msg.value;
 }
 function withdraw () {
 uint withdrawnSoFar = withdrawn[msg.sender];
 uint allocation = totalFunding / recipients.length;
 require(allocation > withdrawnSoFar);
 uint amount = allocation - withdrawnSoFar;
 withdrawn[msg.sender] = allocation;
 msg.sender.transfer(amount);
 }
}