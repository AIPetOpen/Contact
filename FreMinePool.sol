// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.0;
import "./TransferHelper.sol";
 
contract FreMinePool
{
    address _MainContract;
    address _token;
    address _feeowner;
    address _owner;
    using TransferHelper for address;

    constructor(address tokenaddress,address feeowner, address owner) //Create by main
    {
        _MainContract=msg.sender;
        _token=tokenaddress;
        _feeowner=feeowner;
        _owner = owner;
    }
 
    function MineOut(address to,uint256 amount,uint256 fee) public returns(bool){
        require(msg.sender==_MainContract);
        _token.safeTransfer(to, amount);
        if (fee != 0) {
            _token.safeTransfer(_feeowner, fee);
        }
        return true;
    }

    function resetTo(address newcontract) public {
        require(msg.sender == _owner);
        _MainContract = newcontract;
    }
}