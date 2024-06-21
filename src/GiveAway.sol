// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {VRFConsumerBaseV2Plus} from "lib/chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "lib/chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";
import {AutomationCompatibleInterface} from "lib/chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

contract GiveAway is
    ERC721,
    VRFConsumerBaseV2Plus,
    AutomationCompatibleInterface,
    ReentrancyGuard
{
    /* @author: SOUFIANE MASAD */
    /* @title: Give away smart contract */
    /* @description: 
        - this smart contract let a creator to create a give away
        - once the number of candidates is reached, the smart contract will randomly determine the winner and then reward him
        automatically
        - we will be using Chainlink VRF to use the randomness as well as Chainlink Automation to automize the process of
        winning  
    */

    /* CONSTANT VARIABLES */
    uint16 private constant requestConfirmations = 3;
    uint32 private constant numWords = 1;

    uint256 private s_subscriptionId =
        44093515583056640969191475247853284249830484101019387866061058522513777347172;
    uint256 private s_randomNumberGenerated;
    address private immutable vrfCoordinator =
        0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B; // SEPOLIA NETWORK
    bytes32 private immutable s_keyHash =
        0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae; // SEPLOIA keyHash => 750 Gwei
    uint32 private immutable callbackGasLimit = 40000;

    address private immutable i_owner;
    address[] private participants;
    uint256 private numberOfParticipants;
    uint256 public startTime;
    uint256 private tokenId;

    error NumberOfParticipantsReached();
    error NumberOfParticipantsNotReachedYet();

    event winnerRewarded(address indexed winner, uint256 tokenid);

    modifier OnlyOwner() {
        require(msg.sender == i_owner, "You are not the smart contract owner!");
        _;
    }

    constructor()
        ERC721("GiveAway Token", "GVTK")
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        i_owner = msg.sender;
        startTime = block.timestamp;
        numberOfParticipants = 10;
    }

    function registerParticipant() external nonReentrant {
        if (numberOfParticipants <= participants.length) {
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

    function rewardWinner() public nonReentrant {
        if (participants.length < numberOfParticipants) {
            revert NumberOfParticipantsNotReachedYet();
        }
        tokenId = generateRandomNumber() % 10000;
        uint256 index = generateRandomNumber() % participants.length;
        address winner = participants[index];
        _safeMint(winner, tokenId);
        emit winnerRewarded(winner, tokenId);
    }

    /* CHAINLINK VRF TO GENERATE A RANDOM NUMBER TO BE USED FOR RANDOM ARTITS IDs*/
    function generateRandomNumber() internal returns (uint256) {
        uint256 randomNum = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );
        uint256[] memory _randomNumArray = new uint256[](1);
        _randomNumArray[0] = randomNum;
        fulfillRandomWords(randomNum, _randomNumArray);
        return randomNum;
    }

    function fulfillRandomWords(
        uint256,
        uint256[] memory randomWords
    ) internal override {
        s_randomNumberGenerated = randomWords[0];
    }

    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        upkeepNeeded = participants.length == numberOfParticipants;
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        if (participants.length == numberOfParticipants) {
            rewardWinner();
        }
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}
