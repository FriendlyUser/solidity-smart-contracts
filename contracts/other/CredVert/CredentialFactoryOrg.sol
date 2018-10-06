pragma solidity ^0.4.21;

/** @title CredentialOrgFactory  */
import "./Pausable.sol";
import "./SafeMath32.sol";

contract CredentialOrgFactory is Pausable {
    // SafeMath32 library usage.
    using SafeMath32 for uint32;

    // mappings
    mapping(address => CredentialOrg) addressToCredentialOrg;
    
    // events 
    event CredentialOrgEvent(address indexed schoolAddress, string detail);

    // # of credentialling orgs created.
    uint32 private credentialOrgCount;

    // Primary CredentialOrg structure, and following array.
    struct CredentialOrg {
        string shortName;          // School shortName (len 30)
        string officialSchoolName; // official school shortName (70 or less)
        address schoolAddress;
    }
    // CredentialOrg Array    
    CredentialOrg[] private credentialOrgs; 

    /**
    * @dev class constructor
    */
    constructor() public {
        credentialOrgCount = 0;
    }
    
    // functions
    /**
    * @dev gets owners address
    * @return returns contractOwners Address
    */
    function getOwner()
    public view
    returns (address returnedOwner)
    {
        returnedOwner = owner;
        return(returnedOwner);
    }
    /**
    * @dev allows owner to create new credentialing orgs
    * @param _shortName shortName of Credentialing orgs
    * @param _officialSchoolName official School Name
    * @param _schoolAddress address of credential org.
    * @return createStatus bool noting creation status success or failure
    */
    function createCredentialOrg(string _shortName, string _officialSchoolName, address _schoolAddress) 
    public onlyOwner whenNotPaused
    returns (bool createStatus)
    {
        //emit CredentialOrgEvent(_schoolAddress, "createCredentialOrg (PRE)");
        require(bytes(_shortName).length > 0 && bytes(_shortName).length < 31, "createCredentialOrg shortName problem");
        require(bytes(_officialSchoolName).length > 0 && bytes(_officialSchoolName).length < 70, "createCredentialOrg officalSchoolName problem");
        require(_schoolAddress != 0, "createCredentialOrg (FAIL) school Address can not be 0");        
        createStatus = false;

        CredentialOrg memory orgExists = addressToCredentialOrg[_schoolAddress];
        if (orgExists.schoolAddress == 0){
            uint32 position = uint32(credentialOrgs.push(CredentialOrg(_shortName, _officialSchoolName, _schoolAddress)));
            if (position > 0){
                addressToCredentialOrg[_schoolAddress] = credentialOrgs[position.sub(1)];
                credentialOrgCount = credentialOrgCount.add(1);
                createStatus = true;
                emit CredentialOrgEvent(_schoolAddress, "createCredentialOrg (SUCCESS)");
            } else {
                emit CredentialOrgEvent(_schoolAddress, "createCredentialOrg (FAIL)");
            }
        } else {
            emit CredentialOrgEvent(_schoolAddress, "createCredentialOrg (FAIL) org Already exists");
        }
        return (createStatus);
    }

    /**
    * @dev allows selection of a credentialingOrg by position
    * @param _credentialOrgPosition allows selection of credentialing orgs details.
    * @return shortName - shortName of Credential Org
    * @return officialSchooName - official school name
    * @return school -the schools ethereum address 
    */
    function selectCredentialOrgByPosition(uint32 _credentialOrgPosition) 
    public view 
    returns (string shortName, string officialSchoolName, address schoolAddress)
    {
        shortName = "";
        officialSchoolName = "";
        schoolAddress = 0;
        require(_credentialOrgPosition >= 0, "selectCredentialOrgByPosition - position had to be greater or equal to 0.");
        if (_credentialOrgPosition < credentialOrgCount){
            emit CredentialOrgEvent(msg.sender, "selectCredentialOrgByPosition - (SUCCESS)");
            return (credentialOrgs[_credentialOrgPosition].shortName, credentialOrgs[_credentialOrgPosition].officialSchoolName, credentialOrgs[_credentialOrgPosition].schoolAddress);
        } else {
            emit CredentialOrgEvent(msg.sender, "selectCredentialOrgByPosition - (FAIL) top boundry exceeded.");
            return (shortName, officialSchoolName, schoolAddress);
        }
    }

    /**
    * @dev allows selection of a credentialingOrg by address
    * @param _credentialOrgAddress allows selection of credentialing orgs details.
    * @return shortName - shortName of Credential Org
    * @return officialSchooName - official school name
    * @return school -the schools ethereum address 
    */
    function selectCredentialOrgByAddress(address _credentialOrgAddress) 
    public view 
    returns (string shortName, string officialSchoolName, address schoolAddress)
    {
        //emit CredentialOrgEvent(_credentialOrgAddress, "selectCredentialOrg (PRE)");
        require(_credentialOrgAddress != 0, "selectCredentialOrgByAddress - Address 0 not valid");
        CredentialOrg memory testCred = addressToCredentialOrg[_credentialOrgAddress];
        if (testCred.schoolAddress != 0){
            emit CredentialOrgEvent(_credentialOrgAddress, "selectCredentialOrgByAddress (SUCCESS)");
            return (testCred.shortName, testCred.officialSchoolName, testCred.schoolAddress);
        } else {
            emit CredentialOrgEvent(_credentialOrgAddress, "selectCredentialOrgByAddress - (FAIL)");
            return ("", "", 0);
        }
    }

    /**
    * @dev allows checking if credentialOrg exists
    * @param _credentialOrgAddress function returns bool if an address is a credentialingOrg
    * @return isAddress returns true if address is Credentialing Org, false if not.
    */
    function isCredentialOrg(address _credentialOrgAddress) 
    public view
    returns (bool isOrgAddress)
    {
        isOrgAddress = false;
        CredentialOrg memory testCredentialOrg = addressToCredentialOrg[_credentialOrgAddress];
        if (testCredentialOrg.schoolAddress != 0){
            isOrgAddress = true;
            emit CredentialOrgEvent(_credentialOrgAddress, "isCredentialOrg - (SUCCESS)");
        } else {
            emit CredentialOrgEvent(_credentialOrgAddress, "isCredentialOrg - (FAIL)");
        }
        return (isOrgAddress);
    }

    /**
    * @dev returns the credentialOrgCount
    * @return returnOrgCount - returns the total credential orgs count
    */
    function selectOrgCount()
    public view
    returns (uint32 returnOrgCount)
    {
        returnOrgCount = credentialOrgCount;
        return (returnOrgCount);
    }
}