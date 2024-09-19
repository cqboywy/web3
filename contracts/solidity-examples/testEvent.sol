pragma solidity >0.8.0;

contract testEvent {
    constructor() public {
    }
        
    event Deposit(address _from, uint _value);  // 定义事件

    function deposit(uint value) public {
        // 忽略其他的代码
        emit Deposit(msg.sender, value);  // 触发事件
    }
  }