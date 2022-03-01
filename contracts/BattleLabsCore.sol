//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./helper/Helper.sol";
import "hardhat/console.sol";

interface ECIOERC721 {
    function tokenInfo(uint256 _tokenId)
        external
        view
        returns (string memory, uint256);

    function safeMint(address to, string memory partCode) external;
}

interface RANDOM_CONTRACT {
    function startRandom() external returns (uint256);
}

interface RANDOM_RATE {
    function getRNGPool(uint16 _part, uint16 _number)
        external
        view
        returns (uint16);
}

contract BattleLabsCore is Ownable, ECIOHelper {
    struct Info {
        string partCode;
        uint256 createAt;
    }

    // Part Code Index
    uint256 constant PC_NFT_TYPE = 12;
    uint256 constant PC_KINGDOM = 11;
    uint256 constant PC_CAMP = 10;
    uint256 constant PC_GEAR = 9;
    uint256 constant PC_DRONE = 8;
    uint256 constant PC_SUITE = 7;
    uint256 constant PC_BOT = 6;
    uint256 constant PC_GENOME = 5;
    uint256 constant PC_WEAPON = 4;
    uint256 constant PC_STAR = 3;
    uint256 constant PC_EQUIPMENT = 2;
    uint256 constant PC_RESERVED1 = 1;
    uint256 constant PC_RESERVED2 = 0;

    address public nftCoreContract;
    address public ecioTokenContract;
    address public lakrimaTokenContract;
    address public randomWorkerContract;
    address public randomRateContract;

    uint16 public ratePerFragment;

    uint256 randomNumber;

    uint256 public ecioPrice = 10000 * 10**18;
    uint256 public lakrimaPrice = 25000 * 10**18;

    // Fragment[] fragments;

    //Setup
    function updateNFTsContract(address _address) public onlyOwner {
        nftCoreContract = _address;
    }

    function changeEcioTokenContract(address _address) public onlyOwner {
        ecioTokenContract = _address;
    }

    function changeLakrimaTokenContract(address _address) public onlyOwner {
        lakrimaTokenContract = _address;
    }

    function updateRandomWorkerContract(address _address) public onlyOwner {
        randomWorkerContract = _address;
    }

    function updateRandomRateContract(address _address) public onlyOwner {
        randomRateContract = _address;
    }

    function updateLakrimaPrice(uint256 price) public onlyOwner {
        lakrimaPrice = price;
    }

    function updateEcioPrice(uint256 price) public onlyOwner {
        ecioPrice = price;
    }

    function setRatePerFragment(uint16 rate) public onlyOwner {
        ratePerFragment = rate;
    }

    //Forge Fragment
    function battleLabsWeaponForge(
        uint256 warriorId,
        uint256[] memory tokenIds
    ) public returns (bool success) {
        require(
            checkWarrior(getPartInfo(warriorId)) == true,
            "Please use Warrior to upgrade."
        );
        uint256 _balanceEcio = IERC20(ecioTokenContract).balanceOf(msg.sender);
        require(
            _balanceEcio >= ecioPrice * tokenIds.length,
            "ECIO: Your balance is insufficient."
        );
        uint256 _balanceLakrima = IERC20(lakrimaTokenContract).balanceOf(
            msg.sender
        );
        require(
            _balanceLakrima >= lakrimaPrice * tokenIds.length,
            "LAKRIMA: Your balance is insufficient."
        );
        address ownerWarrior = ERC721(nftCoreContract).ownerOf(warriorId);
        require(ownerWarrior == msg.sender, "You are not owner of Warrior.");
        string memory firstPartCode;
        for (uint256 index = 0; index < tokenIds.length; index++) {
            // address owner = ERC721(nftCoreContract).ownerOf(tokenIds[index]);
            require(
                ERC721(nftCoreContract).ownerOf(tokenIds[index]) == msg.sender,
                "You are not owner."
            );
            string memory partCode = getPartInfo(tokenIds[index]);
            if (index != 0) {
                require(
                    keccak256(bytes(firstPartCode)) ==
                        keccak256(bytes(partCode)),
                    "Please use same fragment to forge."
                );
            } else {
                firstPartCode = partCode;
            }
            ERC721(nftCoreContract).transferFrom(
                msg.sender,
                address(this),
                tokenIds[index]
            );
            if (index == tokenIds.length - 1) {
                IERC20(ecioTokenContract).transferFrom(
                    msg.sender,
                    address(this),
                    ecioPrice * tokenIds.length
                );
                IERC20(lakrimaTokenContract).transferFrom(
                    msg.sender,
                    address(this),
                    lakrimaPrice * tokenIds.length
                );
                uint16 rate = uint16(tokenIds.length) * ratePerFragment;
                if (rate >= 100) {
                    string memory oldPartCode = getPartInfo(warriorId);
                    ERC721(nftCoreContract).transferFrom(
                        msg.sender,
                        address(this),
                        warriorId
                    );
                    string memory newWarriorPartCode = _partReplace(
                        oldPartCode,
                        PC_WEAPON,
                        firstPartCode
                    );
                    ECIOERC721(nftCoreContract).safeMint(
                        msg.sender,
                        newWarriorPartCode
                    );
                    return true;
                } else {
                    randomNumber = RANDOM_CONTRACT(randomWorkerContract)
                        .startRandom();
                    // uint16 randomNumberForNFTType = getNumberAndMod(randomNumber, 5, 1000);
                    uint16 randomResult = RANDOM_RATE(randomRateContract)
                        .getRNGPool(5, getNumberAndMod(randomNumber, 5, 1000));
                    if (rate > randomResult) {
                        // partCodeCheck
                        string memory oldPartCode = getPartInfo(warriorId);
                        ERC721(nftCoreContract).transferFrom(
                            msg.sender,
                            address(this),
                            warriorId
                        );
                        string memory newWarriorPartCode = _partReplace(
                            oldPartCode,
                            PC_WEAPON,
                            firstPartCode
                        );
                        ECIOERC721(nftCoreContract).safeMint(
                            msg.sender,
                            newWarriorPartCode
                        );
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        }
    }

    //Forge Fragment
    function battleLabsSuiteForge(
        uint256 warriorId,
        uint256[] memory tokenIds
    ) public returns (bool success) {
        require(
            checkWarrior(getPartInfo(warriorId)) == true,
            "Please use Warrior to upgrade."
        );
        uint256 _balanceEcio = IERC20(ecioTokenContract).balanceOf(msg.sender);
        require(
            _balanceEcio >= ecioPrice * tokenIds.length,
            "ECIO: Your balance is insufficient."
        );
        uint256 _balanceLakrima = IERC20(lakrimaTokenContract).balanceOf(
            msg.sender
        );
        require(
            _balanceLakrima >= lakrimaPrice * tokenIds.length,
            "LAKRIMA: Your balance is insufficient."
        );
        address ownerWarrior = ERC721(nftCoreContract).ownerOf(warriorId);
        require(ownerWarrior == msg.sender, "You are not owner of Warrior.");
        string memory firstPartCode;
        for (uint256 index = 0; index < tokenIds.length; index++) {
            // address owner = ERC721(nftCoreContract).ownerOf(tokenIds[index]);
            require(
                ERC721(nftCoreContract).ownerOf(tokenIds[index]) == msg.sender,
                "You are not owner."
            );
            string memory partCode = getPartInfo(tokenIds[index]);
            if (index != 0) {
                require(
                    keccak256(bytes(firstPartCode)) ==
                        keccak256(bytes(partCode)),
                    "Please use same fragment to forge."
                );
            } else {
                firstPartCode = partCode;
            }
            ERC721(nftCoreContract).transferFrom(
                msg.sender,
                address(this),
                tokenIds[index]
            );
            if (index == tokenIds.length - 1) {
                IERC20(ecioTokenContract).transferFrom(
                    msg.sender,
                    address(this),
                    ecioPrice * tokenIds.length
                );
                IERC20(lakrimaTokenContract).transferFrom(
                    msg.sender,
                    address(this),
                    lakrimaPrice * tokenIds.length
                );
                uint16 rate = uint16(tokenIds.length) * ratePerFragment;
                if (rate >= 100) {
                    string memory oldPartCode = getPartInfo(warriorId);
                    ERC721(nftCoreContract).transferFrom(
                        msg.sender,
                        address(this),
                        warriorId
                    );
                    string memory newWarriorPartCode = _partReplace(
                        oldPartCode,
                        PC_SUITE,
                        firstPartCode
                    );
                    ECIOERC721(nftCoreContract).safeMint(
                        msg.sender,
                        newWarriorPartCode
                    );
                    return true;
                } else {
                    randomNumber = RANDOM_CONTRACT(randomWorkerContract)
                        .startRandom();
                    // uint16 randomNumberForNFTType = getNumberAndMod(randomNumber, 5, 1000);
                    uint16 randomResult = RANDOM_RATE(randomRateContract)
                        .getRNGPool(5, getNumberAndMod(randomNumber, 5, 1000));
                    if (rate > randomResult) {
                        // partCodeCheck
                        string memory oldPartCode = getPartInfo(warriorId);
                        ERC721(nftCoreContract).transferFrom(
                            msg.sender,
                            address(this),
                            warriorId
                        );
                        string memory newWarriorPartCode = _partReplace(
                            oldPartCode,
                            PC_SUITE,
                            firstPartCode
                        );
                        ECIOERC721(nftCoreContract).safeMint(
                            msg.sender,
                            newWarriorPartCode
                        );
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        }
    }


    function getPartInfo(uint256 tokenId) private view returns (string memory) {
        Info memory tokenInfo;
        (tokenInfo.partCode, tokenInfo.createAt) = ECIOERC721(nftCoreContract)
            .tokenInfo(tokenId);
        return tokenInfo.partCode;
    }

    function checkWarrior(string memory warrior) internal pure returns (bool) {
        string[] memory warriorPartCodes = splitPartCode(warrior);
        string memory partType = warriorPartCodes[PC_NFT_TYPE];
        if (keccak256(bytes(partType)) == keccak256(bytes("06"))) {
            return true;
        } else {
            return false;
        }
    }

    function checkFragment(string memory warrior) internal pure returns (bool) {
        string[] memory warriorPartCodes = splitPartCode(warrior);
        string memory partType = warriorPartCodes[PC_NFT_TYPE];
        if (keccak256(bytes(partType)) == keccak256(bytes("02"))) {
            return true;
        } else {
            return false;
        }
    }

    function _partReplace(
        string memory oldPartCode,
        uint256 _pos,
        string memory fragmentPartCode
    ) internal pure returns (string memory) {
        bytes memory _stringBytes = bytes(oldPartCode);
        bytes memory result = new bytes(_stringBytes.length); //00000000001712110000000006

        string[] memory splittedPartCodes = splitPartCode(fragmentPartCode); //00000800120000000000000002
        string memory _part = splittedPartCodes[_pos]; //12

        for (uint256 i = 0; i < _stringBytes.length; i++) {
            result[i] = _stringBytes[i];
            if (i == _pos * 2) {
                result[i] = bytes(_part)[0];
            }
            if (i == _pos * 2 + 1) {
                result[i] = bytes(_part)[1];
            }
        }
        return string(result);
    }

    function transferFee(
        address _contractAddress,
        address _to,
        uint256 _amount
    ) public onlyOwner {
        IERC20 _token = IERC20(_contractAddress);
        _token.transfer(_to, _amount);
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
            return
                uint16(((_ranNum % 10000000000000000) / 1000000000000) % mod);
        } else if (digit == 5) {
            return
                uint16(
                    ((_ranNum % 100000000000000000000) / 10000000000000000) %
                        mod
                );
        } else if (digit == 6) {
            return
                uint16(
                    ((_ranNum % 1000000000000000000000000) /
                        100000000000000000000) % mod
                );
        } else if (digit == 7) {
            return
                uint16(
                    ((_ranNum % 10000000000000000000000000000) /
                        1000000000000000000000000) % mod
                );
        } else if (digit == 8) {
            return
                uint16(
                    ((_ranNum % 100000000000000000000000000000000) /
                        10000000000000000000000000000) % mod
                );
        }

        return 0;
    }
}
