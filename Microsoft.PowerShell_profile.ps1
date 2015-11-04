Write-Host "Running main powershell profile..."

$projects = 'C:\projects'
$share = 'C:\share'
$agent = Join-Path $projects -childpath "agent"


function proj { Set-Location $projects }
function agent { Set-Location $agent }
function share { Set-Location $share }

function rem($pattern)
{
     get-childitem . -include $pattern -recurse | foreach ($_) {remove-item $_.fullname}
}

function touch
{
	set-content -Path ($args[0]) -Value ($null)
}

function Set-Home
{
	$h = "C:\Users\jamrg_000\"
	Remove-Variable -Force HOME
	Set-Variable HOME $h
	$provider = get-psprovider filesystem
	$provider.Home = $h
}

# Load posh-git example profile
function Setup-PoshGit
{
	. C:\Users\jamrg_000\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1
}

function Greppable-File($file)
{
    return !($_.PSIsContainer) -and !($_.Name.ToString().ToLower().EndsWith(".dll")) -and !($_.Name.ToString().ToLower().EndsWith(".exe"))
}

function Grep-Current-Folder($pattern)
{
    Grep-Folder . $pattern
}

function Grep-Folder($folder, $pattern)
{
    gci $folder -rec | Where-Object { Greppable-File($_) } | foreach { select-string -path $_.FullName -pattern $pattern } 
}

# git-cl <LAST_TAG>..<MASTER|NEW_TAG>
function GitChangeLog($rangeSpecification)
{
	git log --merges --grep="pull request" --pretty=format:'%C(yellow)%h%Creset - %s%n  %an %Cgreen(%cr)%C(bold blue)%d%Creset%n' $rangeSpecification
}

Set-Alias git-cl GitChangeLog

function touch 
{
	set-content -Path ($args[0]) -Value ($null)
}

function Grepout($pattern)
{
    git checkout $(git branch | grep $pattern).Trim()
}
Set-Alias grout Grepout
Set-Alias open ii
Set-Alias git-cl GitChangeLog
Set-Alias gcf Grep-Current-Folder
Set-Alias gf Grep-Folder

Set-Home
Setup-PoshGit

cd ~

Write-Host "Profile complete."