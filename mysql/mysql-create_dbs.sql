-- Only suitable for local installs that can use jdbc connections like
--  jdbc:mysql://localhost:3306/ibm_ucd
CREATE DATABASE ibm_ucb;
CREATE DATABASE ibm_ucd;
CREATE DATABASE ibm_ucr;
CREATE DATABASE ibm_ucp;

-- Allowin this user to connect from anywhere, not just locathost
CREATE USER 'ibm_uc'@'%' IDENTIFIED BY 'Rat1onal';
GRANT ALL ON ibm_ucb.* TO 'ibm_uc'@'%' WITH GRANT OPTION;
GRANT ALL ON ibm_ucd.* TO 'ibm_uc'@'%' WITH GRANT OPTION;
GRANT ALL ON ibm_ucr.* TO 'ibm_uc'@'%' WITH GRANT OPTION;
GRANT ALL ON ibm_ucp.* TO 'ibm_uc'@'%' WITH GRANT OPTION;



-- Simple grant with password seems to work more reliably...
GRANT ALL ON ibm_ucr.* to 'ibm_uc'@'%' IDENTIFIED BY 'Rat1onal';




DROP DATABASE ibm_ucr612;
CREATE DATABASE ibm_ucr612;
GRANT ALL ON ibm_ucr612.* to 'ibm_uc'@'%' WITH GRANT OPTION;
