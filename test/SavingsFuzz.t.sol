// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {Savings} from "../src/Savings.sol";
import { Token } from "src/mocks/Token.sol";

contract SavingsFuzz is  Test {
    Savings public savings;
    Token public token;
    address public USER = makeAddr("user");

    function setUp() public {
        token = new Token("Mock Token", "MCK");
        token.mint(USER, type(uint256).max);
        savings = new Savings(address(token));
    }

    function testFuzzDeposit(uint256 _amount) public {
        vm.assume(_amount >= 1e18);
        vm.startPrank(USER);
        token.approve(address(savings), _amount);
        savings.deposit(_amount);
        uint256 totalDeposits = savings.totalDeposited();
        uint256 MaxDepositAmt = savings.MAX_DEPOSIT_AMOUNT();
        assertGe(MaxDepositAmt, totalDeposits);
        vm.stopPrank();

    }

   
}
