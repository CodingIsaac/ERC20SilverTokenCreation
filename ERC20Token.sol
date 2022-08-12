// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**

Create an ERC20 token with the standard functions

1. Deposit function
2. Total supply.
3. Balnce of the tokens
4. Transfer function
5. Approval of someone else to send tokens
6. DEtermine the allowance
7. using mapping... map your 
address to the address of the approved acount and determine the token allocation



*/ 


contract EIP20Interface {
    uint256 public totalSupply;
    string public name = "Silver";
    string public symbol = "SVR";
    uint public decimal = 0;
    address public creator;
    mapping(address => uint) public balance;
    mapping(address => mapping(address => uint)) permission;

    event Transfer(address indexed from, address to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);


    constructor() {

        creator = msg.sender;
        totalSupply = 210000;
        balance[creator] = totalSupply;

    }

    function balanceOf(address _owner) public view returns(uint _balance) {
        return balance[_owner];
    }

    function transfer(address _to, uint tokens) public returns (bool success) {
        require (balance[msg.sender] >= tokens, "Insufficient Funds");
        balance[msg.sender] -= tokens;
        balance[_to] += tokens;
        emit Transfer(msg.sender, _to, tokens);
        return true;

    }

        function approve (address spender, uint tokens) public returns(bool success) {
            require(balance[msg.sender] >= tokens, "Insufficent Balance");
            require(tokens > 0, "Insufficient Tokens");

            permission[msg.sender][spender] = tokens;
            emit Approval (msg.sender, spender, tokens);


            return true;
        }

        function allowance(address tokenOwner, address spender) public view returns(uint) {
            return permission [tokenOwner][spender];       
                       
            
        }

        function transferFrom(address from, address to, uint tokens) public returns(bool sucess) {
            require(permission[from ][msg.sender] >= tokens);
            require(balance[from] >= tokens);
            balance[from] -= tokens;
            permission[from] [msg.sender]-= tokens;
            balance[to] += tokens;
            emit Transfer(from, to, tokens);
            return true;


        }

    


}

