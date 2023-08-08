// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTCardGame is ERC721URIStorage {

    uint256 public cardid; //card id in collection

    mapping(address => bool) public users; //all users must be here to participate in game

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }    

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    }

    //all players must first register through adduser function
    function adduser() public {
        require(!users[msg.sender], "User already registered");
        users[msg.sender] = true;
        //need to add logic to mint starting cards for user
    }

    //front can check whether user registered through this
    function checkregistration(address _user) public view returns (bool) {
        return users[_user];
    }   

    //framework for minting a card, all card info is in metadata under _tokenURI
    function mintcard(address _recipient, string memory _tokenURI)  public onlyOwner {
        _safeMint(_recipient, cardid);
        _setTokenURI(cardid, _tokenURI);
        cardid++;
    }    

    function getTokenMetadata(uint256 _tokenId) public view returns (string memory) {
        return tokenURI(_tokenId);
    }

}
