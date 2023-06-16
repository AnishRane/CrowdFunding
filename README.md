# 🏦 Crowdfunding Smart Contract 📜

The Crowdfunding smart contract is a decentralized funding platform built on the Ethereum blockchain. It enables individuals to raise funds for their projects in a transparent and secure manner. This project aims to revolutionize the crowdfunding landscape by leveraging the power of blockchain technology.

## 🔑 Key Features

- Users can contribute funds to project campaigns using Ether.
- The smart contract enforces a minimum funding value to ensure meaningful contributions.
- Campaign owners can withdraw funds from their campaigns once the funding goal is met.
- The contract utilizes the Chainlink price feed to convert ETH amounts to their equivalent USD values, ensuring transparency in funding.

## 🚧 Future Enhancements

The Crowdfunding project is an ongoing initiative, and there are several avenues for future enhancements, including:

- Implementing advanced campaign management features, such as stretch goals and milestones.
- Introducing a reputation system to foster trust among campaign owners and contributors.
- Enhancing the user interface for a seamless and intuitive crowdfunding experience.
- Integrating decentralized identity solutions to verify the authenticity of campaign owners.
- Conducting thorough security audits and implementing best practices to ensure the contract's robustness.

## 🛠 Running the Project
- Clone this repository on your machine.

- I have built this project using foundry, to install foundry please follow this steps:
```
https://book.getfoundry.sh/getting-started/installation

```
- Once foundry is successfully you can use this following command:
```
forge test -vvvv
```
- "vvvv" provides with all the details that are executed in the tests

- If you dont want to use foundry just copy the contracts from src and paste them in Remix IDE

**Note for Reviewer:** To successfully run the project, ensure that you are connected to the Sepolia Ethereum testnet or a compatible Ethereum network.

Also make sure to deploy this contract with your desired price aggragator address,as it is
required parameter in constructor

Feel free to experiment with different function calls and explore the capabilities of the Crowdfunding smart contract.

Incase if you are facing any issues feel free to raise them in issues section and i will try to resolve them.

Incase if you want to contribute to this project, feel free to branch out and raise a PR 
and attach test cases and its result with you PR and i will get them merged.

Happy Coding ! 💻

## License

This project is licensed under the MIT License. 
---
