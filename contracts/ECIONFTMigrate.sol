// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ECIOERC721 {
    function tokenInfo(uint256 _tokenId)
        external
        view
        returns (string memory, uint256);

    function migrateNFTV1(address to, string memory partCode, uint256 tokenId, uint256 createAt) external;
}

contract ECIONFTMigrate is Ownable {
    address public NFTCoreV1;
    address public NFTCoreV2;

    function setupContract(address nftCoreV1, address nftCoreV2)
        public
        onlyOwner
    {
        NFTCoreV1 = nftCoreV1;
        NFTCoreV2 = nftCoreV2;
    }

    function migrateNFTV1(uint256 _tokenId) public {
        address ownerV1 = ERC721(NFTCoreV1).ownerOf(_tokenId);
        require(ownerV1 == msg.sender, "You is not owner");
        string memory partCode;
        uint256 id;
        (partCode, id) = ECIOERC721(NFTCoreV1).tokenInfo(_tokenId);
        ERC721(NFTCoreV1).transferFrom(msg.sender, address(this), _tokenId);
        ECIOERC721(NFTCoreV2).migrateNFTV1(msg.sender, partCode, _tokenId, id);
    }

    function migrateAllNFTV1(uint256[] memory tokenIds) public {
        for (uint256 index = 0; index < tokenIds.length; index++) {
            address ownerV1 = ERC721(NFTCoreV1).ownerOf(tokenIds[index]);
            require(
                ownerV1 == msg.sender,
                "You are not owner."
            );
            migrateNFTV1(tokenIds[index]);
        }
    }
}
