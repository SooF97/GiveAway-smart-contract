// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract GiveAway is ERC721 {
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

    constructor() ERC721("GiveAway Token", "GVTK") {
        i_owner = msg.sender;
        startTime = block.timestamp;
    }

    function registerParticipant() external {
        if (numberOfParticipants < participants.length) {
            revert NumberOfParticipantsReached();
        }
        participants.push(msg.sender);
    }

    function tokenURI(
        uint256 /*tokenId*/
    ) public pure override returns (string memory) {
        string memory baseURI = _baseURI();
        return baseURI;
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://ipfs.io/ipfs/QmSSbXvkYaz7v8oVAN8SJdDPk1FVKT2ws4cv2De9brBFCF";
    }
}
