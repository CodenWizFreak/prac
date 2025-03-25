// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    // Define the token details
    string public name = "SimpleToken";
    string public symbol = "STK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // Mapping of addresses to balances
    mapping(address => uint256) public balanceOf;

    // Mapping of addresses allowed to spend on behalf of others
    mapping(address => mapping(address => uint256)) public allowance;

    // Events to log transfers and approvals
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor to mint initial tokens to the contract's creator
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10 ** uint256(decimals);  // Adjust for decimals
        balanceOf[msg.sender] = totalSupply;  // Send all initial tokens to the contract's creator
    }

    // Transfer tokens to another address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;  // Subtract tokens from sender
        balanceOf[_to] += _value;         // Add tokens to recipient

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Allow another address to spend tokens on your behalf
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Transfer tokens on behalf of someone else (using allowance)
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_from != address(0), "Invalid address");
        require(_to != address(0), "Invalid address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

        balanceOf[_from] -= _value;                          // Subtract tokens from sender
        balanceOf[_to] += _value;                            // Add tokens to recipient
        allowance[_from][msg.sender] -= _value;             // Decrease allowance

        emit Transfer(_from, _to, _value);
        return true;
    }

    // Mint new tokens (only accessible by the contract owner)
    function mint(uint256 _amount) public returns (bool success) {
        // You can implement access control here (e.g., only the owner can mint)
        totalSupply += _amount * 10 ** uint256(decimals);
        balanceOf[msg.sender] += _amount * 10 ** uint256(decimals);
        emit Transfer(address(0), msg.sender, _amount * 10 ** uint256(decimals));
        return true;
    }
}
