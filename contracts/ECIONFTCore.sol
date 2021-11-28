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

contract ECIONFTCore is
    Initializable,
    ERC721Upgradeable,
    ERC721BurnableUpgradeable,
    ERC721URIStorageUpgradeable,
    AccessControlUpgradeable
{
    using CountersUpgradeable for CountersUpgradeable.Counter;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant DEV_ROLE = keccak256("DEV_ROLE");
    
    CountersUpgradeable.Counter private tokenIdCounter;
    mapping(uint256 => uint256) private createdAt;
    mapping(uint256 => string) private partCodes;
    mapping(address => bool) public operators;

    function initialize() public initializer {
        __ERC721_init("ECIO Space NFT", "ECIO");
        __ERC721Burnable_init();
        __AccessControl_init();
        __ERC721URIStorage_init();

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _setupRole(DEV_ROLE, msg.sender);
 
        //start tokenId at 5000
        for (uint256 i = 0; i < 5000; i++) {
             tokenIdCounter.increment();
        }
    }

    modifier onlyOperatorAddress() {
        require(operators[msg.sender] == true);
        _;
    }

    function addOperatorAddress(address _address)
        public
        onlyRole(DEV_ROLE)
    {
        operators[_address] = true;
    }

    function removeOperatorAddress(address _address)
        public
        onlyRole(DEV_ROLE)
    {
        operators[_address] = false;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://metadata.ecio.space/items/";
    }

    function tokenInfo(uint256 _tokenId)
        public
        view
        virtual
        returns (string memory, uint256)
    {
        return (partCodes[_tokenId], createdAt[_tokenId]);
    }

    function migrateNFTV1(
        address _to,
        string memory _partCode,
        uint256 _tokenId,
        uint256 _createdAt
    ) public onlyRole(DEV_ROLE) {
        _safeMint(_to, _tokenId);
        partCodes[_tokenId] = _partCode;
        createdAt[_tokenId] = _createdAt;
    }

    function safeMint(address _to, string memory _partCode)
        public
        onlyRole(MINTER_ROLE)
    {
        _safeMint(_to, tokenIdCounter.current());
        partCodes[tokenIdCounter.current()] = _partCode;
        createdAt[tokenIdCounter.current()] = block.timestamp;
        tokenIdCounter.increment();
    }

    function _burn(uint256 _tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(_tokenId);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(_tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setApprovalForAll(
        address _operator,
        bool _approved
    ) public override(ERC721Upgradeable) {
        require(operators[_operator] == true);
        super.setApprovalForAll(_operator, _approved);
        
    }

    function approve(address _to, uint256 _tokenId) public virtual override(ERC721Upgradeable) {
        require(operators[_to] == true);
        super.approve(_to, _tokenId);
    }

    function transfer(
        address _contractAddress,
        address _to,
        uint256 _amount
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        IERC20 _token = IERC20(_contractAddress);
        _token.transfer(_to, _amount);
    }
}
