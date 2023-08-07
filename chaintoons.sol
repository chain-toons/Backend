// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTCardGame  {

    uint256 public id; //total number of minted nfts

    address[] public registereduseres; //all users must be in this array to participate in game

    struct card {
       string name;
       uint points;
       string color; //eight colors allowed
       string metadataURI; //link to wherever card is stored
    }

    mapping(uint256 => card) public cardslibrary; //info on all cards is stored here, id refers to each nft minted

    mapping(uint256 => uint256) public mintedcards; //each minted card points to a specific card id stored in library, gas savings

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }    

    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    }

    //storing color and metadata as string might be expensive
    function addCard(string memory _name, uint256 _points, string memory _color, string memory _metadataURI) public onlyOwner {
        card memory newCard = card(_name, _points, _color, _metadataURI);
        cardslibrary[id] = newCard;
        id++;
    }

}