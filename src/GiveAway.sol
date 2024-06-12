// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GiveAway {
    /* @author: SOUFIANE MASAD */
    /* @title: Give away smart contract */
    /* @description: 
        - this smart contract let a creator to create a give away
        - once the number of candidates is reached, the smart contract will randomly determine the winner and then reward him
        automatically
        - we will be using Chainlink VRF to use the randomness as well as Chainlink Automation to automize the process of
        winning  
    */

    address private immutable i_owner;
    address[] private participants;
    uint256 private numberOfParticipants;
    uint256 private startTime;
    uint256 private endTime;

    error NumberOfParticipantsReached();

    constructor() {
        i_owner = msg.sender;
        startTime = block.timestamp;
    }

    function registerParticipant() external {
        if (numberOfParticipants < participants.length) {
            revert NumberOfParticipantsReached();
        }
        participants.push(msg.sender);
    }
}
