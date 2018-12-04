pragma solidity ^0.4.24;
contract e0x {
 event LinkVisited(string url, uint linkId);
 event LinkAdded(uint linkId, string url);
 
 struct LinkTemplate {
  address userAddress;
  string url;
 }
 
 uint lastLinkId;
 mapping (uint => LinkTemplate) public linkMapping;
 
 constructor() public {
  lastLinkId = 0;
 }
 
 
 function createNewLink(string url) public returns (uint) {
     lastLinkId++;
  linkMapping[lastLinkId] = LinkTemplate(msg.sender, url);
  emit LinkAdded(lastLinkId, url);
  return lastLinkId;
 }
 
 modifier linkExists(uint linkId) {
     //link with the given hash does not exist
  if(linkMapping[linkId].userAddress == 0x0000000000000000000000000000000000000000) {
   revert();
  }
  _;
 }
 
 function getLink(uint linkId) linkExists(linkId) public constant
  returns(
   address,
   string
  ) {
      //emit LinkVisited(linkId, link.url);
      LinkTemplate memory link = linkMapping[linkId];
   return(
      link.userAddress,
      link.url
   );
  }
}