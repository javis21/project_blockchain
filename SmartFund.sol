// SPDX-License-Identifier: ADSL	




import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/math/SafeMath.sol';


import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
pragma solidity 0.8.0;

contract SmartFund {




    using SafeMathChainlink for uint256;

    AggregatorV3Interface public pricing;

    mapping(address => uint256) public addressToAmountFunded;
    address public owner;
    address[] public funders;


    constructor(address _pricing) public {
        pricing = AggregatorV3Interface(_pricing);
        owner = msg.sender;
    }


   
    function fund() public payable {

      
        // minimun money input
        uint256 minimun = 1 * 10**18;
        require(
            getConversionRate(msg.value) >= minimun,
            "you need to spend more eth"
        );

        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);

    }



    function getVersion() public view returns (uint256) {
        return pricing.version();
    }



    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = pricing.latestRoundData();
        return uint256(answer * 10000000000);
    }



    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 Price = getPrice();
        uint256 ethAmountInUsd = (ethAmount * Price)/ 1000000000000000000;
        return ethAmountInUsd;
    }


    function getEntranceFee() public view returns (uint256) {
        //minimum USD
        uint256 minimun = 1 * 10**18;
        uint256 price = getPrice();
        uint256 precision = 1 * 10**18;
        return (minimun * precision) / price;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function withdrow() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
