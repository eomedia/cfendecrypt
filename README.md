###cfendecrypt
============

A simple way to encrypt/decrypt data with a secret key.  On "write" it encrypts the password, writes the secret key to a filename you specificy and returns the encrypted password.  On "read" it retrieves the secret key from the file, decrypts the password and returns the decrypted password.

By creating unique secret keys for each password you make it more difficult for hackers to find the key and decrypt passwords, however, it is a good idea to store the secret key text files in a location separate from the dB which is storing the passwords.

```
##Dual licensed under the MIT and GPL licenses:
* http://www.opensource.org/licenses/mit-license.php
* http://www.gnu.org/license
```

```
#Quick use case example
<cfset local.password="test123">

<cfoutput>
	Set Password =  #local.password#
	<br><br>
	<cfset encryptedPassword = cfendecrypt(local.password, "write", expandPath("."), "secretKey.txt") />
	encryptedPassword = #encryptedPassword#
	<br>
	decryptedPassword = #cfendecrypt(encryptedPassword, "read", expandPath("."), "secretKey.txt")#

</cfoutput>
```