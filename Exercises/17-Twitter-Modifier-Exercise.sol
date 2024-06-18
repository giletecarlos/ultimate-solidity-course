// SPDX-License-Identifier: MIT

// 1️⃣ Add a function called changeTweetLength to change max tweet length
// HINT: use newTweetLength as input for function
// 2️⃣ Create a constructor function to set an owner of contract ✅
// 3️⃣ Create a modifier called onlyOwner
// 4️⃣ Use onlyOwner on the changeTweetLength function

pragma solidity ^0.8.0;

contract Twitter {

    address public owner;
    uint16 public max_tweet_lenght;

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[] ) public tweets;

    constructor() {
        owner = msg.sender;
        max_tweet_lenght = 280;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function changeTweetLenght(uint16 newTweetLenght) public onlyOwner(){
        max_tweet_lenght = newTweetLenght;
    }
 
    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= max_tweet_lenght, "Tweet is too long bro!" );

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet( uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory ){
        return tweets[_owner];
    }

}