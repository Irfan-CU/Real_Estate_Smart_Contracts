from brownie import accounts, config, BuyersContract

def test_initializing():
    #Arrange
    account = accounts[0]
    #Act
    buyers_contract = BuyersContract.deploy({"from" : account})
    max_price =buyers_contract.getMaxPrice()
    buyer_name =buyers_contract.getBuyerName()
    
    expected_max_price = 0
    expected_buyer_name = ""
    #Assert
    assert max_price==expected_max_price
    assert buyer_name==expected_buyer_name


def test_updating():
    #Arrange
    account = accounts[0]
    #Act
    buyers_contract = BuyersContract.deploy({"from" : account})
    transcation = buyers_contract.updatePrice(1000,"Irfan Mustafa", {"from":account})
    transcation.wait(1)
    max_price =buyers_contract.getMaxPrice()
    buyer_name = buyers_contract.getBuyerName()
    expected_max_price = 1000
    expected_buyer_name = "Irfan Mustafa"
    #Assert
    assert max_price==expected_max_price
    assert buyer_name==expected_buyer_name