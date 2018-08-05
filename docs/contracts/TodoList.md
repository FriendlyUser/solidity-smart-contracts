# TodoList
[see the source](https://github.com/FriendlyUser/solidity-smart-contracts/tree/master/contracts/TodoList.sol)
> Todo List Contract
>
> Author: David Li


**Execution cost**: less than 269 gas

**Deployment cost**: less than 225600 gas

**Combined cost**: less than 225869 gas




## Methods
### addTodo(bytes32)
>
>Add a todo to the list


**Execution cost**: less than 101908 gas


Params:

1. **_content** *of type `bytes32`*

    > list item to append.



--- 
### lastIds(address)


**Execution cost**: less than 506 gas

**Attributes**: constant


Params:

1. **param_0** *of type `address`*

Returns:


1. **output_0** *of type `uint256`*

--- 
### markTodoAsCompleted(uint256)
>
>marking a todoitem as completed 


**Execution cost**: less than 21434 gas


Params:

1. **_todoId** *of type `uint256`*

    > todolist item ID   Mark a todo as completed



--- 
### maxAmountOfTodos()


**Execution cost**: less than 184 gas

**Attributes**: constant



Returns:


1. **output_0** *of type `uint256`*

--- 
### todos(address,uint256)


**Execution cost**: less than 1295 gas

**Attributes**: constant


Params:

1. **param_0** *of type `address`*
2. **param_1** *of type `uint256`*

Returns:


1. **id** *of type `uint256`*
2. **content** *of type `bytes32`*
3. **owner** *of type `address`*
4. **isCompleted** *of type `bool`*
5. **timestamp** *of type `uint256`*

[Back to the top ↑](#todolist)
