pragma solidity ^0.4.21;
import "./Pausable.sol";
import "./SafeMath32.sol";
/**
 * @title CredentialFactory
 * @dev The CredentialFactory allows the credentialOrgs to add/lookup credentials
 */

// allows interaction with CredentialOrgFactory.
// not used, but will be when testing moves to Javascript.
interface CredentialOrgFactory{
    function isCredentialOrg(address _credentialOrgAddress) external view returns (bool IsOrgAddress);
}

contract CredentialFactory is Pausable{
    
    // SafeMath32 library.
    using SafeMath32 for uint32;
    
    // event
    event CredentialEvent(address credentialOrg, string credentialTitle, string detail);

    // mapping
    mapping (address => Credential[]) orgAddressToCredentials;
    mapping (address => uint32) orgAddressToCredentialTotalCount;

    // structs
    struct Credential {
        address credentialOrg;      // CredentialOwnerAddress
        string credentialLevel;     // 50 or less string
        string credentialTitle;     // 70 or less string
        string credentialDivision;  // 50 or less string
        uint32 credentialInsertDate;// Credential Insert timestamp
    }
    
    // address to allow communication with CredentialOrgFactory.
    address private credentialOrgContractAddress;
    CredentialOrgFactory cof;
    
    /**
    * @dev constructor
    */
    constructor () public {
    }

    // functions
    /**
    * @dev get the owner of the contract
    * @return returns owner address
    */
    function getOwner()
    public view
    returns (address returnedOwner)
    {
        returnedOwner = owner;
    }

    /**
    * @dev setting allows communication between CredentialFactory and CredentialOrgFactory
    * @param _credentialOrgContractAddress Address of CredentialOrgFactory Contract.
    */
    function setAddress(address _credentialOrgContractAddress) public onlyOwner {
        credentialOrgContractAddress = _credentialOrgContractAddress;
    }

    /**
    * @dev allows credentialing Orgs to create new credentials
    * @param _credentialLevel Credential Level
    * @param _credentialTitle CredentialTitle
    * @param _credentialDivision Credential Division
    * @return insertStatus - true false if insert happened.
    */
    function createCredential(string _credentialLevel, string _credentialTitle, string _credentialDivision, address _credentialOrgAddress) 
    public whenNotPaused
    returns (bool insertStatus)
    {
        insertStatus = false;
        require(bytes(_credentialLevel).length > 0 && bytes(_credentialLevel).length < 50, "createCredential - Level length problem");
        require(bytes(_credentialTitle).length > 0 && bytes(_credentialTitle).length < 70, "createCredential - Title length problem");
        require(bytes(_credentialDivision).length >= 0 && bytes(_credentialDivision).length < 50, "createCredential - Division length problem");
        if (msg.sender == owner || msg.sender == _credentialOrgAddress){
            uint32 position = uint32(orgAddressToCredentials[_credentialOrgAddress].push(Credential(_credentialOrgAddress, _credentialLevel, _credentialTitle, _credentialDivision, uint32(block.timestamp))));
            if(position > 0){
                insertStatus = true;
                orgAddressToCredentialTotalCount[_credentialOrgAddress] = orgAddressToCredentialTotalCount[_credentialOrgAddress].add(1);
                emit CredentialEvent(_credentialOrgAddress, _credentialTitle, "createCredential (SUCCCESS)");
            } else {
                emit CredentialEvent(_credentialOrgAddress, _credentialTitle, "createCredential (FAILED)");
            }
        } else {
            emit CredentialEvent(_credentialOrgAddress, _credentialTitle, "createCredential (FAILED) must be owner or only modify your own records");
        }
        return insertStatus;
    }

    /**
    * @dev allows selection of credential based on position.
    * @param _credentialOrgAddress credentialOrg Address
    * @param _position allows selection of credentialing orgs details.
    * @return credentialLevel - credential level
    * @return credentialOrgAddress - credential Org Address of credential owner.
    * @return credentialDivision - credential org division for credential.
    */
    function selectCredential(address _credentialOrgAddress, uint32 _position) 
    public view
    returns (string credentialLevel, string credentialTitle, string credentialDivision)
    {
        require(_position >= 0, "selectCredential (FAIL) position incorrect");
        if (_position < orgAddressToCredentialTotalCount[_credentialOrgAddress]){
            return (orgAddressToCredentials[_credentialOrgAddress][_position].credentialLevel,orgAddressToCredentials[_credentialOrgAddress][_position].credentialTitle, orgAddressToCredentials[_credentialOrgAddress][_position].credentialDivision);    
        } else {
            emit CredentialEvent(_credentialOrgAddress, "", "selectCredential: Credential Bounds Error");
            return ("","","");
        }
    }

    /**
    * @dev allows checking of CredentialCount of a CredentialOrg
    * @param _credentialOrgAddress Address of Credential Org
    * @return returnCredentialCount - returns count of credentials of org.
    */
    function selectOrgCredentialCount(address _credentialOrgAddress)
    public view 
    returns (uint32 returnCredentialCount)
    {
        returnCredentialCount = orgAddressToCredentialTotalCount[_credentialOrgAddress];
        return (returnCredentialCount);
    }

}