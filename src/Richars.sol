// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

import "./IRicharsData.sol";

// Richars: An Over the top wallet avatar.
// A richars avatar represents an addresses using 16 "RICH CHARachterS", 
// that are hex characters with color and effects (bold, frame, blinking). 
contract Richars is  ERC721URIStorage, ERC721Enumerable, Ownable {
    using Strings for uint256;

    struct richChar {
        uint8 charColor; //4 bits of characters, 3 bits of color, leading 0
        uint8 flags; // 1 bit underlink, 1 overline, 1 blnking, rest is garbage bits
    }

    // mint price in Wei
    uint256 public mintPrice;

    IRicharsData internal richarsData;

    constructor(IRicharsData richarsDataContructor) ERC721("Richars", "RCHS") Ownable(msg.sender) {
        richarsData = richarsDataContructor;
    }

    // The tokenID is actually the uint256 representation of an address.
    // Anyone can mint a token, but the ownership will go to the address that tokenID represents.
    function mint(uint256 tokenID) external {
        // require(msg.value >= mintPrice, "Richars: insufficient funds");

        uint160 Uint160Address = uint160(tokenID);
        address tokenIDAddress = address(Uint160Address);

        _mint(tokenIDAddress, tokenID);
    }

    // Returns the tokenURI for the specified tokenID.
    function tokenURI(uint256 tokenID) public view override(ERC721, ERC721URIStorage) returns (string memory){
        require(ownerOf(tokenID) != address(0), "The Richars is either not minted or was burned");

        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Richars #', Strings.toString(tokenID), '",',
                '"description": "A moderately handsome wallet address",',
                '"image": "', richarsData.RicharsSVG(tokenID), '",',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    // Sets a new mint price for the tokens.
    function setMintPrice(uint256 newMintPrice) public onlyOwner() {
        mintPrice = newMintPrice;
    }

    function setricharsData(IRicharsData newricharsData) public onlyOwner() {
        richarsData = newricharsData;
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function _update(address to, uint256 tokenID, address auth) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenID, auth);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}