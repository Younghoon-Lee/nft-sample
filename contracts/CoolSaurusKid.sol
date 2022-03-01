pragma solidity ^0.8.0;

import "./tokens/nf-token-metadata.sol";
import "./tokens/nf-token-enumerable.sol";
import "./ownership/ownable.sol";
import "./access/AccessControl.sol";


contract CoolSaurusKid is 
    NFTokenEnumerable,
    NFTokenMetadata,
    AccessControl
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(string memory _name, string memory _symbol, address mineter, address burner)
    {
        nftName = _name;
        nftSymbol = _symbol;
        _setupRole(MINTER_ROLE, minter);
        _setupRole(BURNER_ROLE, burner);
    }

    function mint(address _to, uint256 _tokenId, string calldata _uri)
        external
        onlyRole(MINTER_ROLE) 
    {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }

    function burn(uint256 _tokenId)
        external
        onlyRole(BURNER_ROLE)
    {
        super._burn(_tokenId);
    }

    function _mint(address _to, uint256 _tokenId
    )
        internal
        override(NFToken, NFTokenEnumerable)
        virtual
    {
        NFTokenEnumerable._mint(_to, _tokenId);
    }

    function _burn(uint256 _tokenId)
        internal
        override(NFTokenMetadata, NFTokenEnumerable)
        virtual
    {
        NFTokenEnumerable._burn(_tokenId);
        if (bytes(idToUri[_tokenId]).length != 0)
        {
            delete idToUri[_tokenId];
        }
    }

    function _removeNFToken(address _from, uint256 _tokenId)
        internal
        override(NFToken, NFTokenEnumerable)
    {
        NFTokenEnumerable._removeNFToken(_from, _tokenId);
    }

    function _addNFToken(address _to, uint256 _tokenId)
        internal
        override(NFToken, NFTokenEnumerable)
    {
        NFTokenEnumerable._addNFToken(_to, _tokenId);
    }

    function _getOwnerNFTCount(address _owner)
        internal
        override(NFToken, NFTokenEnumerable)
        view
        returns (uint256)
    {
        return NFTokenEnumerable._getOwnerNFTCount(_owner);
    }
}