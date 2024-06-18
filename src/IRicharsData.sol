// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Richars: An Over the top wallet avatar.
// A richars avatar represents an addresses using 16 "RICH CHARachterS", 
// that are hex characters with color and effects (bold, frame, blinking). 
//
// This is an interface for a contract that creates the Richars data, such as SVG and attributes
// Richars contract can update its NFTs by exchaning its IRicharsData.
interface IRicharsData {
    // Generates a Cutrix SVG from a uint256 representation of an address
    function RicharsSVG(uint256 addrAsUint256) external view returns(string memory); 
}