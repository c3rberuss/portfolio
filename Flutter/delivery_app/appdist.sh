groups="groups.txt"
testers="testers.txt"
notes="release-notes.txt"
apk="build/app/outputs/apk/release/app-release.apk"
app_id=$1
versionCode=$2
versionName=$3

flutter build apk --release --build-name "$versionName" --build-number "$versionCode" && \
    firebase appdistribution:distribute $apk  \
    --app "$app_id"  \
    --release-notes-file "$notes" \
    --testers-file "$testers" \
    --groups-file "$groups"