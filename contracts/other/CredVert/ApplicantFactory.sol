pragma solidity ^0.4.21;
/**
 * @title ApplicantFactory
 * @dev The ApplicantFactory allows applicants to apply to a credentialOrg for an electronic credential.
 */
import "./Pausable.sol";
import "./SafeMath32.sol";

// allows communication with CredentialOrg Factory.
// not used, will be when testing moves to Javascript.
interface CredentialOrgFactory{
    function isCredentialOrg(address _credentialOrgAddress) external view returns (bool IsOrgAddress);
}

contract ApplicantFactory is Pausable {

    // SafeMath32 Library Usage
    using SafeMath32 for uint32;

    // contract events.
    event ApplicantEvent(address ApplicantCallerAddress, string detail);
    
    // mappings
    mapping (address => Applicant[]) orgAddressToApplicants;
    mapping (address => uint32) orgAddressToApplicantCount;
    mapping (address => uint32) applicantAddressToApplicantPosition;
    
    // structs
    struct Applicant {
        address studentAddress;     // address of student requesting credential
        string SSN;                 // Applicant SSN
        string collegeStudentID;    // Applicant CollegeID
        string firstName;           // first name lenmax 40
        string lastName;            // last name  lenmax 40
        uint32 insertDate;          // unix timestamp.
        uint32 processDate;         // unix timestamp.
        string processDetail;       // AWARDED/DENIED
    }

    /**
    * @dev constructor.
     */
    constructor() public {
    }
    
    // address of CredentialOrgFactory, and class refreence
    address private credentialOrgContractAddress;
    CredentialOrgFactory cof;

    // functions
    /**
    * @dev Gets Owner Address of Contract
    * @return returnedOwner returns owner of contract address.
    */
    function getOwner()
    public view
    returns (address returnedOwner)
    {
        returnedOwner = owner;
        return returnedOwner;
    }

    /**
    * @dev Allows owner to set address of CredentialOrgFactory contract.
    * @param _credentialOrgContractAddress address of CredentialOrgFactory (set on deploy).
    */
    function setAddress(address _credentialOrgContractAddress) public onlyOwner {
        credentialOrgContractAddress = _credentialOrgContractAddress;
    }

    /**
    * @dev Allows creation of Applicants to Credentialing Orgs
    * @param _collegeAddress address of CredentialingOrg
    * @param _SSN SSN of Student
    * @param _collegeStudentID College Student ID
    * @param _firstName First Name of Student
    * @param _lastName Last Name of Student
    * @return insertSuccess true/false of 
    */
    function createApplicant(address _collegeAddress, string _SSN, string _collegeStudentID, string _firstName, string _lastName) 
    public whenNotPaused
    returns (bool insertSuccess)
    {
        emit ApplicantEvent(msg.sender, "createApplicant (ATTEMPT)");
        require(msg.sender != 0 && _collegeAddress != 0, "createApplicant (FAIL) Addresses can not be 0.");
        require(bytes(_SSN).length == 9,"createApplicant (FAIL) SSN Length incorrect");
        require(bytes(_collegeStudentID).length == 9, "createApplicant (FAIL)College StudentID length Problem");
        require(bytes(_firstName).length > 0 && bytes(_firstName).length <= 40, "createApplicant (FAIL) FirstName length problem"); 
        require(bytes(_lastName).length > 0 && bytes(_lastName).length <= 40, "createApplicant (FAIL) LastName length problem"); 
        cof = CredentialOrgFactory(credentialOrgContractAddress);
        if (cof.isCredentialOrg(_collegeAddress)){
            insertSuccess = false;
            uint32 position = uint32(orgAddressToApplicants[_collegeAddress].push(Applicant(msg.sender, _SSN, _collegeStudentID, _firstName, _lastName, uint32(now), 0, "")));
            if(position >= 0){
                insertSuccess = true;
                applicantAddressToApplicantPosition[msg.sender] = position.sub(1);
                orgAddressToApplicantCount[_collegeAddress] = orgAddressToApplicantCount[_collegeAddress].add(1);
                emit ApplicantEvent(msg.sender, "createApplicant (SUCCESS)");
            } else {
                emit ApplicantEvent(msg.sender, "createApplicant (FAIL)");
            }
        } else {
            emit ApplicantEvent(_collegeAddress, "createApplicant (FAIL) Colleg Applied to address NOT CredetialOrg");
        }
        return (insertSuccess);
    }

    /**
    * @dev Allows Selection of Applicant by org and position.
    * @param _orgAddress address of CredentialingOrg
    * @param _position position in array of Applicant
    * @return Applicants student's ether address
    * @return SSN Applicants SSN
    * @return collegeStudentID  Applicant college ID
    * @return firstName Applicant firstName
    * @return lastName Applicant lastName
    */
    function selectApplicantByOrgAndPosition(address _orgAddress, uint32 _position)
    public view 
    returns (address studentAddress, string SSN, string collegeStudentID, string firstName,  string lastName)
    {
        require(_orgAddress != 0, "Applicant orgAddress can not be 0");
        if (_position < orgAddressToApplicantCount[_orgAddress]){
            studentAddress = orgAddressToApplicants[_orgAddress][_position].studentAddress;
            SSN = orgAddressToApplicants[_orgAddress][_position].SSN;
            collegeStudentID = orgAddressToApplicants[_orgAddress][_position].collegeStudentID;
            firstName = orgAddressToApplicants[_orgAddress][_position].firstName;
            lastName = orgAddressToApplicants[_orgAddress][_position].lastName;
            emit ApplicantEvent(msg.sender, "selectApplicantByOrgAndPosition (SUCCESS)");
        } else {
            studentAddress = 0;
            SSN = "";
            collegeStudentID = "";
            firstName = "";
            lastName = "";
            emit ApplicantEvent(msg.sender, "selectApplicant (FAIL) Applicant lookup fail");
        }
        return(studentAddress, SSN, collegeStudentID, firstName, lastName);
    }

    /**
    * @dev Allows update of Applicant by org and position.
    * @param _position position in array of Applicant
    * @param _processDetail Applicant AWARDED/DENIED
    * @return updateSuccess true/false
    */
    function updateApplicantByOrgAndPosition(uint32 _position, string _processDetail)
    public whenNotPaused
    returns (bool updateSuccess)
    {
        updateSuccess = false;
        emit ApplicantEvent(msg.sender, "updateApplicantByOrgAndPosition (ATTEMPT)");
        require(_position >= 0, "updateApplicantByOrgAndPosition: Applicant position requires >= 0");
        require(bytes(_processDetail).length >= 0 && bytes(_processDetail).length <= 10, "updateApplicantByOrgAndPosition: Applicant Process Detail Missing");
        cof = CredentialOrgFactory(credentialOrgContractAddress);
        if (cof.isCredentialOrg(msg.sender)){
            if (_position < orgAddressToApplicantCount[msg.sender]){
                orgAddressToApplicants[msg.sender][_position].processDate = uint32(block.timestamp);
                orgAddressToApplicants[msg.sender][_position].processDetail = _processDetail;
                updateSuccess = true;
                emit ApplicantEvent(msg.sender, "updateApplicantByOrgAndPosition (SUCCESS)");
            } else {
                emit ApplicantEvent(msg.sender, "updateApplicantByOrgAndPosition (FAIL) invalid position");
            }
        } else {
            emit ApplicantEvent(msg.sender, "updateApplicantByOrgAndPosition (FAIL) msgsender is NOT a credentialling org");
        }
        return(updateSuccess);
    }

    /**
    * @dev Allows Selection of Applicant Count by orgAddress
    * @param _orgAddress address of CredentialingOrg
    * @return appCount the Applicant Count for a specific organization.
    */
    function selectOrgApplicantCount(address _orgAddress)
    public view 
    returns (uint32 appCount)
    {
        appCount = orgAddressToApplicantCount[_orgAddress];
        return (appCount);
    }
}