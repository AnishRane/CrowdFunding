// SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;

import{Script} from "forge-std/Script.sol";
import {CrowdFunding} from "../src/CrowdFunding.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployCrowdFunding is Script{
  // Before vm.startBroadcast() txns are simulated and not commited on chain
 function run() external returns(CrowdFunding){ 
  HelperConfig helperConfig = new HelperConfig();
  address ethUSDPriceFeed = helperConfig.ActiveNetworkConfig();
  
  vm.startBroadcast();
  CrowdFunding _newCrowdFunding = new CrowdFunding(ethUSDPriceFeed);
  vm.stopBroadcast();
  return _newCrowdFunding;
 }

}