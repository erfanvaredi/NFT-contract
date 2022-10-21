// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";
// 1st import as follows
import "hardhat/console.sol";



contract Alchemy is ERC721, ERC721Enumerable, ERC721URIStorage /**Ownable**/ {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 10000;

    constructor() ERC721("ErfanNFT", "ENFT") {}

    function safeMint(address to, string memory uri) public /**onlyOwner**/ {
        /** Everyone can mint
        to (address): Who called the function; Who wanna mint the NFT
        **/
        // Curret tokenId
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId <= MAX_SUPPLY, "Max number of NFTs minted, no more minting is possible"); /** require(condition, else) **/
        console.log("TokenId before inc: ", tokenId);
        _tokenIdCounter.increment();
        console.log("TokenId after inc: ", tokenId);
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public /** Function modifiers, u can read more about them **/
        view /** This function is just reading from blockchain [view] and you dont need to pay any gas **/
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
