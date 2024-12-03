// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {IndexerToken} from "../src/IndexerToken.sol";
import {FactoryToken} from "../src/FactoryToken.sol";

contract IndexerTokenTest is Test {
    IndexerToken private indexerToken;

    address private owner = address(0xABCD); // Replace with desired test owner address
    address private user = address(0x1234); // Test user address

    function setUp() public {
        // Deploy the IndexerToken contract
        indexerToken = new IndexerToken(owner);

        // Ensure the owner is set correctly
        assertEq(indexerToken.owner(), owner);
    }

    function testCreateToken() public {
        vm.startPrank(owner);

        string memory tokenName = "TestToken";
        string memory tokenSymbol = "TT";

        address newToken = indexerToken.createToken(tokenName, tokenSymbol);

        // Assert that the new token address is added to the `allToken` array
        address[] memory allTokens = indexerToken.getAllTokens();
        assertEq(allTokens[0], newToken);

        // Assert that the deployed token is a FactoryToken and has correct name and symbol
        FactoryToken factoryToken = FactoryToken(newToken);
        assertEq(factoryToken.name(), tokenName);
        assertEq(factoryToken.symbol(), tokenSymbol);

        vm.stopPrank();
    }

    function testMintAndBurn() public {
        vm.startPrank(owner);

        string memory tokenName = "MintableToken";
        string memory tokenSymbol = "MT";

        // Create a new FactoryToken
        address newToken = indexerToken.createToken(tokenName, tokenSymbol);

        // Mint tokens to user
        uint256 mintAmount = 1000 * 10 ** 9; // Considering decimals is 9
        indexerToken.mintToken(newToken, user, mintAmount);

        FactoryToken factoryToken = FactoryToken(newToken);

        // Check balance of user after mint
        assertEq(factoryToken.balanceOf(user), mintAmount);

        // Burn tokens from user
        uint256 burnAmount = 500 * 10 ** 9;
        indexerToken.burnToken(factoryToken, user, burnAmount);

        // Check balance after burn
        assertEq(factoryToken.balanceOf(user), mintAmount - burnAmount);

        vm.stopPrank();
    }
}
