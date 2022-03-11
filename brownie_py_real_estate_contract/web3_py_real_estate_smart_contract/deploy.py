from  solcx import compile_standard, install_solc
import json
from web3 import Web3 
import os
from dotenv import load_dotenv

load_dotenv()


with open("./BuyingContract.sol","r") as file:
    buying_contract_file = file.read()

install_solc("0.8.0")

compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"BuyingContract.sol": {"content": buying_contract_file}},
        "settings": {
            "outputSelection": {
                "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
            }
        },
    },
    solc_version="0.8.0",
)

# creat json file dump the comiled code in it to make it more readable.
with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)
 
bytecode = compiled_sol["contracts"]["BuyingContract.sol"]["BuyersContract"]["evm"]["bytecode"]["object"]
abi = compiled_sol["contracts"]["BuyingContract.sol"]["BuyersContract"]["abi"]

w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))
chain_id = 1337
my_address = os.getenv("ADDRESS")
private_key = os.getenv("PRIVATE_KEY")
print(private_key)

BuyingContract = w3.eth.contract(abi=abi,bytecode=bytecode)

nonce = w3.eth.getTransactionCount(my_address)

print(nonce)
# Build Transaction
transcation = BuyingContract.constructor().buildTransaction({"gasPrice": w3.eth.gas_price, "chainId":chain_id, "from":my_address, "nonce":nonce})
#Sign Transaction
signed_transaction = w3.eth.account.sign_transaction(transcation,private_key)
#Send Transaction on BlockChain
tx_hash = w3.eth.send_raw_transaction(signed_transaction.rawTransaction)
tx_reciept = w3.eth.wait_for_transaction_receipt(tx_hash)

#Working with Contract

buying_contract = w3.eth.contract(address=tx_reciept.contractAddress, abi=abi)



print(signed_transaction)