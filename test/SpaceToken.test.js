const SpaceCoin = artifacts.require("SpaceCoin");

contract("SpaceCoin", (accounts) => {
  const [deployer, user1, user2] = accounts;

  it("deploys successfully", async () => {
    const spaceCoin = await SpaceCoin.deployed();
    assert(spaceCoin.address !== "");
  });

  it("has a correct name", async () => {
    const spaceCoin = await SpaceCoin.deployed();
    const name = await spaceCoin.name();
    assert.equal(name, "SpaceCoin");
  });

  it("has the correct symbol", async () => {
    const spaceCoin = await SpaceCoin.deployed();
    const symbol = await spaceCoin.symbol();
    assert.equal(symbol, "SCTX");
  });

  it("should assign the total supply of tokens to the owner", async () => {
    const spaceCoin = await SpaceCoin.deployed();
    const totalSupply = await spaceCoin.totalSupply();
    const ownerBalance = await spaceCoin.balanceOf(deployer);
    assert.equal(totalSupply.toString(), ownerBalance.toString());
  });

  it("should allow for transfer of token ownership", async () => {
    const spaceCoin = await SpaceCoin.deployed();
    let amount = web3.utils.toWei("1000", "ether");
    await spaceCoin.transfer(user1, amount, { from: deployer });
    const balance = await spaceCoin.balanceOf(user1);
    assert.equal(balance.toString(), amount);
  });
});
