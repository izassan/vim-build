Param(
    $PythonDir = "$HOME\.local\share\scoop\apps\python\current"
)

$config = Get-Content $PSScriptRoot\config.json | ConvertFrom-Json
$pythonDirFormatted = $PythonDir.Replace("\", "/")

# make variable and check
$pythonVer = $config.python.version
$vimVersion = $config.vim.version
$gitTag = $config.release.tag
$releaseNote = $config.release.note
$title = $config.release.title
if(($null -eq $pythonVer) -Or ($pythonVer -eq "")){
    "specify python version"
    exit
}
if(($null -eq $vimVersion) -Or ($vimVersion -eq "")){
    "specify vim version"
    exit
}
if(($null -eq $gitTag) -Or ($gitTag -eq "")){
    "specify git tag"
    exit
}
if(($null -eq $releaseNote) -Or ($releaseNote -eq "")){
    "specify release note"
    exit
}
if(($null -eq $title) -Or ($title -eq "")){
    "specify release title"
    exit
}

# build vim
$vimBuildDir = "$PSScriptRoot\vim\vim$vimVersion"
mingw64 ./build.sh $pythonDirFormatted $pythonVer
if(-Not(Test-Path $vimBuildDir\vim.exe)){
    "vim build failed"
    exit
}

# packaging vim
$zipPath = ".\vim$vimVersion.zip"
if(-Not(Test-Path $vimBuildDir\vim.exe)){
    "zipfile is exist"
    exit
}
Compress-Archive -Path $vimBuildDir\** -DestinationPath $zipPath

# push release
gh release create -t $title -n $releaseNote $gitTag $zipPath

# remove build resources
Remove-Item -Recurse -Force .\vim,$zipPath
