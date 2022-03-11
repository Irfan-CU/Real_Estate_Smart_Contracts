// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

contract BuyersContract{
   
    int public m_maxPrice;
    string public m_sellerName;

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
            m_sellerName = name;
        }
        
    }

    function getMaxPrice() public view returns(int){
        return m_maxPrice;
    }

    function getSellerName() public view returns (string memory){
        return m_sellerName;
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
