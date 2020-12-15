echo select disk 0 > diskpart%ID%.txt
echo clean >> diskpart%ID%.txt

echo  ** Creating system reserved partition...
echo create partition primary size=500 >> diskpart%ID%.txt
echo select partition 1 >> diskpart%ID%.txt
echo active >> diskpart%ID%.txt
echo format quick fs=ntfs >> diskpart%ID%.txt
echo assign letter="r" >> diskpart%ID%.txt

echo  ** Creating OS partition...
echo create partition primary >> diskpart%ID%.txt
echo select partition 2 >> diskpart%ID%.txt
echo active >> diskpart%ID%.txt
echo format quick fs=ntfs >> diskpart%ID%.txt
echo assign letter="c" >> diskpart%ID%.txt

echo select partition 1 >> diskpart%ID%.txt
echo active >> diskpart%ID%.txt

echo ** Executing diskpart script...
diskpart /s diskpart%ID%.txt
del diskpart%ID%.txt

echo  ** Mounting network share...
net use j: \\server\share /user:username "password"

echo  ** Applying Windows reserved partition...
Dism /apply-image /imagefile:j:\w10reserved.wim /index:1 /ApplyDir:r:\

echo  ** Applying Windows main partition...
Dism /apply-image /imagefile:j:\w10.wim /index:1 /ApplyDir:c:\

copy /Y j:\SetupComplete.cmd c:\windows\setup\scripts\SetupComplete.cmd
