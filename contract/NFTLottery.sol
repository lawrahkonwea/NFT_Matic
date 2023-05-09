//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./matic-nft.sol";
contract MATICLOTTO is NFTLottery {

	//Administrator address with special control
	address public admin;
	//Lottery round
	uint public round;
	//amount to be paid by all players for participation
	uint participatingFee = 1 ether;
	//time winner is declared
	uint public winningTime;
	//Lucky address that wins each round
	address payable public winningAddress;
	//period to claim prize- if prize is not claimed within this period, winner will not be able to withdraw
	uint winningPeriod = 1 * 7 days;
	//total amount raised to be won
	uint public totalRaised;
	//each round lasts for 24 hours
	//uint public roundPeriod;
	uint public startTime;

	struct player_ {
        uint firstNum;
        uint secondNum;
        uint thirdNum;
        address payable pla_yer;
    }
	//mapping of address to struct player
    mapping(address => player_) public addresstoPlayer;
	//array of struct players
    player_[] internal players;
	//struct variable to store winner
    player_ public winner;
	//array of picked numbers to track numbers already picked in a round
    uint[] internal pickedNumbers;
	//array of participants address 
    address payable[] internal participants;
	//amount raised in each round
	mapping(uint => uint) roundToTotal;
	//??
	//mapping(uint => uint) roundtoTimeleft;

	event newRound(uint indexed round);
	event newParticipant(address indexed);
	event winnerSelected(address indexed);
	event winningWithdrawn(uint indexed);

	constructor() {
		admin = msg.sender;
	}

	modifier onlyAdmin(){
      require(msg.sender == admin,'Only the admin can access this');
      _;
    }

	modifier adminsCantParticipate(){
      require(msg.sender != admin,'Admin cannot participate');
      _;
    }

	modifier onlyWinner() {
		require(msg.sender == winningAddress);
		require(block.timestamp < (winningTime + winningPeriod));
		_;
	}

	error completePlayers();

	function createRound(uint _round) public onlyAdmin {
		require(_round > round);
		startTime = block.timestamp;
		//uint roundTime = 1 * 24 hours;
        round = _round;
		// roundPeriod = block.timestamp + roundTime;
		// roundtoTimeleft[round] = roundPeriod;
		emit newRound(round);
    }

	function selectWinner() public onlyAdmin returns(player_ memory)  {
		winningTime = block.timestamp;
		uint random = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender,block.difficulty)));
        uint rand = random % players.length;
        winner = players[rand];
		winningAddress = winner.pla_yer;
		//delete all arrays in preparation for a new rounds
		delete players;
		delete participants;
		delete pickedNumbers;
		emit winnerSelected(winningAddress);
		return winner;
	}

	function participate(uint _firstNum, uint _secondNum, uint _thirdNum) public payable adminsCantParticipate{
		player_ memory myplayer = addresstoPlayer[msg.sender];
        for (uint i = 0; i < pickedNumbers.length; i++) {
            require (pickedNumbers[i] != _firstNum && pickedNumbers[i] != _secondNum && pickedNumbers[i] !=_thirdNum, "Please pick a separate number");
        }
		require(participatingFee == msg.value);
		//check if player is already in array;
		for (uint i = 0; i < participants.length; i++) {
        	require(participants[i] != msg.sender, "You have already participated in this round");   
        }
        participants.push(payable(msg.sender)); 
	
		pickedNumbers.push(_firstNum);
        pickedNumbers.push(_secondNum);
        pickedNumbers.push(_thirdNum);
        myplayer = player_(
            _firstNum,
            _secondNum,
            _thirdNum,
			payable(msg.sender)
        );
        players.push(myplayer);
		//Check if players are greater than 10 for each round;
		if (players.length >= 10) {
			revert completePlayers();
		}
		//calculation for amoount to be won
        uint winnersContribution = msg.value - (7*10**17 wei);
	    totalRaised += winnersContribution;
        roundToTotal[round] += winnersContribution;
       	mintAnNFT();
	    emit newParticipant(msg.sender);
	}

	function claimPrize() public onlyWinner {
		winningAddress.transfer(roundToTotal[round]);
		emit winningWithdrawn(roundToTotal[round]);
	}
	

	function getNumberOfPlayers() public view returns(uint){
      return players.length;
    }
        

}
