// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Threat {

    address public owner;
    mapping(address => uint256) public balances;
    uint256 public totalFunds;

    constructor() public {
        owner = msg.sender;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;   
        totalFunds += msg.value;             
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount);

        (bool success, ) = msg.sender.call{value: _amount}(""); 
        require(success);

        balances[msg.sender] -= _amount;    
    }

    function changeOwner(address _newOwner) public {
        require(tx.origin == owner);        
        owner = _newOwner;
    }

    function destroy() public {
        selfdestruct(payable(msg.sender));   
    }

    function unsafeTransfer(address payable _to, uint256 _amount) public {
        _to.call{value: _amount}("");        
    }

    receive() external payable {}
}