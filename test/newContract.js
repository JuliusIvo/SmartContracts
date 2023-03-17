const { assert } = require("console");

const NewContract = artifacts.require('newContract');

contract('newContract', () => {
    it('should deploy properly', async () => {
        const newContract1 = await NewContract.deployed();
        const courierAddress = await newContract1.getCourier();
        const retailerAddress = await newContract1.getRetailer();
        const senderAdress = await newContract1.getManufacturer();
        await newContract1.setAmount(10);
        await newContract1.offerForCourier(2);
        const result = await newContract1.getAmount();
        console.log(newContract1.address);
        await newContract1.SwitchAprroval(courierAddress);
        await newContract1.SwitchAprroval(retailerAddress);
        const courierPayment = await newContract1.getCourrierPayment();
        assert(result === 10);
        assert(senderAdress === "0xd89c19DE750701C6E4C2B19898aFBFc9421fDD27");
        console.log("address= " + senderAdress);
        console.log("result= "+ result);    
        console.log("courier offer = " + courierPayment);
        console.log("retailer balance = " + await newContract1.getReitailerBalance());
    });
});