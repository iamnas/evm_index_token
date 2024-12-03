// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IndexerToken} from "../src/IndexerToken.sol";

contract DeployScript is Script {
    function run() external {
        address owner = msg.sender; // Replace this with a specific owner address if needed

        vm.startBroadcast();

        // Deploy IndexerToken contract
        IndexerToken indexerToken = new IndexerToken(owner);

        // console.log("IndexerToken deployed at:", address(indexerToken));

        vm.stopBroadcast();
    }
}
