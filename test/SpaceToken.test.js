const SpaceToken = artifacts.require("SpaceToken");

contract("SpaceToken", (accounts) => {
  const [deployer, user1, user2] = accounts;

  it("deploys successfully", async () => {
    const spaceToken = await SpaceToken.deployed();
    assert(spaceToken.address !== "");
  });

  it("has a correct name", async () => {
    const spaceToken = await SpaceToken.deployed();
    const name = await spaceToken.name();
    assert.equal(name, "SpaceToken");
  });

  it("has the correct symbol", async () => {
    const spaceToken = await SpaceToken.deployed();
    const symbol = await spaceToken.symbol();
    assert.equal(symbol, "SPTX");
  });

  it("should assign the total supply of tokens to the owner", async () => {
    const spaceToken = await SpaceToken.deployed();
    const totalSupply = await spaceToken.totalSupply();
    const ownerBalance = await spaceToken.balanceOf(deployer);
    assert.equal(totalSupply.toString(), ownerBalance.toString());
  });

  it("should allow for transfer of token ownership", async () => {
    const spaceToken = await SpaceToken.deployed();
    let amount = web3.utils.toWei("1000", "ether");
    await spaceToken.transfer(user1, amount, { from: deployer });
    const balance = await spaceToken.balanceOf(user1);
    assert.equal(balance.toString(), amount);
  });
});
