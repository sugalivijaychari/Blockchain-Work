pragma solidity 0.4.24;

/** This contract is used to have the permissions as a owner 
 * to operate the entire eco system of initial coin offering.
 * This contract is also used to transfer the ownership from 
 * one address to the other.
 * Caution - Be careful while dealing with this contract.
 */

contract Ownable {

  /** The ethereum wallet address of the owner */
  address public owner;

  /** Events are always used to ping the user interface 
   * to make it sense the completion of a particular operation
   * happen in smart contracts.
   * @dev - To make Ui know that the ownership is transferred to other
     @param previousOwner - The address of the previous owner
     @param newOwner - The address of the new owner
   */
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /** Always constructors of any contracts executes at only once.
   * This constructor is used to allocate the owner of the contract.
   * As Ownable contracts control the entire eco system
   * of initial coin offering, the address by which this contract
   * is deployed will get complete authority over ICO.
   */
  constructor() public {
    owner = msg.sender;
  }

  /** onlyOwner modifier is used as access to owner
   * to do operations over functions which is having
   * this modifier.
   * Other addresses expect owner can't perform the 
   * operations to function having this modifier.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /** 
   * @dev - This function is used to transfer the ownership 
     @param newOwner - Address of the new owner
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}
