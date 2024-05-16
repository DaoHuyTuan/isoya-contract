// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../State/AccountState.sol";

contract Factory {
    address public owner;
    mapping(address => address) private list;
    constructor() {
        owner = msg.sender;
    }

    function create_account() external payable {
        AccountState newAccount = new AccountState(msg.sender);
        list[msg.sender] = address(newAccount);
    }
    
    function get_account() external view returns(address) {
        return list[msg.sender];
    }
}
