pragma solidity >=0.6.0 <=0.7.0;
contract Trust {

    address payable owner;
    address payable beneficiary;
    
    //modifiers
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
     
     //onlyBeneficiary
     modifier onlyBeneficiary(){
        require(msg.sender == beneficiary);
        _;
    }

    constructor (address payable _beneficiary) public payable {
        owner = msg.sender;
        beneficiary = _beneficiary;
    }
    
    function retrieveFund() public onlyOwner {
        bool sent = owner.send(address(this).balance);
        require(sent, "Failed to send Ether");
    }
    
    function deposit() public payable {
    }
    
    function getBalance() public view onlyOwner returns (uint){
        return address(this).balance;
    }
}
