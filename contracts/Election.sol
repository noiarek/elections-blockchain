pragma solidity 0.4.24;

contract Election {

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    // mapping Like a hash table
    // uint is the key
    // Candidate is the value
    mapping(uint => Candidate) public candidates;

    mapping(address => bool) public voters;

    /* to keep track of how many candidates
    are stored in the map, because if the
    map has 2 values and we search for number
    99, the map will return a blank candidate 
    */
    uint public candidatesCount;

    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public
    {
        addCandidate("Andres Manuel Lopez Obrador");
        addCandidate("Jose Antonio Meade");
        addCandidate("Ricardo Anaya");        
    }

    function addCandidate (string _name) private
    {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }



    function vote (uint _candidateId) public
    {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;    
        candidates[_candidateId].voteCount++;

        emit votedEvent(_candidateId);
    }
}