// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRateSpacialBox is Ownable {
    using Strings for string;
    uint16 private constant NFT_TYPE = 0; //Kingdom
    uint16 private constant KINGDOM = 1; //Kingdom
    uint16 private constant TRANING_CAMP = 2; //Training Camp
    uint16 private constant GEAR = 3; //Battle Gear
    uint16 private constant DRO = 4; //Battle DRO
    uint16 private constant SUITE = 5; //Battle Suit
    uint16 private constant BOT = 6; //Battle Bot
    uint16 private constant GEN = 7; //Human GEN
    uint16 private constant WEAP = 8; //WEAP
    uint16 private constant COMBAT_RANKS = 9; //Combat Ranks
    uint16 private constant BLUEPRINT_COMM = 0;
    uint16 private constant BLUEPRINT_RARE = 1;
    uint16 private constant BLUEPRINT_EPIC = 2;
    uint16 private constant GENOMIC_COMMON = 3;
    uint16 private constant GENOMIC_RARE = 4;
    uint16 private constant GENOMIC_EPIC = 5;
    uint16 private constant SPACE_WARRIOR = 6;
    uint16 private constant COMMON_BOX = 0;
    uint16 private constant RARE_BOX = 1;
    uint16 private constant EPIC_BOX = 2;
    uint16 private constant SPECIAL_BOX = 3;
    uint16 private constant COMMON = 0;
    uint16 private constant RARE = 1;
    uint16 private constant EPIC = 2;

    //EPool
    mapping(uint16 => uint16) public EPool;

    mapping(uint16 => uint16[]) NFTPoolResults;
    mapping(uint16 => uint16[]) NFTPoolValues;
    mapping(uint16 => uint256[]) NFTPoolPercentage;

    mapping(uint16 => mapping(uint16 => uint256[])) GenPoolPercentage;
    mapping(uint16 => mapping(uint16 => uint16[])) GenPoolResults;
    mapping(uint16 => mapping(uint16 => uint16[])) GenPoolValues;

    mapping(uint16 => mapping(uint16 => mapping(uint16 => uint256[]))) BPPoolPercent;
    mapping(uint16 => mapping(uint16 => mapping(uint16 => uint16[]))) BPPoolResults;
    mapping(uint16 => mapping(uint16 => mapping(uint16 => uint16[]))) BPPoolValues;

    mapping(uint16 => mapping(uint16 => uint16[])) SWPoolResults;
    mapping(uint16 => mapping(uint16 => uint16[])) SWPoolValues;
    mapping(uint16 => mapping(uint16 => uint256[])) SWPoolPercentage;

    function initial() public onlyOwner {
        
        EPool[0] = GEAR; //Battle Gear
        EPool[1] = DRO; //Battle DRO
        EPool[2] = SUITE; //Battle Suit
        EPool[3] = BOT; //Battle Bot
        EPool[4] = WEAP; //WEAP

        //-----------------START SPECIAL BOX RATE --------------------------------

        NFTPoolResults[SPECIAL_BOX] = [SPACE_WARRIOR];
        NFTPoolPercentage[SPECIAL_BOX] = [uint256(10000)];

        //Assign mapping
        for (uint16 p = 0; p < NFTPoolPercentage[SPECIAL_BOX].length; p++) {
            uint256 qtyItem = (100 * NFTPoolPercentage[SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[SPECIAL_BOX].push(NFTPoolResults[SPECIAL_BOX][p]);
            }
        }

        SWPoolResults[TRANING_CAMP][SPECIAL_BOX] = [0, 1, 2, 3, 4];
        SWPoolPercentage[TRANING_CAMP][SPECIAL_BOX] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];
        for (
            uint16 p = 0;
            p < SWPoolPercentage[TRANING_CAMP][SPECIAL_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                SWPoolPercentage[TRANING_CAMP][SPECIAL_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[TRANING_CAMP][SPECIAL_BOX].push(
                    SWPoolResults[TRANING_CAMP][SPECIAL_BOX][p]
                );
            }
        }

        SWPoolResults[GEAR][SPECIAL_BOX] = [0, 1, 2, 3, 4, 5, 6, 7];
        SWPoolPercentage[GEAR][SPECIAL_BOX] = [
            uint256(6327),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(333),
            uint256(333),
            uint256(333)
        ];
        for (
            uint16 p = 0;
            p < SWPoolPercentage[GEAR][SPECIAL_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEAR][SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEAR][SPECIAL_BOX].push(
                    SWPoolResults[GEAR][SPECIAL_BOX][p]
                );
            }
        }

        SWPoolResults[DRO][SPECIAL_BOX] = [0, 1, 2, 3, 4, 5, 6, 7];
        SWPoolPercentage[DRO][SPECIAL_BOX] = [
            uint256(6327),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(333),
            uint256(333),
            uint256(333)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[DRO][SPECIAL_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[DRO][SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[DRO][SPECIAL_BOX].push(
                    SWPoolResults[DRO][SPECIAL_BOX][p]
                );
            }
        }

        SWPoolResults[SUITE][SPECIAL_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        SWPoolPercentage[SUITE][SPECIAL_BOX] = [
            uint256(1665),
            uint256(1998),
            uint256(1998),
            uint256(999),
            uint256(999),
            uint256(999),
            uint256(333),
            uint256(333),
            uint256(333),
            uint256(333)
        ];

        for (
            uint16 p = 0;
            p < SWPoolPercentage[SUITE][SPECIAL_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 * SWPoolPercentage[SUITE][SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[SUITE][SPECIAL_BOX].push(
                    SWPoolResults[SUITE][SPECIAL_BOX][p]
                );
            }
        }

        SWPoolResults[BOT][SPECIAL_BOX] = [0, 1, 2, 3, 4, 5, 6, 7];
        SWPoolPercentage[BOT][SPECIAL_BOX] = [
            uint256(6327),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(333),
            uint256(333),
            uint256(333)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[BOT][SPECIAL_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[BOT][SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[BOT][SPECIAL_BOX].push(
                    SWPoolResults[BOT][SPECIAL_BOX][p]
                );
            }
        }

        SWPoolResults[GEN][SPECIAL_BOX] = [
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16
        ];
        SWPoolPercentage[GEN][SPECIAL_BOX] = [
            uint256(333),
            uint256(333),
            uint256(333),
            uint256(333),
            uint256(333),
            uint256(666),
            uint256(666),
            uint256(999),
            uint256(999),
            uint256(999),
            uint256(666),
            uint256(666),
            uint256(666),
            uint256(333),
            uint256(666),
            uint256(333),
            uint256(666)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[GEN][SPECIAL_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEN][SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEN][SPECIAL_BOX].push(
                    SWPoolResults[GEN][SPECIAL_BOX][p]
                );
            }
        }

        SWPoolResults[WEAP][SPECIAL_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8];
        SWPoolPercentage[WEAP][SPECIAL_BOX] = [
            uint256(999),
            uint256(1332),
            uint256(1332),
            uint256(1332),
            uint256(999),
            uint256(999),
            uint256(999),
            uint256(999),
            uint256(999)
        ];
        for (
            uint16 p = 0;
            p < SWPoolPercentage[WEAP][SPECIAL_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 * SWPoolPercentage[WEAP][SPECIAL_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[WEAP][SPECIAL_BOX].push(
                    SWPoolResults[WEAP][SPECIAL_BOX][p]
                );
            }
        }
        //-----------------END SPECIAL BOX RATE --------------------------------
    }

    function getGenPool(
        uint16 _nftType,
        uint16 _rarity,
        uint16 _number
    ) public view returns (uint16) {
        uint16 _modNumber = uint16(_number) %
            uint16(GenPoolValues[_nftType][_rarity].length);
        return GenPoolValues[_nftType][_rarity][_modNumber];
    }

    function getNFTPool(uint16 _nftType, uint16 _number)
        public
        view
        returns (uint16)
    {
        uint16 _modNumber = _number % uint16(NFTPoolValues[_nftType].length);
        return uint16(NFTPoolValues[_nftType][_modNumber]);
    }

    function getEquipmentPool(uint16 _number) public view returns (uint16) {
        return EPool[_number];
    }

    function getBlueprintPool(
        uint16 _nftType,
        uint16 _rarity,
        uint16 eTypeId,
        uint16 _number
    ) public view returns (uint16) {
        uint16 _modNumber = uint16(_number) %
            uint16(BPPoolValues[_nftType][_rarity][eTypeId].length);
        return uint16(BPPoolValues[_nftType][_rarity][eTypeId][_modNumber]);
    }

    function getSpaceWarriorPool(
        uint16 _part,
        uint16 _nftType,
        uint16 _number
    ) public view returns (uint16) {
        uint16 _modNumber = uint16(_number) %
            uint16(SWPoolValues[_part][_nftType].length);
        return SWPoolValues[_part][_nftType][_modNumber];
    }
}
