// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SimpleERC20} from "../src/SimpleERC20.sol";

contract SimpleERC20Script is Script {
    SimpleERC20 public erc20;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        erc20 = new SimpleERC20("Simple ERC20", "SIMPLE", 18, 1000000 * 10**18);

        vm.stopBroadcast();
    }
}
