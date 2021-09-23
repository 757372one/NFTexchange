// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract spaceFART is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("spaceFART", "spaceFART") {
    }
    struct Item {
        uint256 id;
        address creator;
        string uri;
    }
    mapping (uint256 => Item) public Items;

    

    function createToken(string memory uri) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);

        Items[newItemId] = Item(newItemId, msg.sender, uri);

        _setTokenURI(newItemId, uri); // vr
        return newItemId;
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return Items[tokenId].uri;
    }
}