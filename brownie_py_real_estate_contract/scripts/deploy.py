from brownie import accounts, config, BuyersContract

def deploy():
    account = accounts[0]
    buyers_contract = BuyersContract.deploy({"from" : account})
    transcation = buyers_contract.updatePrice(1000,"Irfan Mustafa", {"from":account})
    transcation.wait(1)
    max_price =buyers_contract.getMaxPrice()
    buyer_name = buyers_contract.getBuyerName()
    print(max_price,buyer_name)

def main():
    deploy()
