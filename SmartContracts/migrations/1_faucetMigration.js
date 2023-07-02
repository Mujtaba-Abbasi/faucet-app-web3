/** @format */

//gets the bytecode of the smart contract
const FaucetContract = artifacts.require("Faucet");

module.exports = function (deployer) {
  deployer.deploy(FaucetContract);
};
