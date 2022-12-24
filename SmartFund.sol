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



}
