
pragma solidity 0.8.2;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import './StringUtils.sol';




  // @dev contract for rock,paper game0
contract AssetAcquisition is    Ownable,ERC20 {
    
    


    string private _tokenname ="MATTokens";
    string private _tokensymbol= "MAT";
    address public _owner;
    uint randNonce =0;
    uint modulus =0;
  
    uint maxWaitTime = 100;
         
  
                struct Assets{
            address    owner;
            address   sender ;
            address  payable receiver;
            uint256 amountleft; 
            uint256   datesent;     
          
            
            }
       

     
   
// The fixed amount of tokens stored in an unsigned integer type variable.
    uint256 public _totalSupply = 1000000;
     
    // An address type variable is used to store ethereum accounts taken from Ownable.sol
   // address public owner;

    // A mapping is a key/value map. Here we store each account balance.
    // We store values that can be easy to have when we want to index values
    mapping(address => uint256) balances;
      mapping(address => mapping(address => uint256)) private _allowances;


        

       mapping(address=>Assets)public assetstore;
      

  
  // @dev objects inheriting from previous structs
   Assets   newasset;
   Assets[] public assetstorage;
     
       event  AssetTransferAndMergerEvent( address payable _companyaddress, address payable _mergeraddress,uint256 amount);
       event AssetTransferMergerDetails(   address    owner, address   sender, address  payable receiver, uint256 amountleft, uint256   datesent) ;  
      
      constructor(address __owner) ERC20(_tokenname, _tokensymbol ) {
        _owner =__owner;
         totalSupply();
         

    }

  
  function balanceOf(address account) public view override  returns (uint256) {
        return (balances[account]);
    }
  
  function owner() public view virtual override returns (address) {
        return (_owner);
    }

  function mint (address account, uint256 amount) external     virtual  returns (address, uint256 ) {
      _mint( msg.sender,  amount);
  return(  account,  amount);
  }

  function burn (address account, uint256 amount) external   virtual returns (address, uint256 ) {
      _burn( msg.sender ,  amount);
  return(  account,  amount);
 }

  function totalSupply() public view virtual override  returns (uint256) {
    return (_totalSupply);
  }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
      // Just in case we have not transferred to sender
       // sender =_owner;
      uint256 senderbalance = balanceOf(sender); 
       require(sender == _owner, "tansferer not the token owner");
        require(senderbalance <= amount, "ERC20: transfer amount exceeds amount in balance");
      
        _transfer(sender, recipient, amount);
       _approve(_owner, recipient, amount); 
   

       return true;
    }


     function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
 

    // @dev Transfers ownership of the contract to a new account (`newOwner`).
     // Can only be called by the current owner.
     //


    function transferOwnership(address newOwner) public override virtual  onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    
      // @dev register game, game id as random generator integer
    function AssetTransferAndMergerExec( address payable _companyaddress, address payable _mergeraddress,uint256 amount) public   returns( address payable ,address payable, uint256){
               transferFrom( _companyaddress, _mergeraddress, amount);
               transferOwnership(_mergeraddress);
                
                // Since it has been transferred to merger, merger is now the owner and we still maintain sender 
          


           assetstore[_mergeraddress].owner = _mergeraddress;
           assetstore[_mergeraddress].sender = _companyaddress;
          assetstore[_mergeraddress].receiver = _mergeraddress;
           assetstore[_mergeraddress].amountleft = balanceOf(_mergeraddress); 
             assetstore[_mergeraddress].datesent = block.timestamp;     
              

              emit AssetTransferMergerDetails (_mergeraddress, _companyaddress,_mergeraddress,balanceOf(_mergeraddress),  block.timestamp ); 
              emit AssetTransferAndMergerEvent( _companyaddress,  _mergeraddress,amount);
              return ( _companyaddress, _mergeraddress,amount);
             }
         
    
}
