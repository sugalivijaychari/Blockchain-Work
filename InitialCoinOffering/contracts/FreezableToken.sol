pragma solidity 0.4.24;

import "./PausableToken.sol";

/** This contract is used to freeze some accounts */

contract FreezableToken is PausableToken{

    // This mapping data structure is used to have data whether a particular account is freezed or not.
    mapping(address => bool) public frozenAccount;

    // Intimate Ui saying that freeze operation is done.
    event FrozenFunds(address target, bool frozen);

    /**
     * @dev - This function freezeAccount is used to freeze a particular address from not using the token system
       @param target - The address of user to freeze the account
       @param freeze - Boolean value to freeze or unfreeze
     */
    function freezeAccount(address target, bool freeze) onlyOwner public{
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[msg.sender]);

        // It checks whether an account is freezed or not. Tranfer only allows unfreezed accounts.
        require(!frozenAccount[_to]);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        // It checks whether an account is freezed or not. Tranfer only allows unfreezed accounts.
        require(!frozenAccount[_from]);

        // It checks whether an account is freezed or not. Tranfer only allows unfreezed accounts.
        require(!frozenAccount[_to]);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

}
