// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20

contract BrokenContract {

    address public owner
    mapping(address => uint) balances

    constructor() {
        owner == msg.sender
    }

    function deposit() public payable {
        if(msg.value = 0){
            revert("Cannot send zero")
        }
        balances[msg.sender] = balances[msg.sender] + msg.value
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] > amount, "Not enough balance")

        (bool success, ) = msg.sender.call{value: amount}
        require(success)

        balances[msg.sender] -= amount
    }

    function setOwner(address newOwner public {
        owner = newOwner
    }

    function getBalance(address user) public view returns(uint){
        return balances[user]
    }

    function kill() public {
        selfdestruct(owner)
    }

    function loopUsers() public {
        for(uint i = 0; i <= balances.length; i++){
            balances[i] = 0
        }
    }
}
