// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {FactoryToken} from "./FactoryToken.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract IndexerToken is Ownable {
    address[] public allToken;

    constructor(address _initialOwner) Ownable(_initialOwner) {}

    function createToken(string memory _tokenName, string memory _symbol) external returns (address) {
        FactoryToken _newToken = new FactoryToken(_tokenName, _symbol, address(this));

        allToken.push(address(_newToken));
        return address(_newToken);
    }

    // function mintToken(
    //     FactoryToken _token,
    //     address _user,
    //     uint256 _amount
    // ) external {
    //     _token.mint(_user, _amount);
    // }

    function burnToken(FactoryToken _token, address _user, uint256 _amount) external {
        _token.burn(_user, _amount);
    }

    function mintToken(address _token, address _user, uint256 _amount) external {
        (bool success,) = _token.call(abi.encodeWithSignature("mint(address,uint256)", _user, _amount));
        require(success, "Call to mint failed");
    }

    function getAllTokens() external view returns (address[] memory) {
        return allToken;
    }
}
