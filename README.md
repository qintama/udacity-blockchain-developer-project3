# udacity-blockchain-developer-project3
- Udacity blockchain developer course project3
- edited from boiler plate: https://github.com/udacity/nd1309-Project-6b-Example-Template

## Project Plan
- Activity Diagram
- Sequence Diagram
- State Diagram
- Class Diagram

<img src="./plans/WoodSupplyChainUMLDiagram.svg">

## Project Libraries

- `web3.js ^1.8.2` - used for testing smart contract
- `@truffle/hdwallet-provider ^2.1.6` - used for deploy smart contract to Goerli network
- `dotenv ^16.0.3` - used to load environment variables INFURA_API_KEY, MNEMONIC


## Environment
```
Truffle v5.7.4 (core: 5.7.4)
Ganache v7.7.3
Solidity v0.5.16 (solc-js)
Node v16.19.0
Web3.js v1.8.1
```

## IPFS
IPFS not used in this project

## Getting Started
Test Smart Contract
```
// make sure truffle is installed gloabally
> npm install
> truffle develop
> truffle test
```
To run in develop environment
- deploy smart contract to local ganache network
    ```
    > truffle compile
    > truffle migrate --network develop
    ```
- start frontend server, can be access at http://localhost:8080
    ```
    > cd ./app
    > npm install
    > npm run dev
    ```
- test Dapp by depolying contract to your own local blockchain, use the first account (contract owner) to test this Dapp, you can change `<input />` element's values to your own ID for visual (it actually uses the connected account on MetaMask see `index.js`)

## Goerli Deployed Smart Contract
- contract address: `0xC744772E4069eC80D5433b9E88617B0422dc5F4b`
```
1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0xf5e925edb17cd287a8f2b57a9b839a690d13e1022a7aa4d6addcd99486f510dc
   > Blocks: 2            Seconds: 32
   > contract address:    0xCD716f0152481D7110658923161Fb5E8bb458Fd3
   > block number:        8423440
   > block timestamp:     1675376220
   > account:             0x5dfE9fe8DA016F5D75004b250eF1E298512280bb
   > balance:             0.560060366451751818
   > gas used:            165475 (0x28663)
   > gas price:           50 gwei
   > value sent:          0 ETH
   > total cost:          0.00827375 ETH

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00827375 ETH


2_deploy_contracts.js
=====================

   Deploying 'HarvesterRole'
   -------------------------
   > transaction hash:    0x4753a8cc6338cb7d039cb5477b804814248adee880dc725f1661023e944c8c32
   > Blocks: 0            Seconds: 8
   > contract address:    0x537FE1895376590421Ad576633BbBB07DA01fc32
   > block number:        8423442
   > block timestamp:     1675376244
   > account:             0x5dfE9fe8DA016F5D75004b250eF1E298512280bb
   > balance:             0.541596116451751818
   > gas used:            323544 (0x4efd8)
   > gas price:           50 gwei
   > value sent:          0 ETH
   > total cost:          0.0161772 ETH


   Deploying 'DistributerRole'
   ---------------------------
   > transaction hash:    0x4f16cd52438a2524b30a012febacc33c2392c688cac6f0acc36e86a22070ba36
   > Blocks: 1            Seconds: 20
   > contract address:    0x5C372Be8862A4AC63A59273bA277b08dD3A19705
   > block number:        8423444
   > block timestamp:     1675376268
   > account:             0x5dfE9fe8DA016F5D75004b250eF1E298512280bb
   > balance:             0.525420116451751818
   > gas used:            323520 (0x4efc0)
   > gas price:           50 gwei
   > value sent:          0 ETH
   > total cost:          0.016176 ETH


   Deploying 'RetailerRole'
   ------------------------
   > transaction hash:    0xe136486ce95df90b61a5acd11f90200130a88dfd0068052c5b409434f31e5d74
   > Blocks: 1            Seconds: 8
   > contract address:    0x06bb64073184994A8764f985518BB7acB741f78b
   > block number:        8423445
   > block timestamp:     1675376280
   > account:             0x5dfE9fe8DA016F5D75004b250eF1E298512280bb
   > balance:             0.509243516451751818
   > gas used:            323532 (0x4efcc)
   > gas price:           50 gwei
   > value sent:          0 ETH
   > total cost:          0.0161766 ETH


   Deploying 'CustomerRole'
   ------------------------
   > transaction hash:    0x27ebabb8ecddce1f97a054489fff82eb20605214b2a3e90cd8add7d9e5d914a1
   > Blocks: 0            Seconds: 8
   > contract address:    0xfE273Fc8C61eD12f802D985685E422403e82f425
   > block number:        8423446
   > block timestamp:     1675376292
   > account:             0x5dfE9fe8DA016F5D75004b250eF1E298512280bb
   > balance:             0.493066316451751818
   > gas used:            323544 (0x4efd8)
   > gas price:           50 gwei
   > value sent:          0 ETH
   > total cost:          0.0161772 ETH


   Deploying 'SupplyChain'
   -----------------------
   > transaction hash:    0x6017a5c08fe0d98db83d2be730f42359d0d077319bd2d3fe46a13d1f5f04ee6f
   > Blocks: 1            Seconds: 20
   > contract address:    0xC744772E4069eC80D5433b9E88617B0422dc5F4b
   > block number:        8423448
   > block timestamp:     1675376316
   > account:             0x5dfE9fe8DA016F5D75004b250eF1E298512280bb
   > balance:             0.350791316451751818
   > gas used:            2845500 (0x2b6b3c)
   > gas price:           50 gwei
   > value sent:          0 ETH
   > total cost:          0.142275 ETH

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:            0.206982 ETH

Summary
=======
> Total deployments:   6
> Final cost:          0.21525575 ETH
```

## Transaction History from smart contract deployed on Goerli
- check transactions at: https://goerli.etherscan.io/address/0xC744772E4069eC80D5433b9E88617B0422dc5F4b
<img src="./images/transaction_history_goerli.png">
