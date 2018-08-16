pragma solidity 0.4.24;

import "./ERC20Basic.sol";

/** This contract is used have the additional features
 * based on ERC20.
 */

contract ERC20 is ERC20Basic {

  /**
   * @dev - This function is used to give permission for an address to spend tokens.
     @param owner - The address from whom tokens are spent
     @param spender - The address who receives tokens
     @return - amount that owner can spent to spender
   */
  function allowance(address owner, address spender) public view returns (uint256);

  /**
   * @dev - This function is used to transfer some value of amount from one account to the other.
     @param from - The address by which tokens are given 
     @param to - The adress by which tokens are taken
     @param value - The amount of tokens to be transferred
     @return - Confirms whether this operation is success or not
   */
  function transferFrom(address from, address to, uint256 value) public returns (bool);

  /**
   * @dev - This funciton is used give approval for an address to spend some amount of tokens from our own address
     @param spender - The address of the receiver
     @param value - The amount of tokens to be approved for transfer of tokens
     @return - Confirms whether this operation is success or not.
   */
  function approve(address spender, uint256 value) public returns (bool);

  /**
   * @dev - This event is used to intimate Ui saying that approval is completed
     @param owner - The address of user which is approved to spend some tokens from this address
     @param spender - The address of receiver 
     @param value - Amount of tokens to be approved
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
