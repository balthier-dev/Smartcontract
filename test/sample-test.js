const { expect } = require("chai");
const { ethers } = require("hardhat");
describe("ECIO-NFT-Ecosystem", function () {

  const COMMON_BOX = 0;
  const RARE_BOX = 1;
  const EPIC_BOX = 2;
  const SPECIAL_BOX = 3;

  let mysteryBoxContract;
  let nftCoreContract;
  let boxRedemption;
  let randomWorker;
  let randomRateCommonBox;
  let randomRateRareBox;
  let randomRateEpicBox;
  let randomRateSpacialBox;

  //Accounts
  let owner;
  let addr1;
  let addr2;
  let addrs;

  before(async function () {
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    //Deploy MysteryBox Contract (ERC1155)
    const MysteryBox = await ethers.getContractFactory("MysteryBox");
    mysteryBoxContract = await MysteryBox.deploy();
    await mysteryBoxContract.deployed();

    //Deploy NFT Core Contract (ERC 721)
    const ECIONFTCore = await ethers.getContractFactory("ECIONFTCore");
    nftCoreContract = await ECIONFTCore.deploy();
    await nftCoreContract.deployed();
    await nftCoreContract.connect(owner).initialize();

    //Deploy RandomRate Contract  
    const RandomRateCommonBox = await ethers.getContractFactory("RandomRateCommonBox");
    randomRateCommonBox = await RandomRateCommonBox.deploy();
    await randomRateCommonBox.deployed();
    await randomRateCommonBox.initial();
    const RandomRateRareBox = await ethers.getContractFactory("RandomRateRareBox");
    randomRateRareBox = await RandomRateRareBox.deploy();
    await randomRateRareBox.deployed();
    await randomRateRareBox.initial();
    const RandomRateEpicBox = await ethers.getContractFactory("RandomRateEpicBox");
    randomRateEpicBox = await RandomRateEpicBox.deploy();
    await randomRateEpicBox.deployed();
    await randomRateEpicBox.initial();
    const RandomRateSpacialBox = await ethers.getContractFactory("RandomRateSpacialBox");
    randomRateSpacialBox = await RandomRateSpacialBox.deploy();
    await randomRateSpacialBox.deployed();
    await randomRateSpacialBox.initial();

    //Deploy RandomWorker Contract  
    const RandomWorker = await ethers.getContractFactory("RandomWorker");
    randomWorker = await RandomWorker.deploy();
    await randomWorker.deployed();

    //Deploy Box Redemption Contract  
    const BoxRedemption = await ethers.getContractFactory("BoxRedemption");
    boxRedemption = await BoxRedemption.deploy();
    await boxRedemption.deployed();

    //Setup
    await boxRedemption.changeMysteryBoxContract(mysteryBoxContract.address);
    await boxRedemption.changeNftCoreContract(nftCoreContract.address);
    await boxRedemption.changeRandomRateCommonBox(randomRateCommonBox.address);
    await boxRedemption.changeRandomRateRareBox(randomRateRareBox.address);
    await boxRedemption.changeRandomRateEpicBox(randomRateEpicBox.address);
    await boxRedemption.changeRandomRateSpacialBox(randomRateSpacialBox.address);
    await boxRedemption.changeRandomWorkerContract(randomWorker.address);

    const MINTER_ROLE = await nftCoreContract.MINTER_ROLE();
    await nftCoreContract.connect(owner).grantRole(MINTER_ROLE, boxRedemption.address);
    // expect(await nftCoreContract.)
  });

  it("RandomRate Setup Testing", async function () {
    //NFTPool
    expect(0).to.equal(await randomRateCommonBox.getNFTPool(0, 29));
    expect(1).to.equal(await randomRateCommonBox.getNFTPool(0, 30));
    expect(1).to.equal(await randomRateCommonBox.getNFTPool(0, 49));
    expect(3).to.equal(await randomRateCommonBox.getNFTPool(0, 50));
    expect(3).to.equal(await randomRateCommonBox.getNFTPool(0, 89));
    expect(6).to.equal(await randomRateCommonBox.getNFTPool(0, 90));
  });

  it("boxRedemption Setup Testing", async function () {

  });


  it("Box Redemption Testing", async function () {
    //Mint 10 MysteryBox
     await mysteryBoxContract.connect(owner).mint(owner.address, 0, 10, owner.address);
    await mysteryBoxContract.connect(owner).mint(owner.address, 1, 10, owner.address);
    await mysteryBoxContract.connect(owner).mint(owner.address, 2, 10, owner.address);
    await mysteryBoxContract.connect(owner).mint(owner.address, 3, 10, owner.address);

    // //Validate MysteryBox in ownner wallet.
    expect(await mysteryBoxContract.balanceOf(owner.address, COMMON_BOX)).to.equal(10);

    // //Mock random data
    randomWorker.setMock(true);
    randomWorker.setRandomNumber(1231231231231206)

    // //setApprovalForAll
    await mysteryBoxContract.connect(owner).setApprovalForAll(boxRedemption.address, true);
     
    //Send openBox function
    await boxRedemption.connect(owner).openBox(COMMON_BOX);
    await boxRedemption.connect(owner).openBox(RARE_BOX);
    await boxRedemption.connect(owner).openBox(EPIC_BOX);
    await boxRedemption.connect(owner).openBox(SPECIAL_BOX);


    // //Check actual result
    expect(await mysteryBoxContract.balanceOf(owner.address, COMMON_BOX)).to.equal(9);
    expect(await nftCoreContract.balanceOf(owner.address)).to.equal(4);

    // console.log(await nftCoreContract.tokenInfo(0))

  });
});
