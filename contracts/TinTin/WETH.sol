// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/Math.sol";

contract WETH is ERC20 {

    constructor() ERC20("Wrapped Ether", "WETH") {}

    function deposit() public    payable {
        _mint(msg.sender,msg.value*2);
    }

    // 存款功能：发送ETH到这个合约地址，会得到等值的WETH代币
    receive() external payable {
        deposit();
    }

    // 取款功能：销毁WETH代币并从合约中提取相应的ETH
    function withdraw(uint256 wad) public {
        _burn(msg.sender, wad);
        payable(msg.sender).transfer(wad);
    }

    function getContractBalance() public view returns (uint) {
    return address(this).balance;
}
}