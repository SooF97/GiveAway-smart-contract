// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {GiveAway} from "../src/GiveAway.sol";

contract GiveAwayDeploy is Script {
    GiveAway giveAway;

    function setUp() public {}

    function run() public returns (GiveAway) {
        vm.startBroadcast(0x3276b0f9e5E6A8968e8c01FD735b41fdA229c2be);
        giveAway = new GiveAway();
        vm.stopBroadcast();
        return giveAway;
    }
}
