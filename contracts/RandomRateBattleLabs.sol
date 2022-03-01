// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRateBattleLabs is Ownable {
    using Strings for string;

    uint16 private constant RNG = 5; //Battle Suit

    mapping(uint16 => uint16[]) SWPoolResults;
    mapping(uint16 => uint16[]) SWPoolValues;
    mapping(uint16 => uint256[]) SWPoolPercentage;

    function initial() public onlyOwner {

        SWPoolResults[RNG] =[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99];
        SWPoolPercentage[RNG] = [
            uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100),uint256(100)
        ];

        for (
            uint16 p = 0;
            p < SWPoolPercentage[RNG].length;
            p++
        ) {
            uint256 qtyItem = (100 * SWPoolPercentage[RNG][p]) /
                10000;
            for (uint16 i = 0; i < qtyItem; i++) {
                SWPoolValues[RNG].push(
                    SWPoolResults[RNG][p]
                );
            }
        }

        //-----------------END RNG RATE --------------------------------
    }

    function getRNGPool(
        uint16 _part,
        uint16 _number
    ) public view returns (uint16) {
        uint16 _modNumber = uint16(_number) %
            uint16(SWPoolValues[_part].length);
        return SWPoolValues[_part][_modNumber];
    }
}