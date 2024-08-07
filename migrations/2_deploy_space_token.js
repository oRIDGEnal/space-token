const SpaceCoin = artifacts.require("SpaceCoin");

module.exports = (deployer, network, accounts) => {
  const cap = web3.utils.toWei("100000000", "ether"); // Market Cap
  const initialOwner = accounts[0]; // Uses first account as owner of contract

  // Deploy
  deployer.deploy(SpaceCoin, cap, initialOwner);
};
