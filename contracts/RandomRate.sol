// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRate is Ownable {
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

        //-----------------START COMMON BOX RATE --------------------------------
        NFTPoolResults[COMMON_BOX] = [
            BLUEPRINT_COMM,
            BLUEPRINT_RARE,
            GENOMIC_COMMON,
            SPACE_WARRIOR
        ];
        NFTPoolPercentage[COMMON_BOX] = [
            uint256(3000),
            uint256(2000),
            uint256(4000),
            uint256(1000)
        ];

        //Assign mapping
        for (uint16 p = 0; p < NFTPoolPercentage[COMMON_BOX].length; p++) {
            uint256 qtyItem = (1000 * NFTPoolPercentage[COMMON_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[COMMON_BOX].push(NFTPoolResults[COMMON_BOX][p]);
            }
        }

        GenPoolPercentage[COMMON_BOX][COMMON] = [0, 1, 2, 3, 4, 5, 6];
        GenPoolPercentage[COMMON_BOX][COMMON] = [
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400)
        ];

        //COMMON
        BPPoolPercent[COMMON_BOX][COMMON][GEAR] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][GEAR] = [1, 2, 3, 4];

        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][COMMON][GEAR].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][COMMON][GEAR][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][COMMON][GEAR].push(
                    BPPoolResults[COMMON_BOX][COMMON][GEAR][p]
                );
            }
        }
        //------------
        BPPoolPercent[COMMON_BOX][COMMON][DRO] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][DRO] = [1, 2, 3, 4];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][COMMON][DRO].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][COMMON][DRO][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][COMMON][DRO].push(
                    BPPoolResults[COMMON_BOX][COMMON][DRO][p]
                );
            }
        }

        //---------

        BPPoolPercent[COMMON_BOX][COMMON][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][COMMON][SUITE] = [0, 1, 2];

        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][COMMON][SUITE].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][COMMON][SUITE][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][COMMON][SUITE].push(
                    BPPoolResults[COMMON_BOX][COMMON][SUITE][p]
                );
            }
        }

        //-----
        BPPoolPercent[COMMON_BOX][COMMON][BOT] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][BOT] = [1, 2, 3, 4];

        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][COMMON][BOT].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][COMMON][BOT][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][COMMON][BOT].push(
                    BPPoolResults[COMMON_BOX][COMMON][BOT][p]
                );
            }
        }
        //-------
        BPPoolPercent[COMMON_BOX][COMMON][WEAP] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][WEAP] = [0, 1, 2, 3];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][COMMON][WEAP].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][COMMON][WEAP][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][COMMON][WEAP].push(
                    BPPoolResults[COMMON_BOX][COMMON][WEAP][p]
                );
            }
        }
        //-------
        //RARE
        BPPoolPercent[COMMON_BOX][RARE][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][GEAR] = [5, 6, 7];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][RARE][GEAR].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][RARE][GEAR][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][RARE][GEAR].push(
                    BPPoolResults[COMMON_BOX][RARE][GEAR][p]
                );
            }
        }

        BPPoolPercent[COMMON_BOX][RARE][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][DRO] = [5, 6, 7];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][RARE][DRO].length;
            p++
        ) {
            uint256 qtyItem = (1000 * BPPoolPercent[COMMON_BOX][RARE][DRO][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][RARE][DRO].push(
                    BPPoolResults[COMMON_BOX][RARE][DRO][p]
                );
            }
        }

        BPPoolPercent[COMMON_BOX][RARE][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][SUITE] = [3, 4, 5];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][RARE][SUITE].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][RARE][SUITE][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][RARE][SUITE].push(
                    BPPoolResults[COMMON_BOX][RARE][SUITE][p]
                );
            }
        }

        BPPoolPercent[COMMON_BOX][RARE][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][BOT] = [5, 6, 7];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][RARE][BOT].length;
            p++
        ) {
            uint256 qtyItem = (1000 * BPPoolPercent[COMMON_BOX][RARE][BOT][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][RARE][BOT].push(
                    BPPoolResults[COMMON_BOX][RARE][BOT][p]
                );
            }
        }

        BPPoolPercent[COMMON_BOX][RARE][WEAP] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];
        BPPoolResults[COMMON_BOX][RARE][WEAP] = [4, 5, 6, 7, 8];
        for (
            uint16 p = 0;
            p < BPPoolPercent[COMMON_BOX][RARE][WEAP].length;
            p++
        ) {
            uint256 qtyItem = (1000 *
                BPPoolPercent[COMMON_BOX][RARE][WEAP][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                BPPoolValues[COMMON_BOX][RARE][WEAP].push(
                    BPPoolResults[COMMON_BOX][RARE][WEAP][p]
                );
            }
        }

        //SW
        SWPoolResults[TRANING_CAMP][COMMON_BOX] = [0, 1, 2, 3, 4];
        SWPoolPercentage[TRANING_CAMP][COMMON_BOX] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];

        SWPoolResults[GEAR][COMMON_BOX] = [0, 1, 2, 3, 4, 5, 6, 7];
        SWPoolPercentage[GEAR][COMMON_BOX] = [
            uint256(8000),
            uint256(425),
            uint256(425),
            uint256(425),
            uint256(425),
            uint256(100),
            uint256(100),
            uint256(100)
        ];

        SWPoolResults[DRO][COMMON_BOX] = [0, 1, 2, 3, 4, 5, 6, 7];
        SWPoolPercentage[DRO][COMMON_BOX] = [
            uint256(8000),
            uint256(425),
            uint256(425),
            uint256(425),
            uint256(425),
            uint256(100),
            uint256(100),
            uint256(100)
        ];

        SWPoolResults[SUITE][COMMON_BOX] = [0, 1, 2, 3, 4, 5];
        SWPoolPercentage[SUITE][COMMON_BOX] = [
            uint256(2783),
            uint256(2783),
            uint256(2784),
            uint256(550),
            uint256(550),
            uint256(550)
        ];

        SWPoolResults[BOT][COMMON_BOX] = [0, 1, 2, 3, 4, 5, 6, 7];
        SWPoolPercentage[BOT][COMMON_BOX] = [
            uint256(8000),
            uint256(425),
            uint256(425),
            uint256(425),
            uint256(425),
            uint256(10),
            uint256(10),
            uint256(10)
        ];

        SWPoolResults[GEN][COMMON_BOX] = [0, 1, 2, 3, 4, 5, 6];
        SWPoolPercentage[GEN][COMMON_BOX] = [
            uint256(1428),
            uint256(1428),
            uint256(1428),
            uint256(1429),
            uint256(1429),
            uint256(1429),
            uint256(1429)
        ];

        SWPoolResults[WEAP][COMMON_BOX] = [0, 1, 2, 3, 4, 5, 6, 7, 8];
        SWPoolPercentage[WEAP][COMMON_BOX] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(40),
            uint256(40),
            uint256(40),
            uint256(40),
            uint256(40)
        ];

        //-----------------END COMMON BOX RATE --------------------------------

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
            uint256 qtyItem = (1000 * NFTPoolPercentage[RARE_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[RARE_BOX].push(NFTPoolResults[RARE_BOX][p]);
            }
        }

        GenPoolPercentage[RARE_BOX][COMMON] = [0, 1, 2, 3, 4, 5, 6];
        GenPoolPercentage[RARE_BOX][COMMON] = [
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400)
        ];

        GenPoolPercentage[RARE_BOX][RARE] = [7, 8, 9, 10, 11, 12];
        GenPoolPercentage[RARE_BOX][RARE] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];

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
            uint256 qtyItem = (1000 *
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][COMMON][DRO][p]) /
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
            uint256 qtyItem = (1000 *
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][COMMON][BOT][p]) /
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
            uint256 qtyItem = (1000 *
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][RARE][GEAR][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][RARE][DRO][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][RARE][SUITE][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][RARE][BOT][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][RARE][WEAP][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][EPIC][GEAR][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][EPIC][DRO][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][EPIC][SUITE][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][EPIC][BOT][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[RARE_BOX][EPIC][WEAP][p]) /
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

        //-----------------END RARE BOX RATE --------------------------------

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
            uint256 qtyItem = (1000 * NFTPoolPercentage[EPIC_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[EPIC_BOX].push(NFTPoolResults[EPIC_BOX][p]);
            }
        }

        GenPoolPercentage[EPIC_BOX][RARE] = [7, 8, 9, 10, 11, 12];
        GenPoolPercentage[EPIC_BOX][RARE] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];

        GenPoolPercentage[EPIC_BOX][RARE] = [13, 14, 15, 16];
        GenPoolPercentage[EPIC_BOX][RARE] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];

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
            uint256 qtyItem = (1000 * BPPoolPercent[EPIC_BOX][EPIC][GEAR][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[EPIC_BOX][EPIC][DRO][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[EPIC_BOX][EPIC][SUITE][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[EPIC_BOX][EPIC][BOT][p]) /
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
            uint256 qtyItem = (1000 * BPPoolPercent[EPIC_BOX][EPIC][WEAP][p]) /
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

        //-----------------END EPIC BOX RATE --------------------------------

        //-----------------START SPECIAL BOX RATE --------------------------------

        NFTPoolResults[SPECIAL_BOX] = [SPACE_WARRIOR];
        NFTPoolPercentage[SPECIAL_BOX] = [uint256(10000)];

        //Assign mapping
        for (uint16 p = 0; p < NFTPoolPercentage[SPECIAL_BOX].length; p++) {
            uint256 qtyItem = (1000 * NFTPoolPercentage[SPECIAL_BOX][p]) /
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
        //-----------------END SPECIAL BOX RATE --------------------------------
    }

    function getGenPool(
        uint16 _nftType,
        uint16 _rarity,
        uint16 _number
    ) public view returns (uint16) {
        uint16 amount = 100;
        uint16 index = 0;
        uint16 count = 0;

        for (
            uint16 p = 0;
            p < GenPoolPercentage[_nftType][_rarity].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                GenPoolPercentage[_nftType][_rarity][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                count++;
            }
        }

        uint16 _modNumber = uint16(_number) % count;

        for (
            uint16 p = 0;
            p < GenPoolPercentage[_nftType][_rarity].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                GenPoolPercentage[_nftType][_rarity][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                if (_modNumber == index) {
                    return GenPoolResults[_nftType][_rarity][p];
                }

                index++;
            }
        }

        return 0;
    }

    function getNFTPool(uint16 _nftType, uint16 _number)
        public
        view
        returns (uint16)
    {
        // return uint16(NFTPoolValues[_nftType].length);
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
        uint16 amount = 100;
        uint16 count = 0;
        uint16 index = 0;

        for (uint16 p = 0; p < SWPoolPercentage[_part][_nftType].length; p++) {
            uint256 qtyItem = (amount * SWPoolPercentage[_part][_nftType][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                count++;
            }
        }

        uint16 _modNumber = uint16(_number) % count;

        for (uint16 p = 0; p < SWPoolPercentage[_part][_nftType].length; p++) {
            uint256 qtyItem = (amount * SWPoolPercentage[_part][_nftType][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                if (_modNumber == index) {
                    return SWPoolResults[_part][_nftType][p];
                }

                index++;
            }
        }

        return 0;
    }
}
