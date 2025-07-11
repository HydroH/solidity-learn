// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Upgrades, Options} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV2} from "../src/CounterV2.sol";

contract CounterV2Script is Script {
    function setUp() public {}

    function run(address proxy) public {
        vm.startBroadcast();

        Options memory opts;
        opts.referenceContract = "CounterV1.sol";
        Upgrades.upgradeProxy(proxy, "CounterV2.sol", abi.encodeCall(CounterV2.initializeV2, ()), opts);

        vm.stopBroadcast();
    }
}
