pragma solidity 0.4.24;

import "./BasicToken.sol";
import "./ERC20.sol";

/** This contract is used to implement the features of ERC20 and 
 * also used to have functions to deal with transactions using this token.
 */

contract StandardToken is ERC20, BasicToken {

  /** This mapping data structure named allowed is used to store
   * the amount of tokens to be approved from one account to the other account.
   */
  mapping (address => mapping (address => uint256)) internal allowed;

  /**
   * @dev - This function is used to transfer some value of amount from one account to the other.
     @param _from - The address by which tokens are given 
     @param _to - The adress by which tokens are taken
     @param _value - The amount of tokens to be transferred
     @return - Confirms whether this operation is success or not
   */
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {

    // Transaction to the own account cannot be possible
    require(_to != address(0));

    // There must be sufficient amount of tokens in the account
    require(_value <= balances[_from]);

    // Transacting tokens from one to other needed sufficient tokens in approval
    require(_value <= allowed[_from][msg.sender]);

    // Tokens from sender reduced from its accont
    balances[_from] = balances[_from].sub(_value);

    // Tokens from receiver increased to its aacount
    balances[_to] = balances[_to].add(_value);

    // approved tokens are reduced from sender account
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    
    emit Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev - This funciton is used give approval for an address to spend some amount of tokens from our own address
     @param _spender - The address of the receiver
     @param _value - The amount of tokens to be approved for transfer of tokens
     @return - Confirms whether this operation is success or not.
   */
  function approve(address _spender, uint256 _value) public returns (bool) {

    // Amount of tokens to be allowed to approve for an address
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev - This function is used to give permission for an address to spend tokens.
     @param _owner - The address from whom tokens are spent
     @param _spender - The address who receives tokens
     @return - amount that owner can spent to spender
   */
  function allowance(address _owner, address _spender) public view returns (uint256) {

    //returns the value of approved amount of tokens
    return allowed[_owner][_spender];
  }

  /**
   * @dev - This function is used to increase the approval amount to an address
     @param _spender - The address in which approved tokens to be added
     @param _addedValue - The amount of tokens to be added
     @return - confirms whether this operation is success or not
   */
  function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev - This function is used to decrease the approval amount to an address
     @param _spender - The address in which approved tokens to be subtracted
     @param _subtractedValue - The amount of tokens to be subtracted
     @return - confirms whether this operation is success or not
   */
  function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }
}
