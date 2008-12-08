@ECHO OFF
set TOMCAT_SERVICE_NAME=tomcat6
set TOMCAT_WEBAPP_PATH=C:\Program Files\Apache Software Foundation\Tomcat 6.0\webapps
del build_info.txt
ECHO --Stopping Tomcat Service...
net stop %TOMCAT_SERVICE_NAME% >> build_info.txt
ECHO --Cleaning up old files...
call ant -q clean >> build_info.txt
ECHO --Building GatorMail...(warnings can be found in build_info.txt)
call ant -q >> build_info.txt
ECHO --Deleting old WAR...
del "%TOMCAT_WEBAPP_PATH%\GatorMail.war"
ECHO --Deleting old directory...
rmdir /S /Q "%TOMCAT_WEBAPP_PATH%\GatorMail"
ECHO --Copying new WAR...
copy "build\war\GatorMail.war" "%TOMCAT_WEBAPP_PATH%\GatorMail.war" >> build_info.txt
ECHO --Starting Tomcat Service...
net start %TOMCAT_SERVICE_NAME% >> build_info.txt
ECHO --Finished! You can now check your new build! Keep on ROFLing!
pause