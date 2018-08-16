pragma solidity 0.4.24;

/** This contract is used to stop the whole eco system of crypto currency */

import "./Ownable.sol";

contract Pausable is Ownable {

  // Event which tells that crypto currency of this token system is paused
  event Pause();

  // Event which tells that crypto currency of this token system is unpaused
  event Unpause();

  bool public paused = false;

  // The modifier which uses as inbuilt check whether token system is paused or not
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  modifier whenPaused() {
    require(paused);
    _;
  }

  // Function which makes token system pause
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    emit Pause();
  }

  // Function which makes token system unpause
  function unpause() onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
  }
}
