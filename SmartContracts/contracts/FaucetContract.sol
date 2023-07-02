//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
    uint256 public numberOfFunders;
    mapping(address => bool) private funders;
    mapping(uint256 => address) private lutFunders;

    modifier limit(uint256 withdrawAmount) {
        require(
            withdrawAmount <= 100000000000000000,
            "Cannot withdraw. Withdraw limit exceeded!"
        );
        _;
    }

    function transferOwnership(address newOwner) external {}

    function test1() external onlyOwner {}

    function test2() external onlyOwner {}

    receive() external payable {}

    function emitLog() public pure override returns (bytes32) {
        return "Hello world!";
    }

    function addFunds() external payable override {
        address funder = msg.sender;
        if (!funders[funder]) {
            uint256 index = numberOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numberOfFunders);

        for (uint256 i = 0; i < numberOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }
        return _funders;
    }

    function getFunderAtIndex(uint256 index) external view returns (address) {
        return lutFunders[index];
    }

    function withdraw(uint256 withdrawAmount)
        external
        override
        limit(withdrawAmount)
    {
        payable(msg.sender).transfer(withdrawAmount);
    }
}

//* Functions:
//* test1() & test()2: only admin should have access to this.
//* AddFunder(): Checks if the sender is already added or not. If yes then won't add again else will add.
//* getAllFunders(): Creates and returns the array of addresses.
//* getFunderAtIndex(index): Returns an addess at the given index.
//* withdraw(withdrawAmount): Withdraw function

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

/* //* Truffle Console
 const instance = await Faucet.deployed()

 instance.addFunds({value:2000000000000000000 , from:accounts[0]})

 instance.withdraw("2000000000000000000", {from:accounts[1]})
 instance.withdraw("10000000000000000", {from:accounts[1]})

 instance.getFunderAtIndex(0)
 instance.getAllFunders

 instance.test1();
 instance.test1({from : accounts[1]});

 instance.emitLog()

*/

// * limit : Modifier
/* here we are check if the withdraw amout isn't within the limits or not. 
If it is the modifier will it to execute the rest of the code else it won't. 
_; : this shows that you want to execute the function body that is using the modifier
*/
