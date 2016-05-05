Write-Host "Running main powershell profile..."

$projects = 'C:\projects'
$share = 'C:\share'
$agent = Join-Path $projects -childpath "agent"
$agent_common = Join-Path $projects -childpath "agent-common"
$agent_info = Join-Path $projects -childpath "agent-infogenesis"
$agent_diner = Join-Path $projects -childpath "agent-dinerware"
$agent_maitred = Join-Path $projects -childpath "agent-maitred"
$agent_template = Join-Path $projects -childpath "agent-template"
$api = Join-Path $projects -childpath "api"
$backend_core = Join-Path $projects -childpath "backend-core"
$config = Join-Path $projects -childpath "configs"

function proj { Set-Location $projects }
function agent { Set-Location $agent }
function common { Set-Location $agent_common }
function info { Set-Location $agent_info }
function diner { Set-Location $agent_diner }
function api { Set-Location $api }
function share { Set-Location $share }
function config { Set-Location $config }
function temp { Set-Location $agent_template }
function maitre { Set-Location $agent_maitred }
function back { Set-Location $backend_core }

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

function pull-all($branch)
{
    agent
    git fetch
    git checkout master
    git pull origin master
    
    common
    git fetch
    git checkout master
    git pull origin master
    
    info
    git fetch
    git checkout master
    git pull origin master
    
    diner
    git fetch
    git checkout master
    git pull origin master
    
    maitre
    git fetch
    git checkout master
    git pull origin master
    
    temp
    git fetch
    git checkout master
    git pull origin master
    
}

function tag-all($tag)
{
    agent
    git tag $tag
}

function clean-all()
{
    agent
    git clean -x -f -d
    
    common
    git clean -x -f -d
    
    info
    git clean -x -f -d
    
    diner
    git clean -x -f -d
    
    maitre
    git clean -x -f -d
    
    temp
    git clean -x -f -d
        
    agent
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
    git log --merges --grep="pull request" --pretty=format:'%C(yellow)%h%Creset - %C(bold green)%s%n %C(bold green)%b%n %an %Cgreen(%cr)%C(bold blue)%d%Creset%n' $rangeSpecification
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
Set-Alias venv "./venv/scripts/activate"

Set-Home
Setup-PoshGit
Import-Module PsGet

cd ~

Write-Host "Profile complete."