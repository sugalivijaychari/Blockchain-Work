pragma solidity 0.4.24;

/** This is the user defined library to use
 * basic math operations in a secure manner.
 */

library SafeMath {
   
  /**
   * @dev - multiplication operation
     @param a - first operand
     @param b - second operand
     @return - the result of multiplication
   */ 
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {

    /** This condition checks whether a is 0.
     * If it is zero, then it returns 0.
     */
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    /** If the operation fails to execute according
     * to the multiplication rules, then this operation throws
     */
    assert(c / a == b);
    return c;
  }

  /**
   * @dev - division operation
     @param a - first operand
     @param b - second operand
     @return - the result of division
   */ 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    return c;
  }
  
  /**
   * @dev - subtraction operation
     @param a - first operand
     @param b - second operand
     @return - the result of subtraction
   */ 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    /** if b is greater than a, then it throws error */
    assert(b <= a);
    return a - b;
  }

  /**
   * @dev - addition operation
     @param a - first operand
     @param b - second operand
     @return - the result of addition
   */ 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    /** It throws error if calculation gets wrong */
    assert(c >= a);
    return c;
  }
}
