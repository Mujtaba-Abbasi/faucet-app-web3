//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IFaucet {
    function addFunds() external payable;

    function withdraw(uint256 withdrawAmount) external;
}

/* Cannot inherit from other contract, 
cannot declare a vaiable, can only inherit from other interfaces
cannot declare a state variable,
all declared functions must be external
*/
