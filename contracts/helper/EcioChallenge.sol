//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract EcioChallenge {

    function setup(address nftCoreV1, address nftCoreV2) public virtual {}

    function bonus(
        address account,
        address[] memory contracts,
        uint256[] memory tokenIds
    ) public view virtual returns (uint256) {}
}
