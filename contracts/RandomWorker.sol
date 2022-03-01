// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RandomWorker is VRFConsumerBase, Ownable {
    using Strings for string;
    bytes32 public requestId;
    bytes32 internal keyHash;
    uint256 public fee;
    uint256 public randomNumberFromChainlink;
    uint256 public count;
    uint256 public randomNumber;

    //testnet
    //   VRFConsumerBase(
    //     0xa555fC018435bef5A13C6c6870a9d4C11DEC329C,
    //     0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06
    // )

    //mainnet
        //     VRFConsumerBase(
        //     0x747973a5A2a4Ae1D3a8fDF5479f1514F65Db9C31, // VRF Coordinator
        //     0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD // LINK Token
        // )
    bool public isMock;

    constructor()
        VRFConsumerBase(
        0xa555fC018435bef5A13C6c6870a9d4C11DEC329C,
        0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06
     )
    {
        count = 0;
        keyHash = 0xc251acd21ec4fb7f31bb8868288bfdbaeb4fbfec2df3735ddbd4f7dc8d60103c;
        fee = 0.2 * 10**18; // 0.1 LINK (Varies by network)
    }

    function setMock(bool _isMock) public onlyOwner {
        isMock = _isMock;
    }

    function setRandomNumber(uint256 _randomNumber) public onlyOwner {
        randomNumber = _randomNumber;
    }

    function updateFees(uint256 _amount) public onlyOwner {
        fee = _amount * 10**18;
    }

   function getRandomNumber() view public returns (uint256) {
         return randomNumber;
    }

    function fulfillRandomness(bytes32 _requestId, uint256 _randomNumber)
        internal
        override
    {
        if (requestId == _requestId) {
            randomNumberFromChainlink = _randomNumber;
        }
    }

    function secondRandom(uint256 data) public view returns (uint256) {
        return
            uint256(
                keccak256(abi.encode(block.timestamp, block.difficulty, data))
            );
    }

    function startRandom() public returns (uint256) {
        // require(
        //     LINK.balanceOf(address(this)) >= fee,
        //     "Not enough LINK - fill contract with faucet"
        // );
        if (!isMock) {
            if (count == 0) {
                requestId = requestRandomness(keyHash, fee);
            }

            randomNumber = secondRandom(randomNumberFromChainlink);
            count++;

            if (count > 100) {
                count = 0;
            }
        }

        return randomNumber;
    }

    function transfer(
        address _contractAddress,
        address _to,
        uint256 _amount
    ) public onlyOwner {
        IERC20 _token = IERC20(_contractAddress);
        _token.transfer(_to, _amount);
    }
}
