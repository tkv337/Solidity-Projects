// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FundMe {
    event Deposit(uint amount);
    event Withdraw(uint amount);
    address public owner = msg.sender;

    receive() external payabale {
        emit Deposit(msg.value);
    }

    function withdrawal() exteral {
        require(msg.sender == owner, "you don't have access");
        emit Withdraw(address(this).balance); 
        selfdestruct(payable(msg.sender)); 
    }

}