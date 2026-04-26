$f = "Teacher.aspx"
Set-Content $f -Value '<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>' -Encoding UTF8
$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('<!DOCTYPE html>')
$lines.Add('<html xmlns="http://www.w3.org/1999/xhtml">')
$lines.Add('<head runat="server">')
$lines.Add('    <meta charset="UTF-8" />')
$lines.Add('    <meta name="viewport" content="width=device-width, initial-scale=1.0" />')
$lines.Add('    <title>Campus Connect - Teacher Dashboard</title>')
$lines.Add('    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />')
$lines.Add('</head>')
$lines.Add('<body>PLACEHOLDER</body>')
$lines.Add('</html>')
Add-Content $f -Value $lines -Encoding UTF8
Write-Output "Lines: $($lines.Count)"
