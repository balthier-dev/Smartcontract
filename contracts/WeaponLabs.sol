//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./helper/Helper.sol";
import "hardhat/console.sol";

interface ECIOERC721 {
    function tokenInfo(uint256 _tokenId)
        external
        view
        returns (string memory, uint256);
}
interface RANDOM_CONTRACT {
    function startRandom() external returns (uint256);
}

interface RANDOM_RATE {
    function getRNGPool(
        uint16 _part,
        uint16 _number
    ) external view returns (uint16);
}

contract WeaponLabs is Ownable, ECIOHelper {
    address public RandomRateContract;
    address public RandomWorkerContract;

    uint16 public ratePerPieces;
    uint256 public randomNumber;

    //Setup
    function changeRandomRateContract(address _address) public onlyOwner {
        RandomRateContract = _address;
    }

    function updateRandomWorkerContract(address contractAddress)
        public
        onlyOwner
    {
        RandomWorkerContract = contractAddress;
    }

    function setRatePerPiece(uint16 rate) public onlyOwner {
        ratePerPieces = rate;
    }

    //Forge Fragment
    function forgingWeapon(uint16 tokenAmount) public returns (bool) {
        uint16 rate = tokenAmount * ratePerPieces;
        if(rate >= 100){
            return true;
        }else{
            randomNumber = RANDOM_CONTRACT(RandomWorkerContract).startRandom();
            uint16 randomNumberForNFTType = getNumberAndMod(randomNumber, 5, 1000);
            uint16 randomResult = RANDOM_RATE(RandomRateContract).getRNGPool(5 , randomNumberForNFTType);
            if(rate > randomResult){
                return true;
            }else{
                return false;
            }
        }
    }

    function getNumberAndMod(
        uint256 _ranNum,
        uint16 digit,
        uint16 mod
    ) public view virtual returns (uint16) {
        if (digit == 1) {
            return uint16((_ranNum % 10000) % mod);
        } else if (digit == 2) {
            return uint16(((_ranNum % 100000000) / 10000) % mod);
        } else if (digit == 3) {
            return uint16(((_ranNum % 1000000000000) / 100000000) % mod);
        } else if (digit == 4) {
            return uint16(((_ranNum % 10000000000000000) / 1000000000000) % mod);
        } else if (digit == 5) {
            return uint16(((_ranNum % 100000000000000000000) / 10000000000000000) % mod);
        } else if (digit == 6) {
            return uint16(((_ranNum % 1000000000000000000000000) / 100000000000000000000) % mod);
        } else if (digit == 7) {
            return uint16(((_ranNum % 10000000000000000000000000000) / 1000000000000000000000000) % mod);
        } else if (digit == 8) {
            return uint16(((_ranNum % 100000000000000000000000000000000) / 10000000000000000000000000000) % mod);
        }

        return 0;
    }
}
