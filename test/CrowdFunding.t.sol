// SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CrowdFunding} from "../src/CrowdFunding.sol";
import {DeployCrowdFunding} from "../script/DeployCrowdFunding.s.sol";

contract CrowdFundingTest {
    CrowdFunding _newCrowdFundingContract;

    function setUp() external {
        DeployCrowdFunding _deployCrowdFunding = new DeployCrowdFunding();
        _newCrowdFundingContract = _deployCrowdFunding.run();
    }

    function testMinFund() public view {
        assert(_newCrowdFundingContract.MIN_USD() == 5e18);
    }

    function testOwner() public view {
        assert(_newCrowdFundingContract.i_owner() == msg.sender);
    }

    function testPriceFeedVersionAccurate() public view {
        assert(_newCrowdFundingContract.getPriceFeedVersion() == 4);
    }
}
