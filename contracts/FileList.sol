pragma solidity ^0.4.24;
/// @author David Li
/// @notice Stores a filelist on solidity, since an array of structs cannot easily be returned
/// the structs must be decomposed on the front-end
/// @dev simple filelist contains ipfshash, filename, owner, tags and unix timestamp
/// @dev one way to create a "trello" like application would require creating more modifiers and perhaps
/// role based access control.
/// @dev since I can't use an bytes32 array in solidity, I decided to have tag numbers
/// corresponding to string names, almost like a dictionary look up.
contract FileList {

   /// @dev struct that contains unique link to image (via IPFS), serial Id, and timestamp
   struct File {
      uint256 id;
      string ipfshash;
      bytes32 filename;
      bytes32[5] tags;
      address owner;
      uint256 timestamp;
   }
   uint256 public constant maxAmountOfFiles = 1000;
   // Owner => files
   mapping(address => File[maxAmountOfFiles]) public files;
   // Owner => last files id
   mapping(address => uint256) public lastIds;
   
   /// @dev main event for smart contract, needed for drizzle to update list of files
   event fileAdded (uint256 fileid, string ipfshash, bytes32 _filename);

   /// @dev Add a file to the list
   /// @param ipfshash an ipfshash returned after an image is finished uploaded
   /// @param _filename name of file as a bytes32 as filenames should be short
   /// @param tags array of bytes32 used for sorting/searching files (e,g. blockchain, school, textbook)
   /// @notice updates mappings todos and lastIds
   function addFile(string ipfshash, bytes32 _filename, bytes32[5] tags) public {
 
      File memory myFile = File(lastIds[msg.sender], ipfshash, _filename, tags,  msg.sender, now);
      // store new file in mapping

      files[msg.sender][lastIds[msg.sender]] = myFile;
      // emit event, also need for drizzle
      emit fileAdded(lastIds[msg.sender],ipfshash,_filename);
      if(lastIds[msg.sender] >= maxAmountOfFiles) lastIds[msg.sender] = 0;
      else lastIds[msg.sender]++;
   }
   
   /// @dev return the tags for a specific file 
   /// @param owner --- address of person who uploaded the file 
   /// @param _index --- the file desired, (first file uploaded, second , etc ...)
   function getFileTags(address owner, uint256 _index) external view returns (bytes32[5]) {
       return files[owner][_index].tags;
  }
}