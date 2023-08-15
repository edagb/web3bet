# Betting Smart Contract

A decentralized application that allows users to place bets on their predictions directly from their wallets.

## Description

This smart contract allows users to bet on two outcomes: "Yes" (represented as `1`) or "No" (represented as `2`). The owner of the contract can close betting and declare the result, after which payouts are made automatically to the winners.

## Features

- Place a bet on one of two outcomes.
- Dynamic storage of players and their respective bets.
- Automated payouts to winners when the result is declared.
- Only the owner can close betting and declare the outcome.

## Setup and Installation

1. Install [Truffle](https://www.trufflesuite.com/truffle) or your preferred development environment.
2. Clone this repository:
   ```
   git clone https://github.com/egagb/dontforgetbot.git
   ```
3. Navigate to the project directory and install dependencies:
   ```
   cd dontforgetbot
   npm install
   ```
4. Compile the smart contract:
   ```
   truffle compile
   ```

## Testing

Ensure you have the [Ganache](https://www.trufflesuite.com/ganache) local blockchain running.

1. Run the tests:
   ```
   truffle test
   ```

## Deployment

1. Update the `truffle-config.js` file with your preferred network settings.
2. Deploy the contract:
   ```
   truffle migrate --network <your_network_name>
   ```

## License

MIT
