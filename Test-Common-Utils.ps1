cls
split-path $PSCommandPath -Leaf
. "$PSScriptRoot\common-utils.ps1"
''

"Startup folder: $(Get-SpecialPath 'Startup')"
''

$Phrase='Learn your ABCs'

"Example test: $Phrase"

"Example text in sentance case: $(Get-SentanceCase $Phrase.ToLower())"
#help Get-SentanceCase 

"Example text in sentance example: $(Get-TitleCase $Phrase.ToLower())"
#help Get-TitleCase -Examples

