echo "cur bin $cur__bin"

CAMOMILE_ROOT=`esy bash -c 'echo #{@opam/camomile.install}'`
echo "Camomile root: $CAMOMILE_ROOT"
CAMOMILE_PATH=$CAMOMILE_ROOT/share/camomile/

ls $CAMOMILE_PATH

rm -rf _release
rm -rf _staging

mkdir -p _release/linux
mkdir -p _staging

cp -r $cur__bin _release/linux

wget -O _staging/linuxdeploy-x86_64.AppImage https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x _staging/linuxdeploy-x86_64.AppImage

wget -O _staging/appimagetool-x86_64.AppImage https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage
chmod +x _staging/appimagetool-x86_64.AppImage

cp scripts/linux/Onivim2.desktop _release/linux/Onivim2.desktop
cp assets/images/icon512.png _release/linux/Onivim2.png

./_staging/linuxdeploy-x86_64.AppImage -e _release/linux/bin/Oni2_editor --appdir _release/Onivim2.AppDir -d _release/linux/Onivim2.desktop -i _release/linux/Onivim2.png

cp scripts/linux/Onivim2.desktop _release/Onivim2.AppDir/Onivim2.desktop
cp scripts/linux/AppRun _release/Onivim2.AppDir/AppRun
chmod +x _release/Onivim2.AppDir/AppRun
cp assets/images/icon512.png _release/Onivim2.AppDir/Onivim2.png

cp _release/linux/bin/*.* _release/Onivim2.AppDir/usr/bin
cp _release/linux/bin/Oni2 _release/Onivim2.AppDir/usr/bin/Oni2

cp vendor/ripgrep-v0.10.0/linux/rg _release/Onivim2.AppDir/usr/bin/rg
cp vendor/node-v10.15.1/linux-x64/node _release/Onivim2.AppDir/usr/bin/node

cp -r $CAMOMILE_PATH _release/Onivim2.AppDir/usr/share

ls _release/Onivim2.AppDir/usr/share

cp -r extensions/ _release/Onivim2.AppDir/usr/bin
cp -r src/textmate_service/ _release/Onivim2.AppDir/usr/bin

rm _release/Onivim2.AppDir/usr/bin/setup.json

ARCH=x86_64 _staging/appimagetool-x86_64.AppImage _release/Onivim2.AppDir _release/Onivim2-x86_64.AppImage

