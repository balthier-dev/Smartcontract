
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "hardhat/console.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ECIONFTCore is Initializable, ERC721Upgradeable, ERC721BurnableUpgradeable, ERC721URIStorageUpgradeable, AccessControlUpgradeable {
    
    using CountersUpgradeable for CountersUpgradeable.Counter;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant ADMIN_A_ROLE = keccak256("ADMIN_A");
    bytes32 public constant ADMIN_B_ROLE = keccak256("ADMIN_B");

    CountersUpgradeable.Counter private _tokenIdCounter;
    mapping(uint256 => uint256) private _createdAt;
    mapping(uint256 => string)  private _partCodes;

    function initialize() initializer public {
        __ERC721_init("ECIO NFT Core", "ECIO");
        __ERC721Burnable_init();
        __AccessControl_init();
        __ERC721URIStorage_init();
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _setupRole(ADMIN_A_ROLE, msg.sender);
        _setupRole(ADMIN_B_ROLE, msg.sender);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://metadata.ecio.space/items/";
    }

    function tokenInfo(uint256 tokenId) public view virtual returns (string memory, uint256) {
        return (_partCodes[tokenId], _createdAt[tokenId]);
    }


    function safeMint(address to, string memory partCode) public onlyRole (MINTER_ROLE) {
        _safeMint(to, _tokenIdCounter.current());
        _partCodes[_tokenIdCounter.current()] = partCode;
        _createdAt[_tokenIdCounter.current()] = block.timestamp;
        _tokenIdCounter.increment();
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function transfer(
        address _contractAddress,
        address _to,
        uint256 _amount
    ) public onlyRole (DEFAULT_ADMIN_ROLE) {
        IERC20 _token = IERC20(_contractAddress);
        _token.transfer(_to, _amount);
    }
}