// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract LegalLeasingContract {
    address payable public landlord;
    address payable public tenant;
    uint256 public rent;
    uint256 public leasePeriod;
    uint256 public startTime;
    uint256 public endTime;
    uint256 public intervalBetweenPayments;
    uint256 public paidAt;

    constructor(uint256 _rent, address payable _landlord, address payable _tenant) {
        landlord = _landlord;
        tenant = _tenant;
        rent = _rent;
        startTime = block.timestamp;
        leasePeriod = 40 weeks;
        intervalBetweenPayments = 4 weeks;
        paidAt = 0;
        endTime = startTime + leasePeriod;
    }

    function payrent() public payable {
        require(tenant != address(0), "The lease has already been taken.");
        require(msg.value == rent, "The payment value is different from the rent amount.");
        require(block.timestamp >= intervalBetweenPayments + paidAt);

        paidAt = block.timestamp;
        landlord.transfer(msg.value);
    }

    function endLease() public {
        require(tenant == msg.sender, "Only the tenant can end the lease.");
        require(block.timestamp >= endTime, "The lease period has not ended yet.");

        tenant = payable(address(0));
    }

    function timeLeft() public view returns(uint){
            return endTime-block.timestamp;
        }
    
    function timeLeftForPayment() public view returns(uint){
            return paidAt+intervalBetweenPayments-block.timestamp;
        }
}
