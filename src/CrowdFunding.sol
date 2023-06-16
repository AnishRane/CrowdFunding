// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

// Custom error for unauthorized access
error NotOwner(address, string);

contract CrowdFunding {
    uint256 public s_totalFundsRecieved;
    address public immutable i_owner;
    AggregatorV3Interface private s_pricefeed;

    // Constructor to set the contract owner
    constructor(address _pricefeed) {
        i_owner = msg.sender;
        s_pricefeed=AggregatorV3Interface(_pricefeed);
    }

    // Modifier to restrict access to the contract owner
    modifier OnlyOwner() {
        if (msg.sender != i_owner) revert NotOwner(msg.sender, "owner only");
        _;
    }

    using PriceConverter for uint256;

    // Struct to store funder details
    struct Funder {
        address funder;
        uint256 amount;
    }

    // Array to store funders
    Funder[] funders;

    // Mapping to track the index of a funder in the array
    mapping(address => uint256) fundersMapping;

    // Mapping to track if a funder is registered
    mapping(address => bool) fundersRegistration;

    uint256 public constant MIN_USD = 5 * 10 ** 18;

    // Function to receive funds from users
    function fund() public payable {
        require(msg.value.getConversionRate(s_pricefeed) >= MIN_USD, "not enough ethers");
        if (fundersRegistration[msg.sender]) {
            // Update the existing funder's amount
            uint256 index = fundersMapping[msg.sender];
            funders[index].amount += msg.value;
            s_totalFundsRecieved += msg.value;
        } else {
            // Add a new funder
            fundersRegistration[msg.sender] = true;
            funders.push(Funder({funder: msg.sender, amount: msg.value}));
            fundersMapping[msg.sender] = funders.length - 1;
            s_totalFundsRecieved += msg.value;
        }
    }

    // Function to withdraw funds by the contract owner
    function withdraw() public OnlyOwner {
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        s_totalFundsRecieved = 0;
        require(callSuccess, "call failed");
    }

    // Function to get funding details of a funder
    function getFundingDetails() public view returns (Funder memory) {
        // This function allows either the owner of the smart contract or the person who is funding to
        // check their funding details.
        require(
            msg.sender == i_owner || fundersRegistration[msg.sender],
            "invalid user"
        );
        uint256 index = fundersMapping[msg.sender];
        return funders[index];
    }

    function getPriceFeedVersion() public view returns(uint256){
      return s_pricefeed.version();
    }
}
