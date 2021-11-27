# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```


## Migrate
```sol
npx hardhat compile
npx hardhat run scripts/sample-script.js --network testnet
npx hardhat  verify --network testnet {CONTRACT_ADDRESS} --contract contracts/Market.sol:Market
```
npx hardhat  verify --network testnet 0x5bAa6FaF5BeB33D154598560f04196074954bD5C --contract contracts/ECIONFTCore.sol:ECIONFTCore