@echo off 
title win7桌面图标黑块修复工具 
reg delete “hkcu\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons” /f 
reg delete “hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons” /f 
taskkill /f /im explorer.exe & start explorer.exe