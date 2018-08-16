pragma solidity 0.4.24;

/** This contract is used to have the features of
 * a basic ERC20 token.
 */

contract ERC20Basic {

  /** 
   * @dev - This function is used to know the total supply of the tokens
     @return - It returns the value of total supply
   */
  function totalSupply() public view returns (uint256);

  /** 
   * @dev - This contract is used to find the balance from the given address
     @param who - The address of the user
     @return - The value of tokens there in the given address
   */
  function balanceOf(address who) public view returns (uint256);

  /**
   * @dev - This contract is used to transfer the tokens from given address
     @param to - The address to whom we send our tokens
     @param value - The amount of tokens to transfer
     @return - It shows whether the transfer operation gets success or not.
   */
  function transfer(address to, uint256 value) public returns (bool);

  /** This Transfer event pings user that the operation happenned successfully */
  event Transfer(address indexed from, address indexed to, uint256 value);
}
