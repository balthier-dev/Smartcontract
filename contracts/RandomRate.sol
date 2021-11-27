// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRate is Ownable {
    using Strings for string;
    using SafeMath for uint256;
    uint256 private constant NFT_TYPE = 0; //Kingdom
    uint256 private constant KINGDOM = 1; //Kingdom
    uint256 private constant TRANING_CAMP = 2; //Training Camp
    uint256 private constant GEAR = 3; //Battle Gear
    uint256 private constant DRO = 4; //Battle DRO
    uint256 private constant SUITE = 5; //Battle Suit
    uint256 private constant BOT = 6; //Battle Bot
    uint256 private constant GEN = 7; //Human GEN
    uint256 private constant WEAP = 8; //WEAP
    uint256 private constant COMBAT_RANKS = 9; //Combat Ranks
    uint256 private constant BLUEPRINT_COMM = 0;
    uint256 private constant BLUEPRINT_RARE = 1;
    uint256 private constant BLUEPRINT_EPIC = 2;
    uint256 private constant GENOMIC_COMMON = 3;
    uint256 private constant GENOMIC_RARE = 4;
    uint256 private constant GENOMIC_EPIC = 5;
    uint256 private constant SPACE_WARRIOR = 6;
    uint256 private constant COMMON_BOX = 0;
    uint256 private constant RARE_BOX = 1;
    uint256 private constant EPIC_BOX = 2;
    uint256 private constant SPECIAL_BOX = 3;
    uint256 private constant COMMON = 0;
    uint256 private constant RARE = 1;
    uint256 private constant EPIC = 2;

    //EPool
    mapping(uint256 => uint256) public EPool;

    mapping(uint256 => uint256[]) rateResults;
    mapping(uint256 => uint256[]) percentage;

    mapping(uint256 => mapping(uint256 => uint256[])) GenPoolPercentage;
    mapping(uint256 => mapping(uint256 => uint256[])) GenPoolResults;

    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256[]))) BPPoolPercentage;
    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256[]))) BPPoolResults;

    mapping(uint256 => mapping(uint256 => uint256[])) SWPoolResults;
    mapping(uint256 => mapping(uint256 => uint256[])) SWPoolPercentage;

    function initial() public onlyOwner {
        EPool[0] = GEAR; //Battle Gear
        EPool[1] = DRO; //Battle DRO
        EPool[2] = SUITE; //Battle Suit
        EPool[3] = BOT; //Battle Bot
        EPool[4] = WEAP; //WEAP

        //-----------------START COMMON BOX RATE --------------------------------
        rateResults[COMMON_BOX] = [
            BLUEPRINT_COMM,
            BLUEPRINT_RARE,
            GENOMIC_COMMON,
            SPACE_WARRIOR
        ];
        percentage[COMMON_BOX] = [
            uint256(3000),
            uint256(2000),
            uint256(4000),
            uint256(1000)
        ];

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
        BPPoolPercentage[COMMON_BOX][COMMON][GEAR] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][GEAR] = [1, 2, 3, 4];

        BPPoolPercentage[COMMON_BOX][COMMON][DRO] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][DRO] = [1, 2, 3, 4];

        BPPoolPercentage[COMMON_BOX][COMMON][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][COMMON][SUITE] = [0, 1, 2];

        BPPoolPercentage[COMMON_BOX][COMMON][BOT] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][BOT] = [1, 2, 3, 4];

        BPPoolPercentage[COMMON_BOX][COMMON][WEAP] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[COMMON_BOX][COMMON][WEAP] = [0, 1, 2, 3];

        //RARE
        BPPoolPercentage[COMMON_BOX][RARE][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][GEAR] = [5, 6, 7];

        BPPoolPercentage[COMMON_BOX][RARE][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][DRO] = [5, 6, 7];

        BPPoolPercentage[COMMON_BOX][RARE][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][SUITE] = [3, 4, 5];

        BPPoolPercentage[COMMON_BOX][RARE][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[COMMON_BOX][RARE][BOT] = [5, 6, 7];

        BPPoolPercentage[COMMON_BOX][RARE][WEAP] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];
        BPPoolResults[COMMON_BOX][RARE][WEAP] = [4, 5, 6, 7, 8];

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
        rateResults[RARE_BOX] = [
            BLUEPRINT_COMM,
            BLUEPRINT_RARE,
            BLUEPRINT_EPIC,
            GENOMIC_COMMON,
            GENOMIC_RARE,
            SPACE_WARRIOR
        ];
        percentage[RARE_BOX] = [
            uint256(1000),
            uint256(1000),
            uint256(500),
            uint256(2000),
            uint256(3000),
            uint256(2500)
        ];

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
        BPPoolPercentage[RARE_BOX][COMMON][GEAR] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][GEAR] = [1, 2, 3, 4];

        BPPoolPercentage[RARE_BOX][COMMON][DRO] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][DRO] = [1, 2, 3, 4];

        BPPoolPercentage[RARE_BOX][COMMON][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][COMMON][SUITE] = [0, 1, 2];

        BPPoolPercentage[RARE_BOX][COMMON][BOT] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][BOT] = [1, 2, 3, 4];

        BPPoolPercentage[RARE_BOX][COMMON][WEAP] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][COMMON][WEAP] = [0, 1, 2, 3];

        //RARE
        BPPoolPercentage[RARE_BOX][RARE][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][GEAR] = [5, 6, 7];

        BPPoolPercentage[RARE_BOX][RARE][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][DRO] = [5, 6, 7];

        BPPoolPercentage[RARE_BOX][RARE][SUITE] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][SUITE] = [3, 4, 5];

        BPPoolPercentage[RARE_BOX][RARE][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][RARE][BOT] = [5, 6, 7];

        BPPoolPercentage[RARE_BOX][RARE][WEAP] = [
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000),
            uint256(2000)
        ];
        BPPoolResults[RARE_BOX][RARE][WEAP] = [4, 5, 6, 7, 8];

        //EPIC
        BPPoolPercentage[RARE_BOX][EPIC][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][EPIC][GEAR] = [8, 9, 10];

        BPPoolPercentage[RARE_BOX][EPIC][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][EPIC][DRO] = [8, 9, 10];

        BPPoolPercentage[RARE_BOX][EPIC][SUITE] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[RARE_BOX][EPIC][SUITE] = [6, 7, 8, 9];

        BPPoolPercentage[RARE_BOX][EPIC][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[RARE_BOX][EPIC][BOT] = [8, 9, 10];

        BPPoolPercentage[RARE_BOX][EPIC][WEAP] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];
        BPPoolResults[RARE_BOX][EPIC][WEAP] = [9, 10, 11, 12, 13, 14];

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
        rateResults[EPIC_BOX] = [
            BLUEPRINT_EPIC,
            GENOMIC_RARE,
            GENOMIC_EPIC,
            SPACE_WARRIOR
        ];
        percentage[EPIC_BOX] = [
            uint256(1000),
            uint256(1000),
            uint256(1000),
            uint256(7000)
        ];

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
        BPPoolPercentage[EPIC_BOX][EPIC][GEAR] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[EPIC_BOX][EPIC][GEAR] = [8, 9, 10];

        BPPoolPercentage[EPIC_BOX][EPIC][DRO] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[EPIC_BOX][EPIC][DRO] = [8, 9, 10];

        BPPoolPercentage[EPIC_BOX][EPIC][SUITE] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];
        BPPoolResults[EPIC_BOX][EPIC][SUITE] = [6, 7, 8, 9];

        BPPoolPercentage[EPIC_BOX][EPIC][BOT] = [
            uint256(3300),
            uint256(3300),
            uint256(3300)
        ];
        BPPoolResults[EPIC_BOX][EPIC][BOT] = [8, 9, 10];

        BPPoolPercentage[EPIC_BOX][EPIC][WEAP] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600)
        ];
        BPPoolResults[EPIC_BOX][EPIC][WEAP] = [9, 10, 11, 12, 13, 14];

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

        rateResults[SPECIAL_BOX] = [SPACE_WARRIOR];
        percentage[SPECIAL_BOX] = [uint256(10000)];

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
        uint256 _nftType,
        uint256 _rarity,
        uint256 _number
    ) public view returns (uint256) {
        uint256 amount = 1000;
        uint256 index = 0;
        uint256 count = 0;

        for (
            uint256 p = 0;
            p < GenPoolPercentage[_nftType][_rarity].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                GenPoolPercentage[_nftType][_rarity][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                count++;
            }
        }

        uint256 _modNumber = _number % count;

        for (
            uint256 p = 0;
            p < GenPoolPercentage[_nftType][_rarity].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                GenPoolPercentage[_nftType][_rarity][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == index) {
                    return GenPoolResults[_nftType][_rarity][p];
                }

                index++;
            }
        }

        return 0;
    }

    function getNFTPool(uint256 _nftType, uint256 _number)
        public
        view
        returns (uint256)
    {
        uint256 amount = 1000;
        uint256 count = 0;
        uint256 index = 0;
 
        for (uint256 p = 0; p < percentage[_nftType].length; p++) {
            uint256 qtyItem = (amount * percentage[_nftType][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                count++;
            }
        }

        uint256 _modNumber = _number % count;

        for (uint256 p = 0; p < percentage[_nftType].length; p++) {
            uint256 qtyItem = (amount * percentage[_nftType][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == index) {
                    return rateResults[_nftType][p];
                }

                index++;
            }
        }

        return 0;
    }

    function getEquipmentPool(uint256 _number) public view returns (uint256) {
        return EPool[_number];
    }

    function getBlueprintPool(
        uint256 _nftType,
        uint256 _rarity,
        uint256 eTypeId,
        uint256 _number
    ) public view returns (uint256) {
        uint256 amount = 1000;
        uint256 index = 0;
        uint256 count = 0;
        for (
            uint256 p = 0;
            p < BPPoolPercentage[_nftType][_rarity][eTypeId].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                BPPoolPercentage[_nftType][_rarity][eTypeId][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                count++;
            }
        }

        uint256 _modNumber = _number % count;

        for (
            uint256 p = 0;
            p < BPPoolPercentage[_nftType][_rarity][eTypeId].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                BPPoolPercentage[_nftType][_rarity][eTypeId][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == index) {
                    return BPPoolResults[_nftType][_rarity][eTypeId][p];
                }

                index++;
            }
        }

        return 0;
    }

    function getSpaceWarriorPool(
        uint256 _part,
        uint256 _nftType,
        uint256 _number
    ) public view returns (uint256) {
        uint256 amount = 1000;
        uint256 count = 0;
        uint256 index = 0;

        for (uint256 p = 0; p < SWPoolPercentage[_part][_nftType].length; p++) {
            uint256 qtyItem = (amount * SWPoolPercentage[_part][_nftType][p]) /
                10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                count++;
            }
        }

        uint256 _modNumber = _number % count;

        for (uint256 p = 0; p < SWPoolPercentage[_part][_nftType].length; p++) {
            uint256 qtyItem = (amount * SWPoolPercentage[_part][_nftType][p]) /
                10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == index) {
                    return SWPoolResults[_part][_nftType][p];
                }

                index++;
            }
        }

        return 0;
    }
}
