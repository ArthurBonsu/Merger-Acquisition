
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import './StringUtils.sol';
import "./DateTime.sol"; 
import "./AssetAcquisition.sol"; 



  // @dev contract for rock,paper game0
 abstract contract Merger is  AssetAcquisition, DateTime{

  address themergeraddress; 
    
    uint256 mergerstringid =0;



    uint256 submitproposalid=0;
    uint256 randNonceProp=0; 
    uint256 proposemodulus =3; 

   
      struct MergerStruct  {
              uint256 mergerstring;
              address payable mergeraddress;
              address payable companyaddress;
              string mergername; 
              // whether merger company is active or not 
              bool mergerstate;
              uint256 numberofmergercomplete;
              bool  mergerreceived;
              }
       

          struct Proposals{
            uint256 proposalid;
            address payable proposalreceiver;
            address  proposalsender;
            string termsandconditions;    
            uint256 date; 
        
            uint256  duration;
            }

       struct License{
            string licenceid ;
            address payable mergerissuer;
            address  personissuedto;    
            uint256 date; 
            uint256 time ;
            uint256  duration;
            }

    
      struct TransactionReceipt{
            string  transactionreceiptid;
            string  licenseid;
            address payable mergerissuer;
            address  payable personissuedto;   
            uint256 issuedate;
            
            }
       
   
     mapping(address => mapping(address => address)) mergerbetweenmergersandcompanies;
      mapping(address => mapping(address => bool)) mergerandcompanycheck;
      mapping(uint256 => mapping(address => uint)) proposalslist; 
    
     mapping(uint256  => bool) proposalsstringcheck; 
     mapping(uint256 => uint256 ) proposalidstoreup;
   
    // merger is different from proposals 
    mapping(uint256=>MergerStruct )public mergerstore;
    mapping(uint256=>Proposals )public proposalstore;
     
   
 


   // mapping(address => mapping(bytes32 => bool)) playeringamecheck;
   // mapping(uint => mapping(address => uint)) prev_winning;
   // mapping(uint => mapping(address => uint)) gamewithplayer;     
   // mapping(uint => uint) gamesplayed;
   // mapping(address => address) playersplayed;
  //  mapping(address => bool)paidforgames;
      

  
  // @dev objects inheriting from previous structs
   MergerStruct  newMerger; 
   MergerStruct[] public mergersregistered;

    Proposals  newProposals; 
   Proposals[] public proposalsregistered;
  
  constructor(address _themergeraddress )  {
  themergeraddress =_themergeraddress;
        
             }




       function  _registerForMergerByMerger(address payable _mergeraddress , address payable _companyaddress, address payable _chiefexecutive, address payable _chieffinanceofficer, string memory  _typeoffirm,string memory mergername , uint256 _yearsactive) public  returns(address payable, address payable, address payable, address payable, string memory ,string memory , uint256){
                   
              require(msg.sender == _mergeraddress , "Merger Company is the  company ");
              require(mergerandcompanycheck[_mergeraddress][_companyaddress] != true, "Merger has already been registered");
              
                // generate a merger id 
            
        randNonce++; 
         modulus= 3;
       
        mergerstringid = uint(keccak256(abi.encodePacked(block.timestamp,
                                          msg.sender,
                                          randNonce))) % 
                                          modulus; 
            // @dev storing to memory

      

            newMerger = MergerStruct( mergerstringid ,_mergeraddress, _companyaddress,  mergername,  true,0, false ); 

             mergerstore[mergerstringid].mergerstring = mergerstringid;
             mergerstore[mergerstringid].mergeraddress = _mergeraddress;
              mergerstore[mergerstringid].companyaddress = _companyaddress;
             mergerstore[mergerstringid].mergername = mergername;
             mergerstore[mergerstringid].mergerstate = true;
               
             mergerstore[mergerstringid].numberofmergercomplete = 0;
             mergerstore[mergerstringid].mergerreceived = false;
        
               
              
   
                 // @dev storing to storage  -optional
                 proposalidstoreup[mergerstringid]=mergerstringid;
                 mergerandcompanycheck[_mergeraddress][_companyaddress] = true;
  
            mergersregistered.push(newMerger);                        

            return ( _mergeraddress , _companyaddress, _chiefexecutive, _chieffinanceofficer,_typeoffirm,mergername ,_yearsactive );
     
}

   
 

 // @dev register game, game id as random generator integer
   event submitProposalEvent   (address payable _mergeraddress, address payable _companyaddress , string termsandconditions , uint256 _daysgiven  );

          function submitProposal(address payable _mergeraddress, address payable _companyaddress , string memory termsandconditions) public   returns(address payable, address payable , string memory, uint256, uint256  ){
            
                //checker  mergerexist <string, address> 
                //checker checkproposalexists <string, address> 


          
          require(msg.sender == _mergeraddress , "Merger Company is not the original merger to handle this ");
           
              require(mergerandcompanycheck[_mergeraddress][_companyaddress] != true, "Merger has already been registered");
              
                // generate a merger id 
           
         randNonceProp++; 
         proposemodulus= 3;
       
        submitproposalid = uint(keccak256(abi.encodePacked(block.timestamp,
                                          msg.sender,
                                          randNonceProp))) % 
                                          proposemodulus; 
            // @dev storing to memory

                  require(proposalsstringcheck[submitproposalid]!= true, "Proposalhasalreadybeen sent has already been registered");
                  //@dev check if proposal string exists, check if company has already submitted such a proposal before 
                        proposalsstringcheck[submitproposalid] = true;
                         proposalslist[submitproposalid][_companyaddress]= submitproposalid; 

    
     // string proposalid;
     //       address payable proposalreceiver;
     //       address  proposalsender;
     //       string termsandconditions;    
      //      uint256 date; 
      //      uint256 time ;
      //      uint256  duration;
    
    
   //  mapping(uint => mapping(address => uint)) proposalslist; 
   //  mapping(string  => bool) proposalsstringcheck; 
   //  mapping(string => string ) proposalidstoreup;
  //  Proposals  newProposals; 
  // Proposals[] public proposalsregistered;

            uint256 registereddate =     block.timestamp;
         uint256 lastdate =   toTimestamp(2023,9,1); 
        uint256 daysgiven = lastdate - registereddate; 
  
            newProposals = Proposals( submitproposalid, _mergeraddress,  _companyaddress, termsandconditions, registereddate,   daysgiven); 

             proposalstore[submitproposalid].proposalid = submitproposalid;
             proposalstore[submitproposalid].proposalreceiver = _mergeraddress;
              proposalstore[submitproposalid].proposalsender = _companyaddress;
             proposalstore[submitproposalid].termsandconditions = termsandconditions;

           
             proposalstore[submitproposalid].date = block.timestamp;
             proposalstore[submitproposalid].duration = daysgiven;
        
               
       
     
            proposalsregistered.push(newProposals); 

                   
   emit submitProposalEvent   (_mergeraddress,  _companyaddress ,  termsandconditions , daysgiven   );


   //address payable, address payable , string memory, string memory, uint256
            return (_mergeraddress,  _companyaddress , termsandconditions, submitproposalid,  daysgiven);
     
             }

               
    
        // @dev register game, game id as random generator integer
    function AssetTransferAndMerger( address payable _companyaddress, address payable _mergeraddress,uint256 _amount) external  returns( address payable ,address payable, uint256){
           AssetTransferAndMergerExec( _companyaddress, _mergeraddress,_amount);
     
              return (_companyaddress,  _mergeraddress,_amount);
             }
         
    }
