Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "c:\Users\Lenovo\Desktop\83Vencture\assets\Prakash_Ghagare_Website_Career_Profile.docx"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
$entry = $zip.GetEntry("word/document.xml")
$stream = $entry.Open()
$reader = New-Object System.IO.StreamReader($stream)
$content = $reader.ReadToEnd()
$reader.Close()
$stream.Close()
$zip.Dispose()

$matches = [regex]::Matches($content, "<w:t[^>]*>(.*?)</w:t>")
$text = foreach ($m in $matches) { $m.Groups[1].Value }
$fullText = $text -join " "
Write-Output $fullText
