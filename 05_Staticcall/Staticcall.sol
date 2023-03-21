 // SPDX-License-Identifier: MIT
 pragma solidity >=0.8.0;
 
 //靶子合约，用于被调用
 contract target{
    int public state;
    //不改变状态
    function getState() view public returns(int){
        return state;
    }
    //改变状态
    function changeState(int data) public returns(int){
        state = data;
        return state;
    }
    //回调函数，用于判断调用是否真的指向目标函数
    fallback() external {
        state = 6;
    }
 }

 //发起调用的合约
 contract arrow{
    
    address public target;
    constructor(address _target){
        target=_target;
    }

    //不改变状态的staticcall，调用成功，获取traget合约中的状态数据
    function getState() public  returns(bool,bytes memory){
        return target.staticcall(abi.encodeWithSignature("getState()"));
    }
    //试图改变target状态的staticcall，调用失败
    function changeState(int data) public  returns(bool,bytes memory){
        return target.staticcall(abi.encodeWithSignature("changeState(int256)",data));
    }    
    //对照组，试图改变target状态的call，调用成功并能改变target的状态变量
    function changeStatePlus(int data) public returns(bool,bytes memory){
        return target.call(abi.encodeWithSignature("changeState(int256)",data));
    }

 }

