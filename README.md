# Richars
A Richars is an Over the top address avatar.

Richars are procedually-generated on-chain SVGs. Technically Richars is an NFT.

## Introduction
An Ethereum address contains 160 bits. It is normally represented as a string of 40 hex characters, each character represents 4 bits from the 160.

A Richars representation includes 16 characters, each character represents 10 bits of the 160. We call such a character a "Rich Character" - hence the project name.

The 10 bits of a rich character define the following (from right-most bits to left-most bits):

- 4 bits: hex character
- 3 bits: a color (out of 8 options)
- 1 bit: if the character has a frame around it
- 1 bit: if the character is bold
- 1 bit: if the character blinks

## Files
The project contains two solidity contracts.
- **RicharsData**. A Solidity library that generates the data of a Richars for a given Ethereum address
- **Richars**. An ERC721 contract for Richars NFTs.

## Compile
Richars is developed with [Foundry](https://getfoundry.sh/). To build it, first install Foundry, then run the following command:
```
forge build
```

## Deploy
To deploy Richars to Anvil, the local Ethereum development blockchain of the Foundry framework, first launch Anvil:
```
anvil
```

Create a .env file in Richars folder with a parameter 'PRIVATE_KEY_ANVIL' containing a private key of an account in Anvil, for example:
```
PRIVATE_KEY_ANVIL=0x86660b04835ab7bd97c8964fc5239f93f1160d76fd2afe8f9891082132197a7a
```

Now you can deploy the contract to Anvil.
```
forge script script/Richars.s.sol:RicharsScript --fork-url http://localhost:8545 --broadcast
```

You will see in the output of the deploy command that two contracts were deployed. The first is `RicharsData` and the second is `Richars` ERC721 contract.

## Team
- Neiman (coding)
- R1der (design)
