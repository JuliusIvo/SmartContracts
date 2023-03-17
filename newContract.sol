// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract newContract {
    mapping (address => uint256) public balanceOfAdress;
    struct member{
        address key;
        bool agreement;
    }

    member private manufacturer;
    member private retailer;
    member private courier;

    uint courierPayment;
    uint courierOffer;
    uint amountAgreedUpon;

    constructor (){
        manufacturer.key = msg.sender;
        manufacturer.agreement = false;
        balanceOfAdress[manufacturer.key] = 100;

        retailer.key = 0x88338244914f22065F5F42BC01013E57198b5B1C;
        retailer.agreement = false;
        balanceOfAdress[retailer.key] = 100;

        courier.key = 0x43197936cDDB0477EB63E729Aa1263f57D66551d;
        courier.agreement = false;
        balanceOfAdress[courier.key] = 100;

    }

    function getReitailerBalance() public view returns (uint){
        return balanceOfAdress[retailer.key];
    }

     function getManufacturer() public view returns(address) {
        return manufacturer.key;
    }

    function getRetailer() public view returns(address) {
        return retailer.key;
    }
    
    function getCourier() public view returns(address) {
        return courier.key;
    }

    function getCourierOffer() public view returns (uint){
        return courierOffer;
    }

    function getCourrierPayment() public view returns (uint){
        return courierPayment;
    }

    function setAmount(uint amount) public payable returns (uint){
        amountAgreedUpon = amount;
        return amountAgreedUpon;
    }

    function getAmount() public view returns (uint){
        return amountAgreedUpon;
    }


    event transfer(address to, address from, uint amount);
    event switchAprroval(address Address, bool switchTo);

    function offerForCourier(uint amount) public payable returns (uint){
        courierOffer = amount;
        return courierOffer;
    }
    
    function Transfer(address to, address from, uint amount) public payable returns (bool success){
        require(amount < balanceOfAdress[from], "value exceeds the balance of the sender");
        balanceOfAdress[from] -= amount;
        balanceOfAdress[to] += amount;
        emit transfer(to, from, amount);
        return true;
    }

    function SwitchAprroval(address Adress) public payable returns (bool success){
        if(Adress == courier.key){
            courier.agreement = true;
            courierPayment = courierOffer;
            Transfer(Adress, retailer.key, getCourrierPayment());
            Transfer(Adress, manufacturer.key, getAmount());
            emit switchAprroval(Adress, true);
            return true;
        }
        else if (Adress == retailer.key){
            retailer.agreement = true;
            if(courier.agreement = true){
            Transfer(Adress, courier.key, getAmount());
            }
            emit switchAprroval(Adress, true);
            return true;
        }
        else {
            emit switchAprroval(Adress, false);
            return false;
        }
    }

}