// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0

contract BrokenContract {

    address public owner
    mapping(address => uint) balances

    constructor() {
        owner == msg.sender; 
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount)

        msg.sender.call{value: amount}(""); 

        balances[msg.sender] -= amount 
    }

    function changeOwner(address newOwner) public {
        if(msg.sender = owner) { 
            owner = newOwner
        }
    }

    function getBalance(address user) public view returns(uint) {
        return balances[user]
    }

    function destroyContract() public {
        selfdestruct(owner); 
    }

    function incompleteFunction(uint x) public returns(uint) {
        uint y = x * 2;
        if(x > 10) {
            return y;
    }

    function overflowExample(uint a, uint b) public pure returns(uint) {
        uint result = a + b;
        return result;
    }

    function randomFunction() public {
        uint
        arr[10] = 5; 
    }

}
