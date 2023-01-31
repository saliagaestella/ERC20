// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract LegalSalesContract {
    uint256 public price;
    address payable public seller;
    address payable public buyer;
    bool public saleCompleted = false;

    constructor(uint256 _price, address payable _seller) {
        price = _price;
        seller = _seller;
    }

    function purchase() public payable {
        require(!saleCompleted, "Sale has already been completed.");
        require(msg.value >= price, "Payment value is less than the price.");

        buyer = payable(msg.sender);
        saleCompleted = true;

        seller.transfer(msg.value);
    }

    function refund() public payable {
        require(saleCompleted, "Sale has not been completed.");
        require(msg.sender == seller, "Only the seller can send a refund.");
        require(msg.value >= price, "Payment value is less than the price.");

        buyer.transfer(msg.value);
        saleCompleted = false;
    }
}
