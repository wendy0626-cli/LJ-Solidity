// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract H {
    
    function excute(address i, address j, uint256 num) public payable {
        (bool success, bytes memory data) = i.call{value: msg.value}(
            abi.encodeWithSignature("setNum(address,uint256)", j, num)
        );
    }

    receive() external payable {}

    fallback() external payable {}
}

contract I {
    
    function setNum(address j, uint256 num) public payable {
        (bool success, bytes memory data) = j.call{value: msg.value}(
            abi.encodeWithSignature("setNum(uint256)", num)
        );
    }

    receive() external payable {}

    fallback() external payable {}
}

contract J {
    uint256 public x;
    
    function setNum(uint256 num) public payable{
        x = num;
    }

    receive() external payable {}

    fallback() external payable {}
}
