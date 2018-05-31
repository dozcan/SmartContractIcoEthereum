pragma solidity ^0.4.17;

contract LoyaltyToken
{
  //token supply added 
  uint256 public constant totalSupply = 1000000;
  mapping(address=>uint256) balances;
  string public constant symbol = "LYCT";
  string public constant name = "loyalty card token";
  uint8 public constant decimals = 3;
  address owner;
  
  
  //ETHEREUM BASINA 500 LYCT VERİLECEK
  uint256 public constant rate = 500;
  
  constructor() public {
      balances[msg.sender]=totalSupply;
  }
  
  function balanceOf(address _owner) public view returns(uint256 balance){
      return balances[_owner]; 
  }

  function contractBalance() public view returns(uint256 balance){
      return balances[owner];
  }
  
  //fallback function tanımlıyoruz. contract adresine ether yolladığında bu fonksiyon otomatik çalışır
  
  function() public payable{
      donationPay();
  }
  
  function donationPay() public payable {
          require(
          msg.value>=0
          );
      
      //ether gönderen kişinin nekadar token alacağı hesaplanıyor
      uint256 userDonationValue = mul(msg.value,rate);
      balances[msg.sender] =add(balances[msg.sender],userDonationValue);
      owner.transfer(msg.value);
  }

  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}
