
from brownie import SmartFund

from scripts.scripts import get_account


def fund():
    SmartFund = SmartFund[-1]
    account = get_account()

 
def main():
    fund()
    withdrow()
