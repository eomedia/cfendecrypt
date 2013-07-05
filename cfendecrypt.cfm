<cfscript>
/**
 * A simple way to encrypt/decrypt data with a secret key
 * 
 * @param password 	Password to use for encryption key (Required)
 * @param action 	write or read option
 * @param dirPath 	directory path to use for reading/writing
 * @param fileName 	name of the file to read/write
 * @return Returns a string that is the encrypted/decrypted password. 
 * @author Ryan Smith (rsmith@eomedia.com) 
 * @version 1, January 2013 
 */

public string function cfendecrypt(required string password, required string action, required string dirPath, required string fileName) {
	
	
 	if (arguments.action EQ "write") {
 		
 		// generateSecretKey([algorithm])
 		var secretKey = generateSecretKey("AES", "128");

 		// encrypt("string", "key", [algorithm], [encoding])
 		var encryptedPassword = encrypt(arguments.password, secretKey, "AES", "base64");

 		// create xml file data
 		var xmlFile = xmlNew();
 		var xmlFile.xmlRoot = xmlElemNew(xmlFile, "secretKey");
 		var xmlFile.secretKey.XmlText = secretKey;

 		// write xml file with secret key to the directory path
 		var writeFile = arguments.dirPath & "\" & arguments.fileName;
 		FileWrite(writeFile, xmlFile);

 		var returnValue = encryptedPassword;

 	} else if (arguments.action EQ "read") {

 		// read the file from the directory path
 		var readObj = arguments.dirPath & "\" & arguments.fileName;
 		var readFile = fileRead(readObj);

 		// parse the file xml and retrieve the secret key
 		var xml = xmlParse(readFile);
 		var keyFromXml = xml.secretKey.xmlText;
 
 		// decrypt("encrypted_string", "seed")
 		var decryptedPassword = decrypt(arguments.password, keyFromXml, "AES", "base64");
 		
 		var returnValue = decryptedPassword;

 	} else {
 		var returnValue = "action required";
 	}

 return returnValue;
}

</cfscript>




