// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

// 定义WETH合约的接口
interface IWETH is IERC20 {
    function deposit() external payable;
}

contract WETHDepositor {
    // WETH合约地址
    address public wethAddress;

    // 事件定义
    event Deposit(address indexed sender, uint256 value);

    // 构造函数，设置WETH合约地址
    constructor(address _wethAddress) {
        wethAddress = _wethAddress;
    }

    fallback() external payable {}

    // 接收以太币的函数
    receive() external payable {
        depositToWETH();
    }

    // 存款到WETH合约
    function depositToWETH() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
         // 触发事件，记录 msg.sender 和 msg.value
        emit Deposit(msg.sender, msg.value);

        // 创建WETH合约实例
        IWETH weth = IWETH(wethAddress);

        // 调用WETH合约的deposit方法，并发送msg.value数量的以太币
        (bool success, ) = address(weth).call{value: msg.value}(abi.encodeWithSelector(weth.deposit.selector));
        require(success, "Deposit to WETH failed");
    }
}