// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleERC20 {
    string name;
    string symbol;
    uint8 immutable decimals;
    uint256 immutable totalSupply;

    mapping(address => uint256) private _balances;
    // Allowances mapping: owner => spender => amount
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 totalSupply_) {
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
        totalSupply = totalSupply_;
        _balances[msg.sender] = totalSupply_;
        emit Transfer(address(0), msg.sender, totalSupply_);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    error InsufficientBalance(uint256 requested, uint256 available);
    error InsufficientAllowance(uint256 requested, uint256 available);

    function balanceOf(address owner) public view returns (uint256 balance) {
        return _balances[owner];
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        uint256 balance = _balances[msg.sender];
        require(balance >= value, InsufficientBalance(value, balance));
        _balances[msg.sender] = balance - value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        uint256 allowance = _allowances[from][msg.sender];
        require(allowance >= value, InsufficientAllowance(value, allowance));
        uint256 balance = _balances[from];
        require(balance >= value, InsufficientBalance(value, balance));

        _allowances[from][msg.sender] = allowance - value;
        _balances[from] = balance - value;
        _balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool success) {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256 remaining) {
        return _allowances[owner][spender];
    }
}
