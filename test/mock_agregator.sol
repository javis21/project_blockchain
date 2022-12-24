// SPDX-License-Identifier: ADSL


import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV2V3Interface.sol";
pragma solidity 0.8.0;








contract mock_agregator is AggregatorV2V3Interface {



    uint256 public constant override version = 0;

    uint8 public override decimals;
    int256 public override latestAnswer;
    uint256 public override latestTimestamp;
    uint256 public override latestRound;




    mapping(uint256 => int256) public override getAnswer;
    mapping(uint256 => uint256) public override getTimestamp;
    mapping(uint256 => uint256) private getStartedAt;


    constructor(uint8 _decimals, int256 _initialAnswer) public {
        decimals = _decimals;
        updateAnswer(_initialAnswer);
    }

    function updateAnswer(int256 _answer) public {
        latestAnswer = _answer;
        latestTimestamp = block.timestamp;
        latestRound++;
        getAnswer[latestRound] = _answer;
        getTimestamp[latestRound] = block.timestamp;
        getStartedAt[latestRound] = block.timestamp;
    }



}
