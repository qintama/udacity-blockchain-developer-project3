const HarvesterRole = artifacts.require("HarvesterRole");
const DistributerRole = artifacts.require("DistributerRole");
const RetailerRole = artifacts.require("RetailerRole");
const CustomerRole = artifacts.require("CustomerRole");
const SupplyChain = artifacts.require("SupplyChain");

module.exports = function(deployer) {
  deployer.deploy(HarvesterRole);
  deployer.deploy(DistributerRole);
  deployer.deploy(RetailerRole);
  deployer.deploy(CustomerRole);
  deployer.deploy(SupplyChain);
};
