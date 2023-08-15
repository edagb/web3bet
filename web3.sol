// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BettingContract {
    address public owner;
    uint public minimumBet;
    uint public totalBets;
    uint public totalAmountBet;
    uint public finalResult;
    bool public bettingClosed = false;

    struct Player {
        uint amountBet;
        uint selectedOutcome;
    }

    mapping(address => Player) public players;
    mapping(uint => address[]) outcomeBets;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    event Bet(address indexed player, uint amount, uint outcome);
    event Payout(address indexed player, uint amount);

    constructor(uint _minimumBet) {
        owner = msg.sender;
        minimumBet = _minimumBet;
    }

    function placeBet(uint outcome) external payable {
        require(!bettingClosed, "Betting is closed");
        require(outcome == 1 || outcome == 2, "Outcome should be either 1 or 2");
        require(msg.value >= minimumBet, "The bet amount is less than the minimum required");

        Player storage player = players[msg.sender];
        player.amountBet = msg.value;
        player.selectedOutcome = outcome;

        outcomeBets[outcome].push(msg.sender);
        totalAmountBet += msg.value;
        totalBets++;

        emit Bet(msg.sender, msg.value, outcome);
    }

    function closeBetting() external onlyOwner {
        bettingClosed = true;
    }

    function declareOutcome(uint result) external onlyOwner {
        require(bettingClosed, "Betting is still open");
        require(result == 1 || result == 2, "Result should be either 1 or 2");

        finalResult = result;

        for(uint i = 0; i < outcomeBets[result].length; i++) {
            address playerAddress = outcomeBets[result][i];
            uint toTransfer = players[playerAddress].amountBet * 2;
            payable(playerAddress).transfer(toTransfer);
            emit Payout(playerAddress, toTransfer);
        }
    }

    function getContractBalance() external view returns(uint) {
        return address(this).balance;
    }
}
