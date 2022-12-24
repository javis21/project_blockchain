



from brownie import SmartFund, mock_agregator, network, config

from scripts.scripts import (
    deploy_mocks,
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)



def deploy_SmartFund():
    
    account = get_account()
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        price_feed_address = config["networking"][network.show_active()][
            "price feed"
        ]
    else:
        deploy_mocks()
        price_feed_address = mock_agregator[-1].address

    SmartFund = SmartFund.deploy(
        price_feed_address,
        {"from": account},
        publish_source=config["networking"][network.show_active()].get("checking"),
    )

    print(f"deployed to  {SmartFund.address}")
    return SmartFund


def main():
    deploy_SmartFund()
