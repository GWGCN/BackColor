<#
   Provides a library of common-functions including:

   Get-SentanceCase() - returns a phrase in 'Sentance case'
   Get-SpecialPath()  - returns a special folder's filepath
   Get-TitleCase()    - returns a phrase in 'Title Case' 
   New-Shortcut()     - returns a Shortcut object for creating filing system shortcuts


Changes

V1.1
   Standardise function names

#>




<#
.Synopsis
   Get-SpecialPath returns the filepath to the specified special folder
.DESCRIPTION
   Get-SpecialPath takes the Name of a special folder and returns its filepath.
   If the Name parameter is empty, a list of available special folder names is returned.    
.EXAMPLE
   Get-SpecialPath 'Desktop'
   Get the filepath of the user's Desktop.
.EXAMPLE
   Get-SpecialPath('Startup')|Get-ChildItem
   List the content of the user's Startup folder
.EXAMPLE
   Get-SpecialPath ''
   List available special folder names
#>
function Get-SpecialPath
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Name should contain a string specifying the name of the required special folder
        [Parameter(Mandatory=$False, 
                   ValueFromPipelineByPropertyName=$true, 
                   Position=0
                   )]
        #[ValidateNotNull()]
        #[ValidateNotNullOrEmpty()]
        #[ValidateCount(0,5)]
        #[ValidateSet("sun", "moon", "earth")]
        #[Alias("Name")] 
        $Name
    )

    Begin
    {
    }

    Process
    {
        If ($Name)
        {
            Return ([environment]::GetFolderPath($Name))
            
        } else {
            # Null or empty
            Return ([Environment+SpecialFolder]::GetNames([Environment+SpecialFolder]))
        }
    }

    End
    {
    }
}

<#
.Synopsis
   New-Shortcut returns a new file system Shortcut object
.DESCRIPTION
   New-Shortcut returns an object associated with a specified file system shorcut.
   The object can be used to create new file system shortcuts by setting
   its attributes before saving it with the .Save() method.
   The .Load() method can be used to read details of an existing shortcut.

.EXAMPLE
   $Shortcut = New-Shortcut('C:\temp\calc.lnk')
   Return an empty shortcut object called Calc.+ 
.EXAMPLE
   $Shortcut.TargetPath = Calc.exe
   Set the shortcut's target to Calc.exe
.EXAMPLE
   $Shortcut.Save()
   Create the shortcut, overwritting any existing shortcut.
.EXAMPLE
   $Shortcut.Load 
   Load the contents of an existing shortcut for interogation or update.
.EXAMPLE
    $Shortcut
    View the attributes of the shortcut
#>
function New-Shortcut
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        # FullName defines the shortcut filepath and name. Include the .lnk extension.
        [Parameter(Mandatory=$True,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [String]
        $FullName
    )

    Begin
    {
        $WshShell = New-Object -ComObject WScript.Shell
    }
    Process
    {
        Return $WshShell.CreateShortcut($FullName)
    }
    End
    {
    }
}

<#
.Synopsis
   Get-TitleCase capitalises the inital character in each word of the input phrase.
.DESCRIPTION
   Get-TitleCase takes an input phrase and returns an equivent string with the intial character of each word capitalised and the other letters in lower case.
.EXAMPLE
   Get-TitleCase 'learn your ABCs'
   Returns 'Learn Your Abcs'

#>
function Get-TitleCase
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Phrase help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]
        $Phrase
    )

    Begin
    {
        $TextInfo = (Get-Culture).TextInfo
    }
    Process
    {
        Return $TextInfo.ToTitleCase($Phrase.ToLower())
    }
    End
    {
    }
}


<#
.Synopsis
   Get-SentanceCase capitcalises the first character of the phrase
.DESCRIPTION
   Get-SentanceCase returns the input string with the first character capitalised.
   The rest of the string is not effected.  
   
   To ensure the rest of the string is lower case apply .ToLower() to the input
   string prior to calling this function.
.EXAMPLE
   Get-SentanceCase('learn your ABCs')
   Returns 'Learn your ABCs'
.EXAMPLE
   Get-SentanceCase('learn your ABCs'.ToLower)
   Returns 'Learn your abcs'
#>
function Get-SentanceCase
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Phrase contains to string to have the initial leter capitalised
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]
        $Phrase
    )

    Begin
    {
    }
    Process
    {
    Return $Phrase.substring(0,1).toupper()+$Phrase.substring(1)
    }
    End
    {
    }
}



#"$PSCommandPath successfully loaded."
$File=split-path $PSCommandPath -Leaf
$Path=split-path $PSCommandPath -Parent
"$File successfully loaded from $Path"


