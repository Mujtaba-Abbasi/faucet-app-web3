//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Faucet1 {
    uint256 public numOfFunders;

    // mapping(uint256 => address) private funders;

    mapping(address => bool) private funders;

    receive() external payable {}

    function addFunder() external payable {
        // * userIndex - key to the mapping
        // uint256 userIndex = numOfFunders++;
        // funders[userIndex] = msg.sender;

        uint256 numberOfFunders;
        address funder = msg.sender;
        if (!funders[funder]) {
            numberOfFunders++;
            funders[funder] = true;
        }
    }

    // function getAllFunders() external view returns (address[] memory) {
    //     address[] memory _funders = new address[](numOfFunders);

    //     // * Iterating through to funders mapping to store it in an array
    //     for (uint256 i = 0; i < numOfFunders; i++) {
    //         _funders[i] = funders[i];
    //     }

    //     return _funders;
    // }

    // function getFunderAtIndex(uint8 index) external view returns (address) {
    //     return funders[index];
    // }
}

// * receive()
//when you want to make a nonspecific tx
// external are part of the contract interface
// can be accessed by other transactions

// * payable
//if you don't add payable, you won't be able to make transactions

// *pure view
//read only - no gas fee
//transactions - gas fee, state changes
//view: fx won't change the storage state
//pure: even more strict, it won't even read the storage state

// * External View
// external :Can only call outside the smart contract ,can't call this function inside the smart contract if you this as identifier
// public : can't call this function inside the smart contract if you this as identifier

//* Truffle Console
// const instance = await Faucet.deployed()
// instance.addFunder({value: 10000000, from:accounts[0]})
// instance.getFunderAtIndex(0)
// instance.getAllFunders
