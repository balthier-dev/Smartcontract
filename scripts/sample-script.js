// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  //
  let contracts = ["MysteryBox", "ECIONFTCore", "BoxRedemption", "RandomRate"];

  for (let i = 0; i < contracts.length; i++) {
    const name = contracts[i];
    const contract = await hre.ethers.getContractFactory(name);
    const deployedContract = await contract.deploy();
    await deployedContract.deployed();
    console.log(name + " Address:", deployedContract.address);
    console.log("npx hardhat  verify --network testnet " + deployedContract.address + "  --contract contracts/" + name + ".sol:" + name)
  }

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
