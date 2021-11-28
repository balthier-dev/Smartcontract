// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRateCommonBox is Ownable {
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
            uint256 qtyItem = (100 * NFTPoolPercentage[COMMON_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                NFTPoolValues[COMMON_BOX].push(NFTPoolResults[COMMON_BOX][p]);
            }
        }

        GenPoolResults[COMMON_BOX][COMMON] = [0, 1, 2, 3, 4, 5, 6];
        GenPoolPercentage[COMMON_BOX][COMMON] = [
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
            p < GenPoolPercentage[COMMON_BOX][COMMON].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                GenPoolPercentage[COMMON_BOX][COMMON][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                GenPoolValues[COMMON_BOX][COMMON].push(
                    GenPoolResults[COMMON_BOX][COMMON][p]
                );
            }
        }

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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 * BPPoolPercent[COMMON_BOX][RARE][DRO][p]) /
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
            uint256 qtyItem = (100 *
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
            uint256 qtyItem = (100 * BPPoolPercent[COMMON_BOX][RARE][BOT][p]) /
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
            uint256 qtyItem = (100 *
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

        for (
            uint16 p = 0;
            p < SWPoolPercentage[TRANING_CAMP][COMMON_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 *
                SWPoolPercentage[TRANING_CAMP][COMMON_BOX][p]) / 10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[TRANING_CAMP][COMMON_BOX].push(
                    SWPoolResults[TRANING_CAMP][COMMON_BOX][p]
                );
            }
        }

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

        for (uint16 p = 0; p < SWPoolPercentage[GEAR][COMMON_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEAR][COMMON_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEAR][COMMON_BOX].push(
                    SWPoolResults[GEAR][COMMON_BOX][p]
                );
            }
        }

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

        for (uint16 p = 0; p < SWPoolPercentage[DRO][COMMON_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[DRO][COMMON_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[DRO][COMMON_BOX].push(
                    SWPoolResults[DRO][COMMON_BOX][p]
                );
            }
        }

        SWPoolResults[SUITE][COMMON_BOX] = [0, 1, 2, 3, 4, 5];
        SWPoolPercentage[SUITE][COMMON_BOX] = [
            uint256(2783),
            uint256(2783),
            uint256(2784),
            uint256(550),
            uint256(550),
            uint256(550)
        ];

        for (
            uint16 p = 0;
            p < SWPoolPercentage[SUITE][COMMON_BOX].length;
            p++
        ) {
            uint256 qtyItem = (100 * SWPoolPercentage[SUITE][COMMON_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[SUITE][COMMON_BOX].push(
                    SWPoolResults[SUITE][COMMON_BOX][p]
                );
            }
        }

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
        for (uint16 p = 0; p < SWPoolPercentage[BOT][COMMON_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[BOT][COMMON_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[BOT][COMMON_BOX].push(
                    SWPoolResults[BOT][COMMON_BOX][p]
                );
            }
        }

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

        for (uint16 p = 0; p < SWPoolPercentage[GEN][COMMON_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[GEN][COMMON_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[GEN][COMMON_BOX].push(
                    SWPoolResults[GEN][COMMON_BOX][p]
                );
            }
        }

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
        for (uint16 p = 0; p < SWPoolPercentage[WEAP][COMMON_BOX].length; p++) {
            uint256 qtyItem = (100 * SWPoolPercentage[WEAP][COMMON_BOX][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[WEAP][COMMON_BOX].push(
                    SWPoolResults[WEAP][COMMON_BOX][p]
                );
            }
        }

        //-----------------END COMMON BOX RATE --------------------------------
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
