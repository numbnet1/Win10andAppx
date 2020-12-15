@echo off
if %1$==$ (
    rem use the localcomputername if nothing is specified
    set computer=%computername%
) else (
    rem use the computername passed as a parameter
    set computer=%1
)
 
echo Creating report for %computer%
set htmlfile=%computer%-report.html

rem set the header
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo ^<meta name="viewport" content="width=device-width, initial-scale=1"^>
echo ^<style^>
echo #myDIV {
echo     width: 100%;
echo     padding: 50px 0;
echo     text-align: center;
echo     background-color: lightblue;
echo     margin-top: 20px;
echo }
echo ^</style^>
echo ^</head^>
echo ^<body^>
echo ^<button onclick="computersystem()"^>computersystem^</button^>
echo ^<button onclick="OS()"^>os^</button^>
echo ^<button onclick="PRODUCT()"^>product^</button^>
echo ^<button onclick="environment()"^>environment^</button^>
echo ^<button onclick="useraccount()"^>useraccount^</button^>

echo ^<button onclick="server()"^>server^</button^>
echo ^<button onclick="service()"^>service^</button^>

echo ^<button onclick="bios()"^>bios^</button^>
echo ^<button onclick="cpu()"^>cpu^</button^>
echo ^<button onclick="memorychip()"^>memorychip^</button^>

echo ^<button onclick="idecontroller()"^>idecontroller^</button^>
echo ^<button onclick="logicaldisk()"^>logicaldisk^</button^>
echo ^<button onclick="diskdrive()"^>diskdrive^</button^>

echo ^<button onclick="baseboard()"^>baseboard^</button^>
echo ^<button onclick="onboarddevice()"^>onboarddevice^</button^>
)>"%htmlfile%"


echo ^<div id="computersystem" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" computersystem get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="OS" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" OS get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="PRODUCT" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" PRODUCT get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="environment" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" environment get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="useraccount" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" useraccount get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="baseboard" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" baseboard get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="server" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" server get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="service" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" service get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="bios" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" bios get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="cpu" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" cpu get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="memorychip" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" memorychip get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="idecontroller" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" idecontroller get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="logicaldisk" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" logicaldisk get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="diskdrive" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" diskdrive get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

echo ^<div id="onboarddevice" style="display: none;"^> >>"%htmlfile%"
wmic /node:%computer% /Append:"%htmlfile%" onboarddevice get /format:hform >NULL
echo ^</div^> >>"%htmlfile%"

rem set the footer
(
echo ^<script^>
echo function computersystem^(^) {
echo     var x = document.getElementById^("computersystem"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function OS^(^) {
echo     var x = document.getElementById^("OS"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function PRODUCT^(^) {
echo     var x = document.getElementById^("PRODUCT"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function environment^(^) {
echo     var x = document.getElementById^("environment"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function useraccount^(^) {
echo     var x = document.getElementById^("useraccount"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function baseboard^(^) {
echo     var x = document.getElementById^("baseboard"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function bios^(^) {
echo     var x = document.getElementById^("bios"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function server^(^) {
echo     var x = document.getElementById^("server"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function service^(^) {
echo     var x = document.getElementById^("service"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function cpu^(^) {
echo     var x = document.getElementById^("cpu"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function memorychip^(^) {
echo     var x = document.getElementById^("memorychip"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function idecontroller^(^) {
echo     var x = document.getElementById^("idecontroller"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function logicaldisk^(^) {
echo     var x = document.getElementById^("logicaldisk"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function diskdrive^(^) {
echo     var x = document.getElementById^("diskdrive"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo function onboarddevice^(^) {
echo     var x = document.getElementById^("onboarddevice"^);
echo     if ^(x.style.display === "none"^) ^{
echo        x.style.display = "block";
echo     } else {
echo         x.style.display = "none";
echo     }
echo }
echo ^</script^>
echo ^</body^>
echo ^</html^>
)>>"%htmlfile%"

echo See %htmlfile%
start %htmlfile%
 
set computer=
set htmlfile=