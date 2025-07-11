// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV1} from "../src/CounterV1.sol";

contract CounterV1Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        Upgrades.deployUUPSProxy("CounterV1.sol", abi.encodeCall(CounterV1.initialize, ()));

        vm.stopBroadcast();
    }
}
