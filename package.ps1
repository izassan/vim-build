if(!(Test-Path .\vim\vim91)){
    exit
}

Compress-Archive -Path .\vim\vim91\** -DestinationPath .\vim91.zip
