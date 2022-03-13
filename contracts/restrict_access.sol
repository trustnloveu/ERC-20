// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.7.0 < 0.9.0;

/*****************************************************************************************************************

    Restricted Access to a contract: 

        By Default, a contract state is read-only unless it is specified as public.
        We can restrict who can modify the contract's state or call a contract's functions `using modifiers`. 


    onlyBy      : only the mentioned caller can call this function.
    onlyAfter   : called after certain time period.
    costs       : call this function only if certain value is provided.


 *****************************************************************************************************************/



contract RestrictedAcces {
    
    address public owner = msg.sender;
    uint public creationTime = block.timestamp;

    /******************************  Modifiers  ******************************/

    // require the current caller to be equal to an account address which we set as an input in the modifier
    modifier onlyBy(address _account) {
        require(msg.sender == _account, "Sender not authorized!");
        _;
    } 
    
    modifier onlyAfter(uint _time) {
        require(block.timestamp >= _time, "function is called too early!");
        _;
    }
        
    modifier enoughEther(uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided");
        _;
    }

    /******************************  Functions  ******************************/
    
    // change the owner address
    function changeOwnerAddress(address _newAddress) onlyBy(owner) public {
        owner = _newAddress;
    } 
    
    // delete the current owner 
    function disown() onlyBy(owner) onlyAfter(creationTime + 5 weeks) public {
        delete owner;
    } 
    
    // force to change the owner address only if having 200 ether at least
    function forceOwnerChange(address _newOwner) payable public enoughEther(200 ether) {
        owner = _newOwner;
    }
    
}