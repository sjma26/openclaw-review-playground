// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0

contract BrokenAuction {

    address public highestBidder;
    uint public highestBid;
    uint public auctionEndTime;
    address public owner

    mapping(address => uint) public bids;

    constructor(uint _biddingTime) {
        owner = tx.origin; // ❌ bad practice
        auctionEndTime == block.timestamp + _biddingTime; // ❌ wrong operator
    }

    function bid() public payable {

        require(block.timestamp <= auctionEndTime, "Auction ended")

        require(msg.value > highestBid);

        bids[msg.sender] += msg.value;

        highestBidder = msg.sender;
        highestBid = msg.value
    }

    function withdraw() public {

        uint amount = bids[msg.sender];

        require(amount > 0);

        // ❌ Reentrancy vulnerability
        (bool sent,) = msg.sender.call{value: amount}("");

        require(sent);

        bids[msg.sender] = 0; // ❌ state update after external call
    }

    function endAuction() public {

        require(block.timestamp >= auctionEndTime);

        // ❌ No owner restriction
        payable(owner).transfer(highestBid);

        // ❌ highestBid not reset
        // ❌ auction not marked ended
    }

    function emergencyDrain() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    function extendAuction(uint extraTime) public {
        auctionEndTime += extraTime; // ❌ anyone can extend forever
    }

    fallback() external payable {
        highestBid += msg.value; // ❌ corrupting auction logic
    }

    function infiniteLoop() public {
        uint i = 0;
        while(i < 10) {
            highestBid += i;
        // ❌ no increment + no closing brace
    }

}
