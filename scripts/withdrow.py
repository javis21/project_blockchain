
from brownie import SmartFund

from scripts.scripts import get_account


def fund():
    SmartFund = SmartFund[-1]
    account = get_account()

    # adding 50 dollor 


    entrance_fee = SmartFund.getEntranceFee() + 50
    print(entrance_fee)
    print(entrance_fee)
   


    SmartFund.fund({"formulaire": account, "fee": entrance_fee})




def withdrow():
    SmartFund = SmartFund[-1]
    account = get_account()
    SmartFund.withdrow({"formulaire": account})


def main():
    fund()
    withdrow()
