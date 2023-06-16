// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // Function to get the current ETH price in USD
    function getPrice(AggregatorV3Interface priceFeed) public view returns (uint256) {
        // Retrieve the price feed from the Chainlink aggregator contract
        (, int256 price,,,) = priceFeed.latestRoundData();
        // Since the price feed returns the price with 8 decimal places, we append 10 zeros for precision
        return uint256(price * 10000000000);
    }

    // Function to convert a given amount of ETH to its USD value
    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) public view returns (uint256) {
        uint256 currentEthPrice = getPrice(priceFeed);
        // Calculate the USD value of the ETH amount by multiplying it with the current ETH price and dividing by 10^18
        uint256 ethInUSD = (currentEthPrice * ethAmount) / 1000000000000000000;
        return ethInUSD;
    }
}
