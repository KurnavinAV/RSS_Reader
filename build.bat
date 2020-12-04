@echo off

set Project=RSSReader
set ProjectTests=%Project%Tests

set msb=c:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe
rem set path=C:\Program Files\Embarcadero\RAD Studio\7.0\bin;%path%
call rsvars.bat

echo Building tests...
del %~dp0\Test\%ProjectTests%.exe 2> NUL
%msb% %~dp0\Test\%ProjectTests%.dproj /p:DCC_Define="CONSOLE_TESTRUNNER" > %~dp0last-build-log.txt
if not exist %~dp0\Test\%ProjectTests%.exe goto buildfailed

cls
%~dp0\Test\%ProjectTests%.exe
if %errorlevel% neq 0 goto testsfailed
goto testspassed

:buildfailed
color 0c
echo Build failed. Check error log in last-build-log.txt
%~dp0last-build-log.txt
goto done

:testsfailed
color 0c
echo Tests failed
goto done

:testspassed
color 0a
echo Building main project...
del %~dp0%Project%.exe 2> NUL
%msb% %~dp0%Project%.dproj > %~dp0last-build-log.txt
if not exist %~dp0%Project%.exe goto buildfailed
echo DONE
goto done

:done
pause
color 0f