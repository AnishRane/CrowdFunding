// SPDX-License-Identifier:MIT

pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    uint8 public constant DECIMALS = 8;
    uint256 public constant INITIAL_PRICE = 2000e8;
    uint256 public constant SEPOLIA_TESTNET_ID = 11155111;

    constructor() {
        if (block.chainid == SEPOLIA_TESTNET_ID) {
            ActiveNetworkConfig = getSepoliaEthConfig();
        } else {
            ActiveNetworkConfig = getAnvilEthConfig();
        }
    }

    struct NetworkConfig {
        address feedsContractAddress;
    }

    NetworkConfig public ActiveNetworkConfig;

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaEthConfig = NetworkConfig({
            feedsContractAddress: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaEthConfig;
    }

    function getAnvilEthConfig() public returns (NetworkConfig memory) {
        // First check if we have aleady deployed our mock pricefeed conract or not
        if (ActiveNetworkConfig.feedsContractAddress != address(0)) {
            return ActiveNetworkConfig;
        }
        // create mock smart contract for price feed
        // Deploy the mock contract
        // return mock contract address
        vm.startBroadcast();
        MockV3Aggregator priceFeed = new MockV3Aggregator(8, 2000e8);
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({
            feedsContractAddress: address(priceFeed)
        });
        return anvilConfig;
    }
}
