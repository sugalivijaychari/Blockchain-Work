pragma solidity 0.4.24;

import "./Whitelist.sol";

// This contract is used to disable and enable investors in  whitelist

contract RemovedWhitelist is Whitelist{
    
    // once a investor invests, funds are irreversible - so we can enable or disable the account
    
    /**
     * @dev - This function is used to disable an investor
       @param _investorAddr - The address of the investor
     */
    function disableInvestor(address _investorAddr)public onlyOwner{
        activeWhitelist[_investorAddr]=false;
        freezeAccount(_investorAddr,true);
    }
    
    /**
     * @dev - This function is used to enable an investor
       @param _investorAddr - The address of the investor
     */
    function enableInvestor(address _investorAddr)public onlyOwner{
        activeWhitelist[_investorAddr]=true;
        freezeAccount(_investorAddr,false);
    }
    
}