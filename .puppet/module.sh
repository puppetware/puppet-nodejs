
sudo puppet module list | grep 'skoblenick-nodejs'

if [ $? -ne 0 ]; then
    sudo puppet module install skoblenick/nodejs
else
    echo "Module already installed: skoblenick/nodejs"
fi