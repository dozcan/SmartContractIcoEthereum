pragma solidity ^0.4.18;

 

contract ERC20Interface {

    function totalSupply() public constant returns (uint);

    function balanceOf(address tokenOwner) public constant returns (uint balance);

    function transfer(address to, uint tokens) public returns (bool success);

 

    event Transfer(address indexed from, address indexed to, uint tokens);

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

}

 

library SafeMath {

    function add(uint a, uint b) internal pure returns (uint c) {

        c = a + b;

        require(c >= a);

    }

    function sub(uint a, uint b) internal pure returns (uint c) {

        require(b <= a);

        c = a - b;

    }

    function mul(uint a, uint b) internal pure returns (uint c) {

        c = a * b;

        require(a == 0 || c / a == b);

    }

    function div(uint a, uint b) internal pure returns (uint c) {

        require(b > 0);

        c = a / b;

    }

}

 

contract LoyaltyToken is ERC20Interface

{

  using SafeMath for uint;

  //token supply added

  uint256 public constant _totalSupply = 1000000;

  mapping(address=>uint256) balances;

  string public constant symbol = "LYCT";

  string public constant name = "loyalty card token";

  uint8 public constant decimals = 3;

  address owner;

 

  

  //ETHEREUM BASINA 500 LYCT VERİLECEK

  uint256 public constant rate = 500;

 

  constructor() public {

      balances[msg.sender]=_totalSupply;

  }

 

  function balanceOf(address _owner) public view returns(uint256 balance){

      return balances[_owner];

  }

 

  function transfer(address to, uint tokens) public returns (bool success) {

        balances[msg.sender] = balances[msg.sender].sub(tokens);

        balances[to] = balances[to].add(tokens);

        emit Transfer(msg.sender, to, tokens);

        return true;

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

      uint256 userDonationValue = msg.value.mul(rate);

      balances[msg.sender] =balances[msg.sender].add(userDonationValue);

      owner.transfer(msg.value);
  }
   function transferAnyERC20Token(address tokenAddress, uint tokens) public  returns (bool success) {
        return ERC20Interface(tokenAddress).transfer(owner, tokens);
    }
}
