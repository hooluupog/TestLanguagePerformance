@echo off 
title win7����ͼ��ڿ��޸����� 
reg delete ��hkcu\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons�� /f 
reg delete ��hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons�� /f 
taskkill /f /im explorer.exe & start explorer.exe