// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRateRareBox is Ownable {
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

        
        //-----------------START RARE BOX RATE --------------------------------
        NFTPoolResults[RARE_BOX] = [
            BLUEPRINT_COMM,
            BLUEPRINT_RARE,
            BLUEPRINT_EPIC,
            GENOMIC_COMMON,
            GENOMIC_RARE,
            SPACE_WARRIOR
        ];
        NFTPoolPercentage[RARE_BOX] = [
            uint256(1000),
            uint256(1000),
            uint256(500),
            uint256(2000),
            uint256(3000),
            uint256(2500)
        ];

        //Assign mapping
        for (uint16 p = 0; p < NFTPoolPercentage[RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * NFTPoolPercentage[RARE_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[RARE_BOX].push(NFTPoolResults[RARE_BOX][p]);
            }
        }

        GenPoolResults[RARE_BOX][COMMON] = [0, 1, 2, 3, 4, 5, 6];
        GenPoolPercentage[RARE_BOX][COMMON] = [
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400)
        ];

        for (
            uint16 p = 0;
            p < GenPoolPercentage[RARE_BOX][COMMON].length;
            p++
        ) {
            uint256 qtyItem = (100 * GenPoolPercentage[RARE_BOX][COMMON][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                GenPoolValues[RARE_BOX][COMMON].push(
                    GenPoolResults[RARE_BOX][COMMON][p]
                );
            }
        }

        GenPoolResults[RARE_BOX][RARE] = [7, 8, 9, 10, 11, 12];
        GenPoolPercentage[RARE_BOX][RARE] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];

        for (uint16 p = 0; p < GenPoolPercentage[RARE_BOX][RARE].length; p++) {
            uint256 qtyItem = (100 * GenPoolPercentage[RARE_BOX][RARE][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                GenPoolValues[RARE_BOX][RARE].push(
                    GenPoolResults[RARE_BOX][RARE][p]
                );
            }
        }

        //COMMON
        BPPoolPercent[RARE_BOX][COMMON][GEAR] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][GEAR] = [1, 2, 3, 4];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][COMMON][GEAR].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                BPPoolPercent[RARE_BOX][COMMON][GEAR][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][COMMON][GEAR].push(
                    BPPoolResults[RARE_BOX][COMMON][GEAR][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][COMMON][DRO] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][DRO] = [1, 2, 3, 4];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][COMMON][DRO].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][COMMON][DRO][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][COMMON][DRO].push(
                    BPPoolResults[RARE_BOX][COMMON][DRO][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][COMMON][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][COMMON][SUITE] = [0, 1, 2];

        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][COMMON][SUITE].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                BPPoolPercent[RARE_BOX][COMMON][SUITE][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][COMMON][SUITE].push(
                    BPPoolResults[RARE_BOX][COMMON][SUITE][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][COMMON][BOT] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][BOT] = [1, 2, 3, 4];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][COMMON][BOT].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][COMMON][BOT][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][COMMON][BOT].push(
                    BPPoolResults[RARE_BOX][COMMON][BOT][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][COMMON][WEAP] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][WEAP] = [0, 1, 2, 3];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][COMMON][WEAP].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                BPPoolPercent[RARE_BOX][COMMON][WEAP][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][COMMON][WEAP].push(
                    BPPoolResults[RARE_BOX][COMMON][WEAP][p]
                );
            }
        }

        //RARE
        BPPoolPercent[RARE_BOX][RARE][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][GEAR] = [5, 6, 7];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][RARE][GEAR].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][RARE][GEAR][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][RARE][GEAR].push(
                    BPPoolResults[RARE_BOX][RARE][GEAR][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][RARE][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][DRO] = [5, 6, 7];
        for (uint16 p = 0; p < BPPoolPercent[RARE_BOX][RARE][DRO].length; p++) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][RARE][DRO][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][RARE][DRO].push(
                    BPPoolResults[RARE_BOX][RARE][DRO][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][RARE][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][SUITE] = [3, 4, 5];

        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][RARE][SUITE].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][RARE][SUITE][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][RARE][SUITE].push(
                    BPPoolResults[RARE_BOX][RARE][SUITE][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][RARE][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][BOT] = [5, 6, 7];

        for (uint16 p = 0; p < BPPoolPercent[RARE_BOX][RARE][BOT].length; p++) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][RARE][BOT][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][RARE][BOT].push(
                    BPPoolResults[RARE_BOX][RARE][BOT][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][RARE][WEAP] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];
        BPPoolResults[RARE_BOX][RARE][WEAP] = [4, 5, 6, 7, 8];

        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][RARE][WEAP].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][RARE][WEAP][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][RARE][WEAP].push(
                    BPPoolResults[RARE_BOX][RARE][WEAP][p]
                );
            }
        }

        //EPIC
        BPPoolPercent[RARE_BOX][EPIC][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][EPIC][GEAR] = [8, 9, 10];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][EPIC][GEAR].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][EPIC][GEAR][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][EPIC][GEAR].push(
                    BPPoolResults[RARE_BOX][EPIC][GEAR][p]
                );
            }
        }

        BPPoolPercent[RARE_BOX][EPIC][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][EPIC][DRO] = [8, 9, 10];
        for (uint16 p = 0; p < BPPoolPercent[RARE_BOX][EPIC][DRO].length; p++) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][EPIC][DRO][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][EPIC][DRO].push(
                    BPPoolResults[RARE_BOX][EPIC][DRO][p]
                );
            }
        }
        BPPoolPercent[RARE_BOX][EPIC][SUITE] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][EPIC][SUITE] = [6, 7, 8, 9];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][EPIC][SUITE].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][EPIC][SUITE][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][EPIC][SUITE].push(
                    BPPoolResults[RARE_BOX][EPIC][SUITE][p]
                );
            }
        }
        BPPoolPercent[RARE_BOX][EPIC][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][EPIC][BOT] = [8, 9, 10];
        for (uint16 p = 0; p < BPPoolPercent[RARE_BOX][EPIC][BOT].length; p++) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][EPIC][BOT][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][EPIC][BOT].push(
                    BPPoolResults[RARE_BOX][EPIC][BOT][p]
                );
            }
        }
        BPPoolPercent[RARE_BOX][EPIC][WEAP] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];
        BPPoolResults[RARE_BOX][EPIC][WEAP] = [9, 10, 11, 12, 13, 14];
        for (
            uint16 p = 0;
            p < BPPoolPercent[RARE_BOX][EPIC][WEAP].length;
            p++
        ) {
            uint256 qtyItem = (100 * BPPoolPercent[RARE_BOX][EPIC][WEAP][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[RARE_BOX][EPIC][WEAP].push(
                    BPPoolResults[RARE_BOX][EPIC][WEAP][p]
                );
            }
        }
        //SW
        SWPoolResults[TRANING_CAMP][RARE_BOX] = [0, 1, 2, 3, 4];
        SWPoolPercentage[TRANING_CAMP][RARE_BOX] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];

        for (
            uint16 p = 0;
            p < SWPoolPercentage[TRANING_CAMP][RARE_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                SWPoolPercentage[TRANING_CAMP][RARE_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[TRANING_CAMP][RARE_BOX].push(
                    SWPoolResults[TRANING_CAMP][RARE_BOX][p]
                );
            }
        }

        SWPoolResults[GEAR][RARE_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        SWPoolPercentage[GEAR][RARE_BOX] = [
            uint256(7200),
            uint256(625),
            uint256(625),
            uint256(625),
            uint256(625),
            uint256(95),
            uint256(95),
            uint256(95),
            uint256(5),
            uint256(5),
            uint256(5)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[GEAR][RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEAR][RARE_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEAR][RARE_BOX].push(
                    SWPoolResults[GEAR][RARE_BOX][p]
                );
            }
        }

        SWPoolResults[DRO][RARE_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        SWPoolPercentage[DRO][RARE_BOX] = [
            uint256(7200),
            uint256(625),
            uint256(625),
            uint256(625),
            uint256(625),
            uint256(95),
            uint256(95),
            uint256(95),
            uint256(5),
            uint256(5),
            uint256(5)
        ];
        for (uint16 p = 0; p < SWPoolPercentage[DRO][RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[DRO][RARE_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[DRO][RARE_BOX].push(
                    SWPoolResults[DRO][RARE_BOX][p]
                );
            }
        }

        SWPoolResults[SUITE][RARE_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        SWPoolPercentage[SUITE][RARE_BOX] = [
            uint256(2450),
            uint256(2450),
            uint256(2450),
            uint256(750),
            uint256(750),
            uint256(750),
            uint256(100),
            uint256(100),
            uint256(100),
            uint256(100)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[SUITE][RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[SUITE][RARE_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[SUITE][RARE_BOX].push(
                    SWPoolResults[SUITE][RARE_BOX][p]
                );
            }
        }

        SWPoolResults[BOT][RARE_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        SWPoolPercentage[BOT][RARE_BOX] = [
            uint256(7200),
            uint256(625),
            uint256(625),
            uint256(625),
            uint256(625),
            uint256(95),
            uint256(95),
            uint256(95),
            uint256(5),
            uint256(5),
            uint256(5)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[BOT][RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[BOT][RARE_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[BOT][RARE_BOX].push(
                    SWPoolResults[BOT][RARE_BOX][p]
                );
            }
        }

        SWPoolResults[GEN][RARE_BOX] = [
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
            12
        ];
        SWPoolPercentage[GEN][RARE_BOX] = [
            uint256(1143),
            uint256(1143),
            uint256(1143),
            uint256(1143),
            uint256(1143),
            uint256(1143),
            uint256(1142),
            uint256(334),
            uint256(334),
            uint256(333),
            uint256(333),
            uint256(333),
            uint256(333)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[GEN][RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEN][RARE_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEN][RARE_BOX].push(
                    SWPoolResults[GEN][RARE_BOX][p]
                );
            }
        }

        SWPoolResults[WEAP][RARE_BOX] = [
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
        SWPoolPercentage[WEAP][RARE_BOX] = [
            uint256(1735),
            uint256(1735),
            uint256(1735),
            uint256(1735),
            uint256(600),
            uint256(600),
            uint256(600),
            uint256(600),
            uint256(600),
            uint256(10),
            uint256(10),
            uint256(10),
            uint256(10),
            uint256(10),
            uint256(10)
        ];

        for (uint16 p = 0; p < SWPoolPercentage[WEAP][RARE_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[WEAP][RARE_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[WEAP][RARE_BOX].push(
                    SWPoolResults[WEAP][RARE_BOX][p]
                );
            }
        }

        //-----------------END RARE BOX RATE --------------------------------
 
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
