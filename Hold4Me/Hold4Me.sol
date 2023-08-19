// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HoldForMe {
    uint private constant HOLD_DURATION = 3 * 365 days;

    mapping(address => uint) public balanceOf;
    mapping(address => uint) public lockedUntil;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
        lockedUntil[msg.sender] = block.timestamp + HOLD_DURATION;
    }

    function withdraw() external {
        require(block.timestamp >= lockedUntil[msg.sender], "locked");
        uint bal = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
    }
}