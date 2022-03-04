// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol
interface IERC20 {

    /********************* Essential *********************/
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);

    /********************* Optional *********************/
    // function allowance(address owner, address spender) external view returns (uint);
    // function approve(address spender, uint amount) external returns (bool);
    // function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    /********************* Event *********************/
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

// Token
contract Token is IERC20 {
    string public name = "UpCrypto";
    string public symbol = "UPCT";

    uint public decimals = 0; // [ 0 ~ 18 ] is a Range of Decimal State Variable
    uint public override totalSupply;
    address public founder;
    mapping(address => uint) public balances;

    constructor() {
        totalSupply = 1000000; // = 1,000,000
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address tokenOwner) public view override returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address recipient, uint amount) public override returns (bool success) {
        require(balances[msg.sender] >= amount);

        balances[recipient] += amount;
        balances[msg.sender] -= amount;

        emit Transfer(msg.sender, recipient, amount);

        return true;
    }
}