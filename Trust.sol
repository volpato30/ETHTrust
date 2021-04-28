pragma solidity >=0.6.0 <=0.7.0;
contract Trust {

    address payable owner;
    address payable beneficiary;
    uint256 lastUpdateTime;
    uint16 numDays;
    
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
    
    modifier onlyParticipants() {
        require(msg.sender == owner || msg.sender == beneficiary);
        _;
    }

    constructor (address payable _beneficiary, uint16 _numDays) public payable {
        owner = msg.sender;
        beneficiary = _beneficiary;
        numDays = _numDays;
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
    
    function update() public onlyOwner {
        lastUpdateTime = now;
    }
    
    function claim() public onlyBeneficiary {
        if(now - lastUpdateTime > numDays * 1 days) {
            bool sent = owner.send(address(this).balance);
            require(sent, "Failed to send Ether");
        }
    }
    
    function getLastUpdateTime() public view onlyParticipants returns (uint256){
        return lastUpdateTime;
    }
    
    function notifyBeneficiary() public onlyOwner payable {
        bool sent = beneficiary.send(msg.value);
        require(sent, "Failed to send Ether");
    }
}
