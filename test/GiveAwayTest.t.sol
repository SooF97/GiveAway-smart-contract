// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {GiveAwayDeploy} from "../script/GiveAwayDeploy.s.sol";
import {GiveAway} from "../src/GiveAway.sol";

contract GiveAwayTest is Test {
    GiveAway giveAway;
    // GiveAwayDeploy giveAwayDeploy;
    address deployer = 0x3276b0f9e5E6A8968e8c01FD735b41fdA229c2be;

    function setUp() public {
        // giveAwayDeploy = new GiveAwayDeploy();
        vm.startPrank(deployer);
        giveAway = new GiveAway();
        vm.stopPrank();
    }

    function testStartTime() public {
        assertEq(giveAway.startTime(), block.timestamp);
        emit log_uint(giveAway.startTime());
        emit log_uint(block.timestamp);
    }

    function testOwnerOfTheDeployedSmartContract() public returns (address) {
        assertEq(giveAway.getOwner(), deployer);
        emit log("The smart contract owner address:");
        emit log_address(giveAway.getOwner());
        emit log("The deployer address:");
        emit log_address(deployer);
        return giveAway.getOwner();
    }
}
