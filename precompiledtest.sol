// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract AddContract {
    function byteToUint(bytes1 b) public pure returns (uint8) {
        // Convert a single byte to uint8
        return uint8(b);
    }

    function byteArrayToUint(bytes memory b) public pure returns (uint256) {
        require(b.length <= 32, "Bytes array is too long to convert to uint256");

        uint256 result = 0;
        for (uint i = 0; i < b.length; i++) {
            result = result << 8;
            result = result | uint8(b[i]);
        }
        return result;
    }

    function add(uint a, uint b) public view returns (uint) {
        // 预编译合约地址（与底层源码相同）
        address customPrecompileAddress = address(0x14);
        // 构造intput
        bytes memory input = abi.encodePacked(a, b);
        // staticCall调用
        (bool success, bytes memory result) = customPrecompileAddress.staticcall(input);
        require(success, "PanguAdd call failed");

        // Decode the result
        
        return byteArrayToUint(result);
    }
}