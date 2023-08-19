// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract TestMultiCall {
    function func1() external view returns (uint, uint) {
        return (1, block.timestamp);
    }

    function func2() external view returns (uint, uint) {
        return (2, block.timestamp);
    }
}

contract MultiCall {
    function multiCall(address[] calldata targets, bytes[] calldata data)
        external 
        view 
        returns (bytes[] memory)
    {
        require(targets.length == data.length, "target length is too short");
        bytes[] memory results = new bytes[](data.length);

        for (uint i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].staticcall(data[i]);
            require(success, "call did not succeed");
            results[i] = result;
        }

        return results; 
    }
}