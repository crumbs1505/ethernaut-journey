# 🕵️‍♂️ Ethernaut Solutions

My journey through the [OpenZeppelin Ethernaut](https://ethernaut.openzeppelin.com/) wargame using **Foundry**. This repo documents the scripts and strategies used to identify and exploit smart contract vulnerabilities.
All the solutions have comments explaining my approach !

## 🛠 Tech Stack
- **Framework:** Foundry (Forge, Cast)
- **Language:** Solidity
- **Network:** Sepolia

---
## 📂 Project Structure
- **/src**: The target contracts for each level.
- **/script**: Foundry scripts containing the exploit/solution logic.
---

## 🚀 Quick Run
To run a solution:
```bash
forge script script/level_0_solution.s.sol --rpc-url $RPC_URL --env-file .env -vvvv
