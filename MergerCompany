


     
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import './StringUtils.sol';
import "./Merger.sol";




  // @dev contract for rock,paper game0
abstract contract MergerCompany is   Merger{
    
    
  

    uint256 _payfee;
         
  address payable companyaddress; 
       struct Company {
             address companyaddress;
             string  companyname;
             string  companyboxaddress;
             string  companyscope;
             uint256  companydateestablished;
             uint256 yearsactive;
      

                     }
         
      
         mapping(address => bool) companies;
          mapping(address => address) registeredpaidcompanies;
         mapping(address=>Company)public companystore;
          mapping(address => uint256) companyfeepaid;  
   


  
  // @dev objects inheriting from previous structs
   Company  newcompany;

  Company[] public companyregistered;

    
       constructor(address payable  _companyaddress)  {
        companyaddress = _companyaddress;
         
 }

  
   // @dev registeration for game  
  // @params players name and address

  event registerCompaniesEvent( address payable _companyaddress, string  _companyname,string _companyboxaddress,string  _companyscope, uint256  _companydateestablished, uint256 _yearsactive);
  event payfeeForMergerSubmissionEvent (address payable _companyaddress, uint256 _amount);
  event   registerForMergerEvent(address payable _mergeraddress , address payable _companyaddress, address payable _chiefexecutive, address payable _chieffinanceofficer, string _typeoffirm,string mergername, uint256 _yearsactive  );
    event submitProposalEvent (address payable _mergeraddress, address payable _companyaddress , string termsandconditions  );
    function registerCompanies( address payable _companyaddress, string memory _companyname,string memory  _companyboxaddress,string memory  _companyscope, uint256  _companydateestablished, uint256 _yearsactive) public  returns( address payable, string memory,string memory ,string memory  , uint256 , uint256){
         _companyaddress=companyaddress;
              require(_yearsactive >=5 , "You are  not within the year range");
               require(companies[_companyaddress] !=true, "You are are already registered");
         
              
           
            // @dev storing to memory
            newcompany = Company(_companyaddress,_companyname, _companyboxaddress,_companyscope , _companydateestablished, _yearsactive); 
             companystore[companyaddress].companyaddress = _companyaddress;
             companystore[companyaddress].companyname = _companyname;
             companystore[companyaddress].companyboxaddress = _companyboxaddress;
             companystore[companyaddress].companyscope = _companyscope;
             companystore[companyaddress].companydateestablished = _companydateestablished;
             companystore[companyaddress].yearsactive = _yearsactive;

      emit registerCompaniesEvent(_companyaddress, _companyname,_companyboxaddress,_companyscope,  _companydateestablished, _yearsactive);
            companyregistered.push(newcompany);                        

            return (_companyaddress,_companyname, _companyboxaddress,_companyscope , _companydateestablished, _yearsactive );
     
}

   

  // @dev fees to be paid to be registered for game 
  // @params player=sender, contractowner,ether amount to be sent 
  
function payfeeForMergerSubmission(address payable _companyaddress, uint256 _amount) public payable returns(bool, bytes memory){
        _companyaddress= companyaddress;
       
        _payfee = _amount;
     
        require ( _payfee >= 1, "Amount not enough to play!");
    
          (bool success,bytes memory data ) = _companyaddress.call{value: _payfee}("");
            require(success, "Check the amount sent as well"); 
            registeredpaidcompanies[_companyaddress]=_companyaddress;
             companyfeepaid[_companyaddress]= _payfee;
             registeredpaidcompanies[_companyaddress] =_companyaddress;

      emit   payfeeForMergerSubmissionEvent ( _companyaddress, _amount);
    return (success,data);
    }


  function registerForMerger(address payable _mergeraddress , address payable _companyaddress, address payable _chiefexecutive, address payable _chieffinanceofficer, string memory _typeoffirm,string memory _mergername, uint256 _yearsactive  ) public  returns(address payable , address payable, address payable, address payable, string memory ,string memory  , uint256){
         _companyaddress = companyaddress;
          require(msg.sender == _companyaddress , "Caller is not owner");
          // checkifalreadyregisteredformerger, if  
         
            _registerForMergerByMerger( _mergeraddress , _companyaddress,  _chiefexecutive, _chieffinanceofficer, _typeoffirm, _mergername, _yearsactive);                     

         emit   registerForMergerEvent(_mergeraddress , _companyaddress, _chiefexecutive, _chieffinanceofficer, _typeoffirm,_mergername, _yearsactive  );
            return (_mergeraddress , _companyaddress,  _chiefexecutive, _chieffinanceofficer, _typeoffirm, _mergername, _yearsactive);
     
}

               
 function submitProposalHere(address payable _mergeraddress, address payable _companyaddress , string  memory _termsandconditions  ) public  returns(address payable, address payable  , string memory  ){
           _companyaddress = companyaddress;
          require(msg.sender == _companyaddress , "Caller is not owner");
         
          // checkifregisteredformerger, if it has  do this
          // gettheaddress 
      submitProposal(_mergeraddress,  _companyaddress , _termsandconditions) ;                 
             emit submitProposalEvent (_mergeraddress,  _companyaddress , _termsandconditions  );
            return (_mergeraddress , _companyaddress,  _termsandconditions);
     
}     
               
}
