// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract Coin {

    // The keyword "public" makes variables accessible from other contracts
    address public minter;
    mapping (address => uint) public balances;

     /* 
        `Events` allows clients to react to specific contract changes you declare
        
        Event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in transaction logs. 
        These logs are stored on blockchain and are accessible using address of the contract till the contract is present on the blockchain. 
     */ 
    event Sent(address from, address to, uint amount);

    constructor() {
        minter = msg.sender;
    }

    // Send an amount of newly created coins to an address
    // Can only be called by the contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);

        balances[receiver] += amount;
    }

    // `Error` allows you to provide information about why an operation failed. They are returned to the caller of the function.
    error insufficientBalance(uint requested, uint available);

    // Send an amount of existing coins from any caller to an address
    function send(address receiver, uint amount) public {
        
        if (amount > balances[msg.sender]) {
            revert insufficientBalance(
                {
                    requested: amount,
                    available: balances[msg.sender]
                }
            );
        }

        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        emit Sent(msg.sender, receiver, amount);
    }
}