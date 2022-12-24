


from brownie import network, accounts, config, mock_agregator

from web3 import Web3




FORKED_LOCAL_ENVIRONMENTS = ["mainnet-fork-dev", "mainnet-fork"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache-local"]


DECIMALS = 18
STARTING_VALUE = 2000



def get_account():
    if (
        network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS
        or network.show_active() in FORKED_LOCAL_ENVIRONMENTS
    ):
        return accounts[0]
    else:
        return accounts.add(config["wallet"]["key"])



def deploy_mocks():

    print("network")

    print(network.show_active())

    if len(mock_agregator) <= 0:
        mock_agregator.deploy(
            DECIMALS, Web3.toWei(STARTING_VALUE, "ether"), {"formulaire": get_account()}
        )
