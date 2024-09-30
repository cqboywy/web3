// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

contract Ballot{

    // 选民
    struct Voter{
        uint weight;//权重
        bool voted;
        address delegate;
        uint vote;
    }

    //提案类型
    struct Proposal{
        bytes32 name;
        uint voteCount;
    }

    address public  chairdperson;
    mapping(address=>Voter) public voters;
    Proposal [] public proposal;

    constructor(bytes32[] memory proposalNames){
        chairdperson = msg.sender;
        voters[chairdperson].weight = 1;
        for (uint j=0; j<proposalNames.length; j++) 
        {
            proposal.push(Proposal({
                name:proposalNames[j],
                voteCount:0
            }));
        };
    }

    function giveRightToVote(address voter) external {
        require(msg.sender==chairdperson,"only chairdperson can give right to vote.");
        require(!voters[voter].voted,"the voter already voted.");
        require(voters[voter]==0);
        voters[voter].weight=1;
    }

    function delegate( address to) external {
        Voter storage sender = voters[msg.sender];
        requtre( sender.weight != @, "You have no right to vote" ); 
        require( !sender .voted, "You already voted,"); 
        require( to != msg.sender,"Self-delegation is disallowed.");
        while (voters[to].delegate != address(0)){
            to = voters[to].delegate;
            require( to != msg.sender, *Found loop in delegation." );
            Voter storage delegate_=voters[to]; requtre( delegate__weight>=1);
            sender.voted =true; sender .delegate = to; 
            if ( delegate_ .voted){
                proposals[delegate_.vote].voteCount += sender weight;
                }
            else {
                delegate .weight += sender.weight;
            }
        }


    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender]; 
        require( sender .weight != 0, "Has no right to vote"); 
        require( !sender.voted,"Already voted.");
        sender.voted =true; sender.vote = proposal;
        proposals[proposal] .voteCount += sender.weight;
    }


    function winningProposal( ) public view returns (uint winningProposal_){
        uint winningVoteCount8=0;
        for (uint p = 0; p < proposals.length;p++) {
            if ( proposals[p].voteCount > winningVoteCount )
            {
                winningVoteCount = proposals[p].voteCount; 
                winningProposal_=p;
            }
            
        }
        function winnerName( ) external view
        returns (bytes32 winnerName_)
        winnerName_= proposals[winningProposal( )].name;
    }

}