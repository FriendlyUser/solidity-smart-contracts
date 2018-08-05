pragma solidity ^0.4.24;

/// @author David Li
/// @title Users.sol
/// @notice Basic user registerion system, could add timestamp, when user registered.
/// @notice This is a todolist with storage on the blockchain, much more efficent to use a database
contract Users {

  mapping(address => bytes32) public users;

  event UserCreated(address indexed _address, bytes32 _pseudo);
  event UserDestroyed(address indexed _address);

  function exists (address _address) public view returns (bool _exists) {
    return (users[_address] != bytes32(0));
  }

  function authenticate () public view returns (bytes32 _pseudo) {
    require(exists(msg.sender));
    return (users[msg.sender]);
  }

  function create (bytes32 _pseudo) public {
    users[msg.sender] = _pseudo ;
    emit UserCreated(msg.sender, _pseudo);
  }

  function destroy () public {
    require(exists(msg.sender));
    delete users[msg.sender];
    emit UserDestroyed(msg.sender);
  }

  function get (address _address) public view returns(bytes32 _pseudo) {
    require(exists(_address));
    return (users[_address]);
  }

}
