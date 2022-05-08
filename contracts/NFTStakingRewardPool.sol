// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFTStakingRewardPool is Ownable {

    address public ecioContractAddress;


    function setupContract(address contractAddress)
        public
        onlyOwner
    {
        ecioContractAddress = contractAddress;
    }

    function claimRewardFromPool(address claimAddress, uint256 _amount) public onlyOwner {
        require(_amount >= 12500 * 1e18);
        IERC20(ecioContractAddress).transfer(claimAddress, _amount);
    }
}