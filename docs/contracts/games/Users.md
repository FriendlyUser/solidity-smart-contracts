# Users
[see the source](https://github.com/FriendlyUser/solidity-smart-contracts/tree/master/contracts/games/Users96.sol)
> Users.sol
>
> Author: David Li


**Execution cost**: less than 190 gas

**Deployment cost**: less than 145400 gas

**Combined cost**: less than 145590 gas


## Events
### UserCreated(address,bytes32)


**Execution cost**: No bound available


Params:

1. **_address** *of type `address`*
2. **_pseudo** *of type `bytes32`*

--- 
### UserDestroyed(address)


**Execution cost**: No bound available


Params:

1. **_address** *of type `address`*


## Methods
### authenticate()


**Execution cost**: less than 793 gas

**Attributes**: constant



Returns:


1. **_pseudo** *of type `bytes32`*

--- 
### create(bytes32)


**Execution cost**: less than 21681 gas


Params:

1. **_pseudo** *of type `bytes32`*


--- 
### destroy()


**Execution cost**: less than 6727 gas




--- 
### exists(address)


**Execution cost**: less than 593 gas

**Attributes**: constant


Params:

1. **_address** *of type `address`*

Returns:


1. **_exists** *of type `bool`*

--- 
### get(address)


**Execution cost**: less than 898 gas

**Attributes**: constant


Params:

1. **_address** *of type `address`*

Returns:


1. **_pseudo** *of type `bytes32`*

--- 
### users(address)


**Execution cost**: less than 531 gas

**Attributes**: constant


Params:

1. **param_0** *of type `address`*

Returns:


1. **output_0** *of type `bytes32`*

[Back to the top ↑](#users)
