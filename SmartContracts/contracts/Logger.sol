//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Logger {
    function emitLog() public pure virtual returns (bytes32);

    function test3() internal pure returns (uint256) {
        return 200;
    }
}

/*
Similar to C++ : when we creat an abstract interface containing
an virtual function without any implementation
this will be implemented in the contract that in inheriting this abstract interface.
pure: doesn't make any changes to the state */

//* private : Can only be accessed within the contract
//* internal : Can only be accessed within the contracts that are inheriting from this
//* public : Can only access from anywhere
//* external : can be accessed by other contracts
