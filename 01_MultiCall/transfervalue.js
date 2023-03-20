
const {ethers} = require("hardhat");

async function main() {
  // We get the contract to deploy
//   const hAddress = '0x920507d260A7Eb5F6a4A862Ef25D6a78c1A2179C';
//   const iAddress = '0x8a03fEf993b04eF0ECD386fDa4e78998BC2A7506';
//   const jAddress = '0x4933A8caA4B1f51e4c144a811B5e720d30848589';
  const hAddress = '0xb140D9EaDFA587b7254EaAa07eD42Fd0DDf4A963';
  const iAddress = '0xd1e40cB517fFB8ebD0034d185A2130b9Ad249BDE';
  const jAddress = '0x308B0aC0E903a5190E3Df90Da187118A0Fd56553';


  const h = await ethers.getContractAt("H", hAddress); 
  const tx = await h.excute(iAddress, jAddress, 20, {gasLimit: 100000, value: 1000000000});
  await tx.wait();
  console.log("done, txhash ", tx.hash);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
