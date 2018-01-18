pragma solidity ^0.4.18;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract owned {
    address public owner;

    function owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

}

contract ERC20Basic {
  uint256 public totalSupply;
  /**
  function totalSupply() constant external returns (uint256) {
      return _supply;
  }
  */
  function balanceOf(address owner) public constant returns (uint256 balance);
  function transfer(address to, uint256 value) public returns (bool success);
  event Transfer(address indexed from, address indexed to, uint256 value);
}
 
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public constant returns (uint256 remaining);
  function transferFrom(address from, address to, uint256 value) public returns (bool success);
  function approve(address spender, uint256 value) public returns (bool success);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract BasicToken is ERC20Basic {
    
  using SafeMath for uint256;
 
  mapping (address => uint256) public balances;
 
  function transfer(address _to, uint256 _value) returns (bool) {
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  function balanceOf(address _owner) constant returns (uint256 balance) {
    return balances[_owner];
  }
 
}

contract StandardToken is ERC20, BasicToken {
 
  mapping (address => mapping (address => uint256)) allowed;
 
  function transferFrom(address _from, address _to, uint256 _value) returns (bool) {
    var _allowance = allowed[_from][msg.sender];
    balances[_to] = balances[_to].add(_value);
    balances[_from] = balances[_from].sub(_value);
    allowed[_from][msg.sender] = _allowance.sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value) returns (bool) {
    require((_value == 0) || (allowed[msg.sender][_spender] == 0));
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }
 
}

contract UNICToken is owned, StandardToken {
    
    using SafeMath for uint;
    
    string public constant name = 'UNICToken';
    string public constant symbol = 'UNIC';
    uint8 public constant decimals = 18;
    
    uint256 public totalSupply = 250000000 * 10 ** uint256(decimals);
    
    uint256 public INITIAL_SUPPLY = 250000000 * 1 ether;

    function UNICToken() {
      totalSupply = INITIAL_SUPPLY;
      balances[msg.sender] = INITIAL_SUPPLY;
    }
    
}

contract Crowdsale is owned {
    
  using SafeMath for uint;
  
  UNICToken public token = new UNICToken();
  
  address multisig;
  uint restrictedPercent;
  address restricted;
  uint start;
  uint period;
  uint rate;
 
  function Crowdsale() {
    multisig = 0xDE4951a749DE77874ee72778512A2bA1e9032e7a;
    restricted = 0x6c8F5c49BAdFeC3C4D19c57410d7FB1C93643ad0;
    restrictedPercent = 40;
    rate = 100000000000000000000;
    start = 1500379200;
    period = 28;
  }
 
  modifier saleIsOn() {
    require(now > start && now < start + period * 1 days);
    _;
  }
 
  function sellTokens() saleIsOn payable {
    multisig.transfer(msg.value);
    uint tokens = rate.mul(msg.value).div(1 ether);
    uint bonusTokens = 0;
    if(now < start + (period * 1 days).div(4)) {
      bonusTokens = tokens.div(4);
    } else if(now >= start + (period * 1 days).div(4) && now < start + (period * 1 days).div(4).mul(2)) {
      bonusTokens = tokens.div(10);
    } else if(now >= start + (period * 1 days).div(4).mul(2) && now < start + (period * 1 days).div(4).mul(3)) {
      bonusTokens = tokens.div(20);
    }
    uint tokensWithBonus = tokens.add(bonusTokens);
    token.transfer(msg.sender, tokensWithBonus);
    uint restrictedTokens = tokens.mul(restrictedPercent).div(100 - restrictedPercent);
    token.transfer(restricted, restrictedTokens);
  }
 
  function() external payable {
    sellTokens();
  }
    
}
