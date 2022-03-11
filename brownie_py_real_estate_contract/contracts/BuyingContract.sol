// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract BuyersContract{
   
    int public m_maxPrice = 0;
    string public m_buyerName = "";
    // string public address = "7548a94e6cdf8ab9668d272c38acf36cca39b6642672bf5f079e7fe64551b543" 
    mapping (address => uint256) public addressToAmountFunded;
    // For Rinkeby 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    AggregatorV3Interface internal priceFeed;

        constructor() {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    }

    function getLatestPrice() public view returns (int) {
        (
           , 
            int price,
            ,
            ,
            
        ) = priceFeed.latestRoundData();
        return price;
    }

    function fund()public payable{
        addressToAmountFunded[msg.sender] = msg.value;
               
    }

    struct houseDetails{
        string purchasePrice;
        string rooms;
    }


    struct ownerInfo {
        string locationAddress;
        string id;
        string balance;
        houseDetails ownerHouseDetails;
        
    }

    
    mapping (uint256 => ownerInfo) owners;
    uint256[] public ownerInfos;


    function updatePrice(int sellerInputPrice, string memory name) public{
        if (m_maxPrice < sellerInputPrice){
            m_maxPrice = sellerInputPrice;      
            m_buyerName = name;
        }
        
    }

    function getMaxPrice() public view returns(int){
        return m_maxPrice;
    }

    function getBuyerName() public view returns (string memory){
        return m_buyerName;
    }

    

    function registerOwner(string memory _locationAddress,string memory _ownerId,string memory _balance,uint256 _id,
    string memory _purchasePrice, string memory _houseRooms) public{
        ownerInfo storage newOwner = owners[_id];
        newOwner.locationAddress = _locationAddress;
        newOwner.id = _ownerId;
        newOwner.balance = _balance;
        newOwner.ownerHouseDetails.purchasePrice = _purchasePrice;
        newOwner.ownerHouseDetails.rooms = _houseRooms;

        ownerInfos.push(_id);

    }

    function getOwner(uint256 _id) public view returns (string memory locationAddress, string memory ownerId, string memory balance
    ,string memory purchasePrice, string memory rooms){
        ownerInfo storage s = owners[_id];
        return (s.locationAddress, s.id, s.balance, s.ownerHouseDetails.purchasePrice, s.ownerHouseDetails.rooms);
    }

}
