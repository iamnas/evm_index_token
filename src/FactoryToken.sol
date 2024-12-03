// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract FactoryToken is ERC20, ERC20Burnable, Ownable {
    constructor(string memory _tokenName, string memory _symbol, address _initialOwner)
        ERC20(_tokenName, _symbol)
        Ownable(_initialOwner)
    {}

    function mint(address _user, uint256 _amount) external onlyOwner {
        _mint(_user, _amount);
    }

    function burn(address _user, uint256 _amount) external onlyOwner {
        _burn(_user, _amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 9;
    }
}
