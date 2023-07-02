//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Owned {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "You must be onwer to call this function!"
        );
        _;
    }
}
