### Oracle 12c EE image 
Image provides "Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production" with Enterprise Manager Lite console enabled.  
For those who are suffering from SQLPLUS inability to provide history using keyboard arrows "rlwrap" utility has been incorporated as well

### Running image
```sh 
$ docker run -d --name oracle --privileged absolutapps/oracle-12c-ee
```
This will create a default database and run oracle inside docker container.
Oracle should be run in “privileged” mode as oracle requires special ports and kernel settings to be enabled
However in real environment it's better to use more comprehensive statement useful for real life:
```sh
$ docker run -d --name oracle \
  --privileged \
  -v $(pwd)/oradata:/u01/app/oracle \
  -v $(pwd)/networkadmin:/u01/app/oracle-product/12.1.0.2/dbhome_1/network/admin \
  -p 8080:8080 -p 1521:1521 absolutapps/oracle-12c-ee
```
In this case database settings and data will be saved to $(pwd)/oradata folder and ports will be exposed either to localhost or boot2docker container (MacOs and Win).
Network configuration files under $(pwd)/networkadmin will be mounted into the container so that listener and other network settings can be customized.

### Additional options
 - `ORACLE_SID` - Oracle SID (default to ORCL)
 - `SERVICE_NAME`	- $ORACLE_SID
 - Listener port - 1521	 
 - EM port - 8080	 
 - SYS, SYSTEM passwords: oracle	 
 - Amount of memory	40%	`INIT_MEM_PST`

### Running scripts at startup
Shell scripts (sh) and sql scripts (sql) placed in `/oracle.init.d/`directory will be executed after database creation (or start). 
Please note that sql scripts are executed under SYS user account, so in order to execute sql under different account construction like “connect user/password” should be used at the beginning of the script. 
Shell scripts are executed as root. Please use “gosu” instead of “su - ” to run script under different account.
(More about “gosu” advantages can be found here https://github.com/tianon/gosu/)

### Using rlwrap
This utility allows user to use history in sqlplus in the same way as with MySQL. Just use "rlwrap sqlplus" instead of "sqlplus" 

