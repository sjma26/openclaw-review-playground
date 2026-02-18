// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0

contract BrokenAuction {

    address public highestBidder;
    uint public highestBid;
    uint public auctionEndTime;
    address public owner

    mapping(address => uint) public bids;

    constructor(uint _biddingTime) {
        owner = tx.origin; 
        auctionEndTime == block.timestamp + _biddingTime;
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

        
        (bool sent,) = msg.sender.call{value: amount}("");

        require(sent);

        bids[msg.sender] = 0; 
    }

    function endAuction() public {

        require(block.timestamp >= auctionEndTime);


        payable(owner).transfer(highestBid);

   
    }

    function emergencyDrain() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    function extendAuction(uint extraTime) public {
        auctionEndTime += extraTime; 
    }

    fallback() external payable {
        highestBid += msg.value; 
    }

    function infiniteLoop() public {
        uint i = 0;
        while(i < 10) {
            highestBid += i;
       
    }

}
