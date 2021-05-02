pragma solidity >=0.6.0 <=0.6.1;
contract TrustHolder {
    struct Trust {
        address payable owner;
        address payable beneficiary;
        uint256 lastUpdateTime;
        uint16 numDays;
        uint balance;
    }
    
    mapping(uint32 => Trust) trusts;
    address chairperson;
    
    modifier onlyChair() {
        require(msg.sender == chairperson);
        _;
    }
    
    constructor () public {
        chairperson = msg.sender;
    }
    
    function registerTrust(address payable _owner, address payable _beneficiary, uint16 _numDays, uint32 trustID) public onlyChair payable {
        // registration should only be done when id does not exist 
        require(trusts[trustID].lastUpdateTime == 0);
        trusts[trustID].owner = _owner;
        trusts[trustID].beneficiary = _beneficiary;
        trusts[trustID].lastUpdateTime = now;
        trusts[trustID].numDays = _numDays;
        trusts[trustID].balance = msg.value;
    }
    
    function returnFundToOwner(uint32 trustID) public onlyChair {
        address payable owner = trusts[trustID].owner;
        bool sent = owner.send(trusts[trustID].balance);
        require(sent, "Failed to send Ether");
    }
    
    function addFund(uint32 trustID) public payable {
        // only allow add fund to an existing trust
        require(trusts[trustID].lastUpdateTime > 0);
        trusts[trustID].balance = trusts[trustID].balance + msg.value;
    }
    
    function claim(uint32 trustID) public {
        // only beneficiary can call this function;
        require(trusts[trustID].beneficiary == msg.sender);
        
        if(now - trusts[trustID].lastUpdateTime > trusts[trustID].numDays * 1 days) {
            bool sent = msg.sender.send(trusts[trustID].balance);
            require(sent, "Failed to send Ether");
        }
    }
    
    function updateTime(uint32 trustID) public {
        require(trusts[trustID].owner == msg.sender);
        trusts[trustID].lastUpdateTime = now;
    }
    
    function getLastUpdateTime(uint32 trustID) public view returns (uint256){
        return trusts[trustID].lastUpdateTime;
    }
}
