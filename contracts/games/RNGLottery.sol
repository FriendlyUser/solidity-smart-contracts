
contract RNGLottery {
    uint constant public TICKET_PRICE = 1e16;

    address[] public tickets;
    address public winner;
    bytes32 public seed;
    mapping(address => bytes32) public commitments;

    uint public ticketDeadline;
    uint public revealDeadline;

    function RNGLottery (uint duration, uint revealDuration) public {
        ticketDeadline = block.number + duration;
        revealDeadline = ticketDeadline + revealDuration;
    }
    
    function createCommitment(address user, uint N) 
      public pure returns (bytes32 commitment) {
        return keccak256(user, N);
    }

    function buy (bytes32 commitment) payable public {
        require(msg.value == TICKET_PRICE); 
        require(block.number <= ticketDeadline);

        commitments[msg.sender] = commitment;
    }

    function reveal (uint N) public {
        require(block.number > ticketDeadline);
        require(block.number <= revealDeadline);

        bytes32 hash = createCommitment(msg.sender, N);
        require(hash == commitments[msg.sender]);

        seed = keccak256(seed, N);
        tickets.push(msg.sender);
    }

    function drawWinner () public {
        require(block.number > revealDeadline);
        require(winner == address(0));

        uint randIndex = uint(seed) % tickets.length;
        winner = tickets[randIndex];
    }

    function withdraw () public {
        require(msg.sender == winner);
        msg.sender.transfer(this.balance);
    }
}