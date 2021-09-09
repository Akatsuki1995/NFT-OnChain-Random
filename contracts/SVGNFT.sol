pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
contract SVGNFT is ERC721URIStorage {
    uint256 public tokenCounter;
    event CreatedSVGNFT(uint indexed tokenId, string tokenURI);
    constructor() ERC721 ("SVGNFT", "svgNFT"){
        tokenCounter = 0 ;
    }
    function create(string memory svg) public {
        
        _safeMint(msg.sender, tokenCounter);
        string memory imageURI= svgToImageURI(svg);
        string memory tokenURI = formatTokenURI(imageURI);
        _setTokenURI(tokenCounter,tokenURI);
        emit CreatedSVGNFT(tokenCounter,tokenURI);
        tokenCounter = tokenCounter + 1 ;
    }
    // you can turn this function to a libraby so everyone can use it
    function svgToImageURI(string memory svg) public pure returns (string memory) {
        //<svg xmlns="http://www.w3.org/2000/svg" height="210" width="400"><path d="M150 0 L75 200 L225 200 Z" /></svg>
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        return imageURI;
    }
    function formatTokenURI(string memory imageURI) public pure returns (string memory){
      string memory baseURL = "data:application/json;base64,";
      return string (abi.encodePacked(
          baseURL,
          Base64.encode(
            bytes(abi.encodePacked(
              '{"name": "SVG NFT", ',
              '"description": "An NFT based on SVG!", ',
              '"attributes": "", ',
              '"image": "', imageURI, '"}'
          )
          ))
          ));  
    }
}