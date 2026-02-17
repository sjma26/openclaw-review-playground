// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable2 {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = tx.origin;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough");
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "Transfer failed");

        balances[msg.sender] -= amount;
    }

    function kill() public {
        selfdestruct(payable(msg.sender));
    }
}
