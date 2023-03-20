
const hre = require("hardhat");

async function main() {
  // We get the contract to deploy
  const H = await hre.ethers.getContractFactory("H");
  const h = await H.deploy();
  await h.deployed();
  console.log("h deployed to:", h.address);

  const I = await hre.ethers.getContractFactory("I");
  const i = await I.deploy();
  await i.deployed();
  console.log("i deployed to:", i.address);

  const J = await hre.ethers.getContractFactory("J");
  const j = await J.deploy();
  await j.deployed();
  console.log("j deployed to:", j.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
