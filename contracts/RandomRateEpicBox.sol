// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRateEpicBox is Ownable {
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
 
        //-----------------START EPIC BOX RATE --------------------------------
        NFTPoolResults[EPIC_BOX] = [
            BLUEPRINT_EPIC,
            GENOMIC_RARE,
            GENOMIC_EPIC,
            SPACE_WARRIOR
        ];
        NFTPoolPercentage[EPIC_BOX] = [
            uint256(1000),
            uint256(1000),
            uint256(1000),
            uint256(7000)
        ];

        //Assign mapping
        for (uint16 p = 0; p < NFTPoolPercentage[EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * NFTPoolPercentage[EPIC_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[EPIC_BOX].push(NFTPoolResults[EPIC_BOX][p]);
            }
        }

        GenPoolResults[EPIC_BOX][RARE] = [7, 8, 9, 10, 11, 12];
        GenPoolPercentage[EPIC_BOX][RARE] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];
        for (uint16 p = 0; p < GenPoolPercentage[EPIC_BOX][RARE].length; p++) {
            uint256 qtyItem = (100 * GenPoolPercentage[EPIC_BOX][RARE][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                GenPoolValues[EPIC_BOX][RARE].push(
                    GenPoolResults[EPIC_BOX][RARE][p]
                );
            }
        }

        GenPoolResults[EPIC_BOX][EPIC] = [13, 14, 15, 16];
        GenPoolPercentage[EPIC_BOX][EPIC] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        for (uint16 p = 0; p < GenPoolPercentage[EPIC_BOX][EPIC].length; p++) {
            uint256 qtyItem = (100 * GenPoolPercentage[EPIC_BOX][EPIC][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                GenPoolValues[EPIC_BOX][EPIC].push(
                    GenPoolResults[EPIC_BOX][EPIC][p]
                );
            }
        }

        //EPIC
        BPPoolPercent[EPIC_BOX][EPIC][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[EPIC_BOX][EPIC][GEAR] = [8, 9, 10];
        for (
            uint16 p = 0;
            p < BPPoolPercent[EPIC_BOX][EPIC][GEAR].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[EPIC_BOX][EPIC][GEAR][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[EPIC_BOX][EPIC][GEAR].push(
                    BPPoolResults[EPIC_BOX][EPIC][GEAR][p]
                );
            }
        }
        BPPoolPercent[EPIC_BOX][EPIC][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[EPIC_BOX][EPIC][DRO] = [8, 9, 10];
        for (uint16 p = 0; p < BPPoolPercent[EPIC_BOX][EPIC][DRO].length; p++) {
            uint256 qtyItem = (100 * BPPoolPercent[EPIC_BOX][EPIC][DRO][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[EPIC_BOX][EPIC][DRO].push(
                    BPPoolResults[EPIC_BOX][EPIC][DRO][p]
                );
            }
        }
        BPPoolPercent[EPIC_BOX][EPIC][SUITE] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[EPIC_BOX][EPIC][SUITE] = [6, 7, 8, 9];
        for (
            uint16 p = 0;
            p < BPPoolPercent[EPIC_BOX][EPIC][SUITE].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[EPIC_BOX][EPIC][SUITE][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[EPIC_BOX][EPIC][SUITE].push(
                    BPPoolResults[EPIC_BOX][EPIC][SUITE][p]
                );
            }
        }
        BPPoolPercent[EPIC_BOX][EPIC][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[EPIC_BOX][EPIC][BOT] = [8, 9, 10];
        for (uint16 p = 0; p < BPPoolPercent[EPIC_BOX][EPIC][BOT].length; p++) {
            uint256 qtyItem = (100 * BPPoolPercent[EPIC_BOX][EPIC][BOT][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[EPIC_BOX][EPIC][BOT].push(
                    BPPoolResults[EPIC_BOX][EPIC][BOT][p]
                );
            }
        }
        BPPoolPercent[EPIC_BOX][EPIC][WEAP] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];
        BPPoolResults[EPIC_BOX][EPIC][WEAP] = [9, 10, 11, 12, 13, 14];
        for (
            uint16 p = 0;
            p < BPPoolPercent[EPIC_BOX][EPIC][WEAP].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[EPIC_BOX][EPIC][WEAP][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[EPIC_BOX][EPIC][WEAP].push(
                    BPPoolResults[EPIC_BOX][EPIC][WEAP][p]
                );
            }
        }
        //SW
        SWPoolResults[TRANING_CAMP][EPIC_BOX] = [0, 1, 2, 3, 4];
        SWPoolPercentage[TRANING_CAMP][EPIC_BOX] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];

        for (
            uint16 p = 0;
            p < SWPoolPercentage[TRANING_CAMP][EPIC_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                SWPoolPercentage[TRANING_CAMP][EPIC_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[TRANING_CAMP][EPIC_BOX].push(
                    SWPoolResults[TRANING_CAMP][EPIC_BOX][p]
                );
            }
        }

        SWPoolResults[GEAR][EPIC_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        SWPoolPercentage[GEAR][EPIC_BOX] = [
            uint256(6525),
            uint256(700),
            uint256(700),
            uint256(700),
            uint256(700),
            uint256(200),
            uint256(200),
            uint256(200),
            uint256(25),
            uint256(25),
            uint256(25)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[GEAR][EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEAR][EPIC_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEAR][EPIC_BOX].push(
                    SWPoolResults[GEAR][EPIC_BOX][p]
                );
            }
        }

        SWPoolResults[DRO][EPIC_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        SWPoolPercentage[DRO][EPIC_BOX] = [
            uint256(6525),
            uint256(700),
            uint256(700),
            uint256(700),
            uint256(700),
            uint256(200),
            uint256(200),
            uint256(200),
            uint256(25),
            uint256(25),
            uint256(25)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[DRO][EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[DRO][EPIC_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[DRO][EPIC_BOX].push(
                    SWPoolResults[DRO][EPIC_BOX][p]
                );
            }
        }

        SWPoolResults[SUITE][EPIC_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        SWPoolPercentage[SUITE][EPIC_BOX] = [
            uint256(2050),
            uint256(2050),
            uint256(2050),
            uint256(1050),
            uint256(1050),
            uint256(1050),
            uint256(175),
            uint256(175),
            uint256(175),
            uint256(175)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[SUITE][EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[SUITE][EPIC_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[SUITE][EPIC_BOX].push(
                    SWPoolResults[SUITE][EPIC_BOX][p]
                );
            }
        }

        SWPoolResults[BOT][EPIC_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        SWPoolPercentage[BOT][EPIC_BOX] = [
            uint256(6525),
            uint256(700),
            uint256(700),
            uint256(700),
            uint256(700),
            uint256(200),
            uint256(200),
            uint256(200),
            uint256(25),
            uint256(25),
            uint256(25)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[BOT][EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[BOT][EPIC_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[BOT][EPIC_BOX].push(
                    SWPoolResults[BOT][EPIC_BOX][p]
                );
            }
        }

        SWPoolResults[GEN][EPIC_BOX] = [
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
        SWPoolPercentage[GEN][EPIC_BOX] = [
            uint256(1020),
            uint256(1020),
            uint256(1020),
            uint256(1020),
            uint256(1020),
            uint256(1021),
            uint256(1021),
            uint256(357),
            uint256(357),
            uint256(357),
            uint256(357),
            uint256(357),
            uint256(357),
            uint256(179),
            uint256(179),
            uint256(179),
            uint256(179)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[GEN][EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEN][EPIC_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEN][EPIC_BOX].push(
                    SWPoolResults[GEN][EPIC_BOX][p]
                );
            }
        }

        SWPoolResults[WEAP][EPIC_BOX] = [
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
            14
        ];
        SWPoolPercentage[WEAP][EPIC_BOX] = [
            uint256(1463),
            uint256(1463),
            uint256(1462),
            uint256(1462),
            uint256(800),
            uint256(800),
            uint256(800),
            uint256(800),
            uint256(800),
            uint256(25),
            uint256(25),
            uint256(25),
            uint256(25),
            uint256(25),
            uint256(25)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[WEAP][EPIC_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[WEAP][EPIC_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[WEAP][EPIC_BOX].push(
                    SWPoolResults[WEAP][EPIC_BOX][p]
                );
            }
        }

        //-----------------END EPIC BOX RATE --------------------------------
 
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
