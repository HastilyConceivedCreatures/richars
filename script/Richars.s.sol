// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/IRicharsData.sol";
import "../src/RicharsData.sol";
import "../src/Richars.sol";

contract RicharsScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_ANVIL");
        vm.startBroadcast(deployerPrivateKey);

        IRicharsData richarsData;

        richarsData = IRicharsData(new RicharsData()); 

        new Richars(richarsData);

        vm.stopBroadcast();
    }
}

