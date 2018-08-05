pragma solidity ^0.4.24;

/// @author David Li
/// @title Todo List Contract
/// @notice A sample to do list for my Vue Dapp
/// @dev This is a todolist with storage on the blockchain, much more efficent to use a database.

contract TodoList {
   struct Todo {
      uint256 id;
      bytes32 content;
      address owner;
      bool isCompleted;
      uint256 timestamp;
   }
   uint256 public constant maxAmountOfTodos = 1000;
   /// @dev Owner => todos
   mapping(address => Todo[maxAmountOfTodos]) public todos;
   /// @dev  Owner => last todo id
   mapping(address => uint256) public lastIds;
   modifier onlyOwner(address _owner) {
      require(msg.sender == _owner);
      _;
   }
   /// @notice Add a todo to the list
   /// @param _content list item to append.
   function addTodo(bytes32 _content) public {
      Todo memory myNote = Todo(lastIds[msg.sender], _content, msg.sender, false, now);
      todos[msg.sender][lastIds[msg.sender]] = myNote;
      if(lastIds[msg.sender] >= maxAmountOfTodos) lastIds[msg.sender] = 0;
      else lastIds[msg.sender]++;
   }
   /// @notice marking a todoitem as completed 
   /// @param _todoId todolist item ID   Mark a todo as completed
   function markTodoAsCompleted(uint256 _todoId) public onlyOwner(todos[msg.sender][_todoId].owner) {
      require(_todoId < maxAmountOfTodos);
      require(!todos[msg.sender][_todoId].isCompleted);
      todos[msg.sender][_todoId].isCompleted = true;
   }
}