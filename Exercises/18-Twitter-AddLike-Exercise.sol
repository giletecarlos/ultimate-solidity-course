// SPDX-License-Identifier: MIT

// 1️⃣ Add id to Tweet Struct to make every Tweet Unique✅
// 2️⃣ Set the id to be the Tweet[] length ✅
// HINT: you do it in the createTweet function 
// 3️⃣ Add a function to like the tweet
// HINT: there should be 2 parameters, id and author
// 4️⃣ Add a function to unlike the tweet
// HINT: make sure you can unlike only if likes count is greater then 0
// 4️⃣ Mark both functions external

pragma solidity ^0.8.0;

contract Twitter {

    uint16 public max_tweet_lenght;
    uint256 public id;
    address public owner;

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
    mapping(address => Tweet[] ) public tweets;


    constructor() {
        owner = msg.sender;
        max_tweet_lenght = 280;
        id = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "YOU ARE NOT THE OWNER!");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        max_tweet_lenght = newTweetLength;
    }

    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= max_tweet_lenght, "Tweet is too long bro!" );

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
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

    function likeTweet(uint256 id, address author) external {
        tweets[author][id].likes++;
    }

    function unlikeTweet(uint256 id, address author) external likesCountGreaterThan0(id, author) {
        tweets[author][id].likes++;
    }

    modifier likesCountGreaterThan0(uint256 id, address author) {
        require(tweets[author][id].likes > 0, "Error: The tweet has 0 likes");
        _;
    }
}