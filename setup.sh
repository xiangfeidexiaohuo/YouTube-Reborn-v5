set -e
rm -rf layout/Library/Frameworks ffmpeg-kit-full-5.1.LTS-ios-framework.zip
curl -LO https://github.com/arthenica/ffmpeg-kit/releases/download/v5.1.LTS/ffmpeg-kit-full-5.1.LTS-ios-framework.zip
unzip ffmpeg-kit-full-5.1.LTS-ios-framework.zip -d layout/Library/Frameworks
rm -rf ffmpeg-kit-full-5.1.LTS-ios-framework.zip
echo Done