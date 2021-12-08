// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface NFT_POOL {
    function depositNFT(
        address nftContract,
        uint256 tokenId,
        address ownner
    ) external;

    function transferNFT(
        address nftContract,
        address to,
        uint256 tokenId
    ) external;
}

contract Market is ReentrancyGuard, ERC721Holder, Ownable {
   
    using Counters for Counters.Counter;
    Counters.Counter private _orderIds;
    Counters.Counter private _orderSold;
    Counters.Counter private _orderCanceled;

    uint256 feesRate = 425;

    address public nftPool;

    constructor() {}

    struct Order {
        address nftContract;
        uint256 orderId;
        uint256 tokenId;
        address seller;
        address owner;
        uint256 price;
        address buyWithTokenContract;
        bool sold;
        bool cancel;
    }

    mapping(uint256 => Order) private idToOrder;

    event OrderCreated(
        address indexed nftContract,
        uint256 indexed orderId,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        address buyWithTokenContract,
        bool sold,
        bool cancel
    );

    event OrderCanceled(
        address indexed nftContract,
        uint256 indexed orderId,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        address buyWithTokenContract,
        bool sold,
        bool cancel
    );

    event OrderSuccessful(
        address indexed nftContract,
        uint256 indexed orderId,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        address buyWithTokenContract,
        bool sold,
        bool cancel
    );

    function updateNFTPool(address _nftPool) public onlyOwner {
        nftPool = _nftPool;
    }

    function updateFeesRate(uint256 newRate) public onlyOwner {
        require(newRate <= 500);
        feesRate = newRate;
    }

    /* Places an item for sale on the marketplace */
    function createOrder(
        address nftContract,
        uint256 tokenId,
        uint256 price,
        address buyWithTokenContract
    ) public nonReentrant {
        // set require ERC721 approve below
        require(price > 100, "Price must be at least 100 wei");
        _orderIds.increment();
        uint256 orderId = _orderIds.current();
        idToOrder[orderId] = Order(
            nftContract,
            orderId,
            tokenId,
            msg.sender,
            nftPool,
            price,
            buyWithTokenContract,
            false,
            false
        );

        // tranfer NFT ownership to Market contract
        IERC721(nftContract).transferFrom(msg.sender, nftPool, tokenId);
        NFT_POOL(nftPool).depositNFT(nftContract, tokenId, msg.sender);

        emit OrderCreated(
            nftContract,
            orderId,
            tokenId,
            msg.sender,
            address(0),
            price,
            buyWithTokenContract,
            false,
            false
        );
    }

    function cancelOrder(uint256 orderId) public nonReentrant {
        require(idToOrder[orderId].sold == false, "Sold item");
        require(idToOrder[orderId].cancel == false, "Canceled item");
        require(idToOrder[orderId].seller == msg.sender); // check if the person is seller

        idToOrder[orderId].cancel = true;

        //Transfer back to owner :: owner is marketplace now >>> original owner
        NFT_POOL(nftPool).transferNFT(
            idToOrder[orderId].nftContract,
            msg.sender,
            idToOrder[orderId].tokenId
        );

        _orderCanceled.increment();

        emit OrderCanceled(
            idToOrder[orderId].nftContract,
            idToOrder[orderId].orderId,
            idToOrder[orderId].tokenId,
            address(0),
            msg.sender,
            idToOrder[orderId].price,
            idToOrder[orderId].buyWithTokenContract,
            true,
            false
        );
    }

    /* Creates the sale of a marketplace order */
    /* Transfers ownership of the order, as well as funds between parties */
    function createSale(uint256 orderId) public nonReentrant {
        require(idToOrder[orderId].sold == false, "Sold item");
        require(idToOrder[orderId].cancel == false, "Canceled item");
        require(idToOrder[orderId].seller != msg.sender);

        uint256 price = idToOrder[orderId].price;
        uint256 tokenId = idToOrder[orderId].tokenId;
        address buyWithTokenContract = idToOrder[orderId].buyWithTokenContract;
        uint256 balance = ERC20(buyWithTokenContract).balanceOf(msg.sender);
        uint256 fee = (price * feesRate) / 10000;
        uint256 amount = price - fee;
        uint256 totalAmount = price + fee;
        address nftContract = idToOrder[orderId].nftContract;

        require(
            balance >= totalAmount,
            "Your balance has not enough amount + including fee."
        );

        //Transfer fee to platform.
        IERC20(buyWithTokenContract).transferFrom(
            msg.sender,
            address(this),
            fee
        );

        //Transfer token(BUSD) to nft seller.
        IERC20(buyWithTokenContract).transferFrom(
            msg.sender,
            idToOrder[orderId].seller,
            amount
        );

        // idToOrder[orderId].seller.transfer(msg.value);
        NFT_POOL(nftPool).transferNFT(
            idToOrder[orderId].nftContract,
            msg.sender,
            tokenId
        );

        idToOrder[orderId].owner = msg.sender;
        idToOrder[orderId].sold = true;
        _orderSold.increment();

        emit OrderSuccessful(
            nftContract,
            orderId,
            tokenId,
            address(0),
            msg.sender,
            price,
            buyWithTokenContract,
            true,
            false
        );
    }

    /* tranfer to owner address*/
    function _tranfertoOwner(
        address _tokenAddress,
        address _receiver,
        uint256 _amount
    ) public onlyOwner nonReentrant {
        uint256 balance = ERC20(_tokenAddress).balanceOf(address(this));
        require(
            balance >= _amount,
            "Your balance has not enough amount totranfer."
        );

        IERC20(_tokenAddress).transfer(_receiver, _amount);
    }

    function transferERC20(
        address _contractAddress,
        address _to,
        uint256 _amount
    ) public onlyOwner {
        IERC20 _token = IERC20(_contractAddress);
        _token.transfer(_to, _amount);
    }
}
