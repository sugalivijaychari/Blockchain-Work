pragma solidity 0.4.24;

import "../BytesExtraction.sol";
import "./Whitelist.sol";

/** This contract is used to have the investor details through KYC */

contract KYCwhitelist is Whitelist{
    
    // To use bytes library
    using BytesExtraction for bytes;

    // The count of whitelist investors which are invested using their KYC
    uint256 whitelistInvestorsViaKYC;
    
    // Structure which is having the details of investors
    struct investorInfo{

        // Investor aadhar id
        uint128 whitelistInvestorUID;

        // Investor unique id
        uint256 whitelistInvestorUniqueId;

        // Investment amount
        uint256 whitelistInvestorTokensAmount;  
    }
    
    // The structure of each investor is mapped with its acount address
    mapping(address => investorInfo) whitelistInvestor;

    // An array having the addresses of investors
    address[] whitelistInvestors;
    

    event OrderKYCInvestment(bytes data, uint256 _uniqueId, uint256 _tokensInvested);
    
    /**
     * @dev - This function is used to invest in whitelist with KYC module
       @param data - The data of the user in bytes format
       @param _uniqueId - The unique id of the investor
       @param _tokensInvested - Amount of tokens to invest in whitelist
       @return - Checks whether this order is success or not
     */
    function orderKYCInvestment(bytes data, uint256 _uniqueId, uint256 _tokensInvested) public onlyOwner returns(bool){
        
        // Boolean value to store whether the operation got success or not
        bool success;

        // Converting bytes data into address format for the address of the investor
        address _whitelistInvestorAddr = data.extractAddress(0);

        // Converting bytes data into aadhar id of the investor
        uint128 _whitelistInvestorUID = uint128(data.extract16bytes(20));

        // It adds investor in whitelist data
        success = addInvestor(_uniqueId, _whitelistInvestorAddr, _tokensInvested);

        // If operation got success, we proceed further.
        require(success==true);

        // We push the investors address into the data
        whitelistInvestors.push(_whitelistInvestorAddr);

        // Investors count get increased with one
        whitelistInvestorsViaKYC = whitelistInvestorsViaKYC.add(1);

        // We assign aadhar data for the investor
        whitelistInvestor[_whitelistInvestorAddr].whitelistInvestorUID = _whitelistInvestorUID;

        // We aassign unique id of the investor in structure data
        whitelistInvestor[_whitelistInvestorAddr].whitelistInvestorUniqueId = _uniqueId;

        // We update the investment tokens
        whitelistInvestor[_whitelistInvestorAddr].whitelistInvestorTokensAmount = _tokensInvested;

        // Intimates the Ui about this operation
        emit OrderKYCInvestment(data, _uniqueId, _tokensInvested);

        // Returns success if the above operation gets success
        return success;
    }
    
    /**
     * @dev - It gives the details of the investor
       @param _kycInvestor - The address of the investor
       @return - It returns the tuple having the details of the investor
     */
    function getKYCInvestorDetails(address _kycInvestor)public view returns(uint128, uint256, uint256){
        return (whitelistInvestor[_kycInvestor].whitelistInvestorUID, whitelistInvestor[_kycInvestor].whitelistInvestorUniqueId, whitelistInvestor[_kycInvestor].whitelistInvestorTokensAmount);
    }
    
}