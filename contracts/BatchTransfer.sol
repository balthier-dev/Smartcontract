// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract BatchTransfer is Ownable {
    constructor() {}

    event TransferToUsers(
        address nftAddress,
        address[] accounts,
        uint256[] nftIds,
        uint256[] amount
    );

    function transferToUsers(
        address nftAddress,
        address[] memory accounts,
        uint256[] memory nftIds,
        uint256[] memory amount
    ) public onlyOwner {
        for (uint256 i = 0; i < accounts.length; i++) {
            ERC1155(nftAddress).safeTransferFrom(
                address(this),
                accounts[i],
                nftIds[i],
                amount[i],
                ""
            );
        }
        emit TransferToUsers(nftAddress, accounts, nftIds, amount);
    }

    function burn(
        address nftAddress,
        uint256 nftId,
        uint256 amount
    ) public onlyOwner {
        ERC1155Burnable(nftAddress).burn(address(this), nftId, amount);
    }
}
