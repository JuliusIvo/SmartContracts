const newContract = artifacts.require("./newContract.sol");

module.exports = function (deployer) {
    deployer.deploy(newContract);
  }