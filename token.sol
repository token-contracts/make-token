/*
    Copyright 2020 DPAY Core.
    SPDX-License-Identifier: Apache-2.0
*/
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from "./lib/SafeMath.sol";


/**
 * @title 
 * @author hy Broker 
 */
contract MakeToken {
    using SafeMath for uint256;

    string public symbol = "MT";
    string public name = "Make Token";

    uint256 public decimals = 18;

    uint256 public totalSupply = 100000000 * 10**18;

    mapping(address => uint256) internal balances;
    mapping(address => mapping(address => uint256)) internal allowed;
    
    //=========Event=========
    event Transfer(address indexed from,address indexed to, uint256 amount);

    event Approval(address indexed owner, address indexed spender , uint256 amount);

    //=========Function=======
    constructor(string memory simpleName, string memory detailName,uint256  total)public{
        require(bytes(simpleName).length>0,"name is null");
        balances[msg.sender] = total * totalSupply;
        symbol = simpleName;
        name = detailName;

    }

    function transfer(address to,uint256 amount) public returns(bool){
        require(amount<=balances[msg.sender],"BALANCE_NOT_ENOUGH");

        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[to]=balances[to].add(amount);
        emit Transfer(msg.sender,to,amount);
        return true;
    }

    function balanceOf(address owner) external view returns (uint256 balance){
        return balances[owner];
    }

    function transferFrom(address from, address to, uint256 amount)public returns(bool) {
        require(amount <= balances[from], "BALANCE_NOT_ENOUGH");
        require(amount <=allowed[from][msg.sender],"ALLOWANCE_NOT_ENOUGH");

        balances[from] = balances[from].sub(amount);
        balances[to] = balances[to].add(amount);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(amount);
        emit Transfer(from,to,amount);
        return true;

    }

    function approve(address spender, uint256 amount) public returns (bool){
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner,address spender) public view returns(uint256){
        allowed[owner][spender];
    }



}
