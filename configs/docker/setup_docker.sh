#! /bin/sh

echo "copying latest dotfiles"
rm -rf .localrc .dot-files
cp -r ~/.localrc  ~/.dot-files .
cp -r ~/.ssh .

echo "copying latest docker files"
# cp /home/pooya/proj/templates/Dockerfile .
# cp /home/pooya/proj/templates/make_container.sh .
# cp /home/pooya/proj/templates/build_image.sh .
cp `dirname $0`/Dockerfile .
cp `dirname $0`/make_container.sh .
cp `dirname $0`/build_image.sh .

echo "copying done. edit the build_image and make_container files accordingly"
mkdir -p ./data
