testnet-deploy:
	npx hardhat compile
	npx hardhat run scripts/sample-script.js --network testnet
compile:
	npx hardhat compile



test:
 	npx hardhat test