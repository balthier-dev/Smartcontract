//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IECIONFT {
    function tokenInfo(uint256 _tokenId)
        external
        view
        returns (string memory, uint256);
}
