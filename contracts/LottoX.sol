// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract LottoX is Ownable {

    struct Lotto {
        uint256 num;
        uint256 quanity;
    }

    mapping(address => Lotto[]) public lottoNum;
    uint256 public winnerNumber;
    address payable public feePool;
    address[] joinAddress;
    address[] public winnerAddress;
    bool public poolEnd;
    uint256 public totalQuanity = 0;
    uint256 public rewardPool;

    function setFeePoolAddress(address _address) public onlyOwner {
        feePool = payable(address(_address));
    }

    function buyTicket(uint256 number, uint256 quanity) public payable {
        require(msg.value >= 0.1 ether * quanity);
        require(poolEnd = false);
        feePool.transfer(0.005 ether * quanity);
        lottoNum[msg.sender].push(Lotto(number,quanity));
        joinAddress.push(msg.sender);
        rewardPool = 0.095 ether * quanity;
    }

    function pickWinner(uint256 number) public onlyOwner {
        winnerNumber = number;
        for (uint i = 0; i < joinAddress.length; i++) {
            for (uint j = 0; j < lottoNum[joinAddress[i]].length; j++) {
                if(winnerNumber == lottoNum[joinAddress[i]][j].num){
                    totalQuanity = totalQuanity + lottoNum[joinAddress[i]][j].quanity;
                    winnerAddress.push(joinAddress[i]);
                }
            }
        }
        poolEnd = true;
        rewardPool = address(this).balance;
    }

    function claimReward() public {
        require(poolEnd = true);
        for (uint i = 0; i < lottoNum[msg.sender].length; i++) {
            if(winnerNumber == lottoNum[msg.sender][i].num){
                if(totalQuanity > 1 && winnerAddress.length > 1){
                    uint256 percent = (lottoNum[msg.sender][i].quanity/totalQuanity) * 100;
                    payable(address(msg.sender)).transfer(rewardPool.div(100).mul(percent));
                }else{
                    payable(address(msg.sender)).transfer(rewardPool);
                }
            }
        }
    }

    function listTicket(address _address) public view returns (Lotto[] memory) {
        return lottoNum[_address];
    }

}
