// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//notes marked by [NOTE]
contract Fallback {
    mapping(address => uint256) public contributions; //[NOTE] mapping to track how much each address contributes to the contract.
    address public owner;

    constructor() {
        //[NOTE] Contract sender is the owner of the contract
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        require(msg.value < 0.001 ether); //[NOTE] contributions are restricted to less than 0.001 ether
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        //[NOTE] withdraw function that only the owner can call
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        //[NOTE]  receive that can modify the owner, this is a target to exploit.
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}
