// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";//该合约帮我们实现了TOKEN的URI的设定和读取方法
import "@openzeppelin/contracts/utils/Counters.sol"; //该合约帮我们实现了合约的自增ID
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";//该合约帮我们实现了验证链上签名
import "@openzeppelin/contracts/access/Ownable.sol";//该合约规定部署者账号为合约的所有人

contract DJULA520 is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(address => bool) internal _delegates;

    struct MintInput{
        address to;
        uint256 tableId;
        string tokenURI;
    }

    mapping(uint256 => uint256) tableIdToTokenIds;

    constructor() ERC721("DJULA520Letter", "DJULA520Letter") {
        _delegates[owner()] = true;
    }

    modifier onlyDelegates() {
        require(_delegates[msg.sender], "Invalid delegate");
        _;
    }

    //onlyOwner
    function isDelegate(address addr) external view onlyOwner returns (bool) {
        return _delegates[addr];
    }

    function setDelegate(address addr, bool isDelegate_) external onlyOwner {
        _delegates[addr] = isDelegate_;
    }

    function transferOwnership(address newOwner) public virtual override onlyOwner {
        _delegates[newOwner] = true;
        super.transferOwnership(newOwner);
    }

    function mint(
        address to,
        uint256 tableId,
        string memory tokenURI
    ) external onlyDelegates returns (uint256) {
        uint256 newItemId = _mintOne(to, tableId, tokenURI);
        return newItemId;
    }

    function _mintOne(
        address to,
        uint256 tableId,
        string memory tokenURI
    ) internal returns (uint256) {
        _tokenIds.increment();
        require(tableIdToTokenIds[tableId]== 0, "already set");
        uint256 newItemId = _tokenIds.current();
        tableIdToTokenIds[tableId] = newItemId;
        _mint(to, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }

    function batchMint(MintInput[] calldata params) external onlyDelegates returns (uint256[] memory) {
        uint256[] memory tokenIds = new uint256[](params.length);
        for(uint256 i =0; i< params.length; i++){
            uint256 tokenId = _mintOne(params[i].to, params[i].tableId, params[i].tokenURI);
            tokenIds[i] = tokenId;
        }
        return tokenIds;
    }

    function getTokenIdsByTableIds(uint256[] calldata tableIds) external view returns (uint256[] memory)
    {
        uint256[] memory tokenIds = new uint256[](tableIds.length);
        for(uint256 i =0; i< tableIds.length; i++){
            tokenIds[i] = tableIdToTokenIds[tableIds[i]];
        }
        return tokenIds;
    }
}
