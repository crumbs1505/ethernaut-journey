//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "../src/level_0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
/*
This level calls for finding a password and passing the password string to an authenticate function.
The password is defined as a public string and can be obtained from the contract.
The obtained password is then passed as an argument to the authenticate function and the transaction is broadcasted ,
 if the provided password matches the expected password the level is completed.
*/
contract level_0_solution is Script {
    Instance public LevelInstance;

    function run() external {
        LevelInstance = Instance(0xe98e9C4d8f8f3aF0167FAd3D20D90B4D4e168F69); //creating a level instance by getting the level address from ethernaut
        string memory password = LevelInstance.password();
        console.log("Password:", password);
        string memory mnemonic = vm.envString("MY_PRIVATE_KEY");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 0);
        vm.startBroadcast(deployerPrivateKey);
        LevelInstance.authenticate(password);
        vm.stopBroadcast();

        bool cleared = LevelInstance.getCleared();
        console.log("Is the level cleared?", cleared);
        require(cleared, "Solution failed: Level not cleared!");
    }
}
