// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIVotingAdvisor {

    // Enum to define vote options
    enum VoteOption { NoOpinion, OptionA, OptionB, OptionC }

    // Mapping to track user votes
    mapping(address => VoteOption) public votes;

    // Variables to store vote counts for each option
    uint256 public voteCountA;
    uint256 public voteCountB;
    uint256 public voteCountC;
    uint256 public voteCountNoOpinion;

    // Event to log when a user casts a vote
    event Voted(address indexed user, VoteOption vote);

    // Function to cast a vote
    function vote(VoteOption _vote) public {
        // Ensure that the user hasn't voted yet
        require(votes[msg.sender] == VoteOption.NoOpinion, "You have already voted.");

        // Register the vote
        votes[msg.sender] = _vote;

        // Update vote count based on the selected option
        if (_vote == VoteOption.OptionA) {
            voteCountA++;
        } else if (_vote == VoteOption.OptionB) {
            voteCountB++;
        } else if (_vote == VoteOption.OptionC) {
            voteCountC++;
        } else {
            voteCountNoOpinion++;
        }

        // Emit the Voted event
        emit Voted(msg.sender, _vote);
    }

    // Function to get the current vote tally
    function getVoteTally() public view returns (uint256, uint256, uint256, uint256) {
        return (voteCountA, voteCountB, voteCountC, voteCountNoOpinion);
    }

    // Function to get the AI voting advice based on the current votes
    function getAIVoteAdvice() public view returns (string memory) {
        // Basic AI recommendation logic based on vote count
        if (voteCountA > voteCountB && voteCountA > voteCountC) {
            return "AI advises to choose Option A.";
        } else if (voteCountB > voteCountA && voteCountB > voteCountC) {
            return "AI advises to choose Option B.";
        } else if (voteCountC > voteCountA && voteCountC > voteCountB) {
            return "AI advises to choose Option C.";
        } else {
            return "AI advises that there is no clear preference.";
        }
    }
}
