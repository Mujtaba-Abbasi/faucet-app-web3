/** @format */
const OwnerContract = artifacts.require("Owned");
module.exports = function (deployer) {
  deployer.deploy(OwnerContract);
};
