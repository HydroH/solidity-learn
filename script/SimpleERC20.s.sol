// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SimpleERC20} from "../src/SimpleERC20.sol";

contract SimpleERC20Script is Script {
    SimpleERC20 public token;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        token = new SimpleERC20("Simple Token", "SIMPLE", 18, 1000000 * 10 ** 18);

        vm.stopBroadcast();
    }
}
