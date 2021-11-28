// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface ERC1155_CONTRACT {
    function balanceOf(address account, uint256 id)
        external
        view
        returns (uint256);

    function safeMint(address to, string memory partCode) external;

    function burn(
        address account,
        uint256 id,
        uint256 value
    ) external;
}

interface ERC721_CONTRACT {
    function safeMint(address to, string memory partCode) external;
}

interface RANDOM_CONTRACT {
    function startRandom() external returns (uint256);
}

interface RANDOM_RATE {
    function getGenPool(
        uint16 _nftType,
        uint16 _rarity,
        uint16 _number
    ) external view returns (uint16);

    function getNFTPool(uint16 _nftType, uint16 _number)
        external
        view
        returns (uint16);

    function getEquipmentPool(uint16 _number) external view returns (uint16);

    function getBlueprintPool(
        uint16 _nftType,
        uint16 _rarity,
        uint16 eTypeId,
        uint16 _number
    ) external view returns (uint16);

    function getSpaceWarriorPool(
        uint16 _part,
        uint16 _nftType,
        uint16 _number
    ) external view returns (uint16);
}

contract BoxRedemption is Ownable {
    using Strings for string;
    uint8 private constant NFT_TYPE = 0; //Kingdom
    uint8 private constant KINGDOM = 1; //Kingdom
    uint8 private constant TRANING_CAMP = 2; //Training Camp
    uint8 private constant GEAR = 3; //Battle Gear
    uint8 private constant DRO = 4; //Battle DRO
    uint8 private constant SUITE = 5; //Battle Suit
    uint8 private constant BOT = 6; //Battle Bot
    uint8 private constant GEN = 7; //Human GEN
    uint8 private constant WEAP = 8; //WEAP
    uint8 private constant COMBAT_RANKS = 9; //Combat Ranks
    uint8 private constant BLUEPRINT_COMM = 0;
    uint8 private constant BLUEPRINT_RARE = 1;
    uint8 private constant BLUEPRINT_EPIC = 2;
    uint8 private constant GENOMIC_COMMON = 3;
    uint8 private constant GENOMIC_RARE = 4;
    uint8 private constant GENOMIC_EPIC = 5;
    uint8 private constant SPACE_WARRIOR = 6;
    uint8 private constant COMMON = 0;
    uint8 private constant RARE = 1;
    uint8 private constant EPIC = 2;
    uint8 private constant SPACIAL = 3;

    mapping(uint256 => address) ranNumToSender;
    mapping(uint256 => uint256) requestToNFTId;

    event OpenBox(address _by, uint256 _nftId, string partCode);
    event ChangeRandomRateContract(uint256 _nftType ,address _address);
    event ChangeMysteryBoxContract(address _address);
    event ChangeNftCoreContract(address _address);
    event ChangeRandomWorkerContract(address _address);

    address public mysteryBoxContract;
    address public nftCoreContract;
    address public randomWorkerContract;
    mapping(uint256 => address) public randomRateAddress;

    constructor() {}

    function changeRandomWorkerContract(address _address) public onlyOwner {
        randomWorkerContract = _address;
        emit ChangeRandomWorkerContract(_address);
    }

    function changeMysteryBoxContract(address _address) public onlyOwner {
        mysteryBoxContract = _address;
        emit ChangeMysteryBoxContract(_address);
    }

    function changeNftCoreContract(address _address) public onlyOwner {
        nftCoreContract = _address;
        emit ChangeNftCoreContract(_address);
    }

    function changeRandomRateCommonBox(address _address) public onlyOwner {
        randomRateAddress[COMMON] = _address;
        emit ChangeRandomRateContract(COMMON, _address);
    }

    function changeRandomRateRareBox(address _address) public onlyOwner {
        randomRateAddress[RARE] = _address;
        emit ChangeRandomRateContract(RARE, _address);
    }

    function changeRandomRateEpicBox(address _address) public onlyOwner {
        randomRateAddress[EPIC] = _address;
        emit ChangeRandomRateContract(EPIC,_address);
    }

    function changeRandomRateSpacialBox(address _address) public onlyOwner {
        randomRateAddress[SPACIAL] = _address;
        emit ChangeRandomRateContract(SPACIAL, _address);
    }

    function burnAndMint(
        ERC1155_CONTRACT _token,
        uint16 _id
    ) internal {
        uint256 _randomNumber = RANDOM_CONTRACT(randomWorkerContract)
            .startRandom();

        _token.burn(msg.sender, _id, 1);

        string memory _partCode = createNFTCode(_randomNumber, _id);
        mintNFT(msg.sender, _partCode);
        emit OpenBox(msg.sender, _id, _partCode);
    }

    function openBox(uint16 _id) public {
        ERC1155_CONTRACT _token = ERC1155_CONTRACT(mysteryBoxContract);
        uint256 _balance = _token.balanceOf(msg.sender, _id);
        require(_balance >= 1, "Your balance is insufficient.");
        burnAndMint(_token, _id);
    }

    function mintNFT(address to, string memory concatedCode) private {
        ERC721_CONTRACT _nftCore = ERC721_CONTRACT(nftCoreContract);
        _nftCore.safeMint(to, concatedCode);
    }

    function createGenomic(
        uint16 _nftType,
        uint16 _nftTypeCode,
        uint16 _number,
        uint16 _rarity
    ) private view returns (string memory) {
        //uint256 genomicType = GenPool[_id][_rarity][_number];
        uint16 genomicType = RANDOM_RATE(randomRateAddress[_nftType]).getGenPool(_nftType, _rarity, _number);
        return
            createPartCode(
                0,
                0, //combatRanksCode
                0, //WEAPCode
                genomicType, //humanGENCode
                0, //battleBotCode
                0, //battleSuiteCode
                0, //battleDROCode
                0, //battleGearCode
                0, //trainingCode
                0, //kingdomCode
                _nftTypeCode
            );
    }

    function createNFTCode(uint256 _randomNumber, uint16 _nftType)
        internal
        view
        returns (string memory)
    {
        string memory partCode;
        uint16 randomNumberForNFTType = getNumberAndMod(_randomNumber, 1, 1000);
        uint16 nftTypeCode = RANDOM_RATE(randomRateAddress[_nftType]).getNFTPool(_nftType, randomNumberForNFTType);

        uint16 equipmentRandom = getNumberAndMod(_randomNumber, 2, 5);
        uint16 index = getNumberAndMod(_randomNumber, 3, 1000);
        uint16 eTypeId = RANDOM_RATE(randomRateAddress[_nftType]).getEquipmentPool(equipmentRandom);
        
        if (nftTypeCode == GENOMIC_COMMON) { //GENOMIC_COMMON
            partCode = createGenomic(_nftType, nftTypeCode, index, COMMON);

        } else if (nftTypeCode == GENOMIC_RARE) { //GENOMIC_RARE
            partCode = createGenomic(_nftType, nftTypeCode, index, RARE);

        } else if (nftTypeCode == GENOMIC_EPIC) { //GENOMIC_EPIC
            partCode = createGenomic(_nftType, nftTypeCode, index, EPIC);

        } else if (nftTypeCode == BLUEPRINT_COMM) { //BLUEPRINT_COMM
            uint16 ePartId = RANDOM_RATE(randomRateAddress[_nftType]).getBlueprintPool(
                _nftType,
                COMMON,
                eTypeId,
                index
            );
            partCode = createBlueprintPartCode(nftTypeCode, eTypeId, ePartId);
            
        } else if (nftTypeCode == BLUEPRINT_RARE) { //BLUEPRINT_RARE
            uint16 ePartId = RANDOM_RATE(randomRateAddress[_nftType]).getBlueprintPool(
                _nftType,
                RARE,
                eTypeId,
                index
            );
            partCode = createBlueprintPartCode(nftTypeCode, eTypeId, ePartId);

        } else if (nftTypeCode == BLUEPRINT_EPIC) { //BLUEPRINT_EPIC
            uint16 ePartId = RANDOM_RATE(randomRateAddress[_nftType]).getBlueprintPool(
                _nftType,
                EPIC,
                eTypeId,
                index
            );
            partCode = createBlueprintPartCode(nftTypeCode, eTypeId, ePartId);

        } else if (nftTypeCode == SPACE_WARRIOR) { //SPACE_WARRIOR
            partCode = createSW(_randomNumber, _nftType);
        }

        return partCode;
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
    
    function createSW(uint256 _randomNumber, uint16 _nftType)
        private
        view
        returns (string memory)
    {
      
        uint16 trainingId = getNumberAndMod(_randomNumber, 2, 1000);
        uint16 battleGearId = getNumberAndMod(_randomNumber, 3, 1000);
        uint16 battleDroneId  = getNumberAndMod(_randomNumber, 4, 1000);
        uint16 battleSuiteId = getNumberAndMod(_randomNumber, 5, 1000);
        uint16 battleBotId = getNumberAndMod(_randomNumber, 6, 1000);
        uint16 humanGenomeId = getNumberAndMod(_randomNumber, 7, 1000);
        uint16 weaponId = getNumberAndMod(_randomNumber, 8, 1000);
       
        string memory concatedCode = convertCodeToStr(6);
        concatedCode = concateCode(concatedCode, 0); //kingdomCode
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(TRANING_CAMP, _nftType, trainingId)
        );
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(GEAR, _nftType, battleGearId)
        );
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(DRO, _nftType, battleDroneId)
        );
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(SUITE, _nftType, battleSuiteId)
        );
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(BOT, _nftType, battleBotId)
        );
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(GEN, _nftType, humanGenomeId)
        );
        concatedCode = concateCode(
            concatedCode,
            RANDOM_RATE(randomRateAddress[_nftType]).getSpaceWarriorPool(WEAP, _nftType, weaponId)
        );
        concatedCode = concateCode(concatedCode, 0); //Star
        concatedCode = concateCode(concatedCode, 0); //equipmentCode
        concatedCode = concateCode(concatedCode, 0); //Reserved
        concatedCode = concateCode(concatedCode, 0); //Reserved
        return concatedCode;
    }

    function createBlueprintPartCode(
        uint16 nftTypeCode,
        uint16 equipmentTypeId,
        uint16 equipmentPartId
    ) private pure returns (string memory) {
        string memory partCode;

        if (equipmentTypeId == GEAR) {
            //Battle Gear
            partCode = createPartCode(
                equipmentTypeId, //equipmentTypeId
                0, //combatRanksCode
                0, //WEAPCode
                0, //humanGENCode
                0, //battleBotCode
                0, //battleSuiteCode
                0, //battleDROCode
                equipmentPartId, //battleGearCode
                0, //trainingCode
                0, //kingdomCode
                nftTypeCode
            );
        } else if (equipmentTypeId == DRO) {
            //battleDROCode
            partCode = createPartCode(
                equipmentTypeId, //equipmentTypeId
                0, //combatRanksCode
                0, //WEAPCode
                0, //humanGENCode
                0, //battleBotCode
                0, //battleSuiteCode
                equipmentPartId, //battleDROCode
                0, //battleGearCode
                0, //trainingCode
                0, //kingdomCode
                nftTypeCode
            );
        } else if (equipmentTypeId == SUITE) {
            //battleSuiteCode
            partCode = createPartCode(
                equipmentTypeId, //equipmentTypeId
                0, //combatRanksCode
                0, //WEAPCode
                0, //humanGENCode
                0, //battleBotCode
                equipmentPartId, //battleSuiteCode
                0, //battleDROCode
                0, //battleGearCode
                0, //trainingCode
                0, //kingdomCode
                nftTypeCode
            );
        } else if (equipmentTypeId == BOT) {
            //Battle Bot
            partCode = createPartCode(
                equipmentTypeId, //equipmentTypeId
                0, //combatRanksCode
                0, //WEAPCode
                0, //humanGENCode
                equipmentPartId, //battleBotCode
                0, //battleSuiteCode
                0, //battleDROCode
                0, //battleGearCode
                0, //trainingCode
                0, //kingdomCode
                nftTypeCode
            );
        } else if (equipmentTypeId == WEAP) {
            //WEAP
            partCode = createPartCode(
                equipmentTypeId, //equipmentTypeId
                0, //combatRanksCode
                equipmentPartId, //WEAPCode
                0, //humanGENCode
                0, //battleBotCode
                0, //battleSuiteCode
                0, //battleDROCode
                0, //battleGearCode
                0, //trainingCode
                0, //kingdomCode
                nftTypeCode
            );
        }

        return partCode;
    }

    function createPartCode(
        uint16 equipmentCode,
        uint16 starCode,
        uint16 weapCode,
        uint16 humanGENCode,
        uint16 battleBotCode,
        uint16 battleSuiteCode,
        uint16 battleDROCode,
        uint16 battleGearCode,
        uint16 trainingCode,
        uint16 kingdomCode,
        uint16 nftTypeCode
    ) internal pure returns (string memory) {
        string memory code = convertCodeToStr(nftTypeCode);
        code = concateCode(code, kingdomCode);
        code = concateCode(code, trainingCode);
        code = concateCode(code, battleGearCode);
        code = concateCode(code, battleDROCode);
        code = concateCode(code, battleSuiteCode);
        code = concateCode(code, battleBotCode);
        code = concateCode(code, humanGENCode);
        code = concateCode(code, weapCode);
        code = concateCode(code, starCode);
        code = concateCode(code, equipmentCode); //Reserved
        code = concateCode(code, 0); //Reserved
        code = concateCode(code, 0); //Reserved
        return code;
    }

    function concateCode(string memory concatedCode, uint256 digit)
        internal
        pure
        returns (string memory)
    {
        concatedCode = string(
            abi.encodePacked(convertCodeToStr(digit), concatedCode)
        );

        return concatedCode;
    }

    function convertCodeToStr(uint256 code)
        private
        pure
        returns (string memory)
    {
        if (code <= 9) {
            return string(abi.encodePacked("0", Strings.toString(code)));
        }

        return Strings.toString(code);
    }
}
