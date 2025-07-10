// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {SimpleERC20} from "../src/SimpleERC20.sol";

contract SimpleERC20Test is Test {
    SimpleERC20 public token;

    function setUp() public {
        token = new SimpleERC20("Test Token", "TEST", 18, 100);
    }

    function testConstruct() public {
        assertEq(token.name(), "Test Token");
        assertEq(token.symbol(), "TEST");
        assertEq(token.decimals(), 18);
        assertEq(token.totalSupply(), 100);
        assertEq(token.balanceOf(address(this)), 100);
    }

    function testTransfer() public {
        address from = address(this);
        address to = address(0);

        token.transfer(to, 10);
        assertEq(token.balanceOf(from), 90);
        assertEq(token.balanceOf(to), 10);

        token.transfer(to, 20);
        assertEq(token.balanceOf(from), 70);
        assertEq(token.balanceOf(to), 30);

        vm.expectRevert(abi.encodeWithSelector(SimpleERC20.InsufficientBalance.selector, 100, 70));
        token.transfer(to, 100);
    }

    function testTransferFrom() public {
        address from = address(this);
        address spender = address(0x123);
        address to = address(0);

        token.approve(spender, 40);

        vm.prank(spender);
        token.transferFrom(from, to, 10);
        assertEq(token.balanceOf(from), 90);
        assertEq(token.balanceOf(to), 10);
        assertEq(token.allowance(from, spender), 30);

        vm.prank(spender);
        token.transferFrom(from, to, 20);
        assertEq(token.balanceOf(from), 70);
        assertEq(token.balanceOf(to), 30);
        assertEq(token.allowance(from, spender), 10);

        vm.prank(spender);
        vm.expectRevert(abi.encodeWithSelector(SimpleERC20.InsufficientAllowance.selector, 20, 10));
        token.transferFrom(from, to, 20);

        token.approve(spender, 100);

        vm.prank(spender);
        vm.expectRevert(abi.encodeWithSelector(SimpleERC20.InsufficientBalance.selector, 100, 70));
        token.transferFrom(from, to, 100);

        vm.prank(spender);
        token.transferFrom(from, to, 70);
        assertEq(token.balanceOf(from), 0);
        assertEq(token.balanceOf(to), 100);
        assertEq(token.allowance(from, spender), 30);
    }
}
