#!/usr/bin/env bash

if ls /usr/local/ | grep cuda-9.0; 
    then ./continue_install.sh;
    exit
fi


printf "Installing python dependencies\n"
sudo apt-get install python3-pip python3-dev python3-virtualenv virtualenv -y


sleep 1s
printf "\nUpdating pip\n"
pip3 install --upgrade pip

sleep 1s
printf "\nInstalling Nvidia-drivers\n"
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

sleep 1s
printf "\nShowing graphics card properties\n"
nvidia-smi

sleep 3s
printf "\nIf you did not see anything related to graphics card or if there was some error, graphics card drivers did not install correctly\n"

sleep 2s
printf "\nTensorflow GPU dependencies\n"
sudo apt-get install g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
sudo apt install gcc-6 -y
sudo apt install g++-6 -y


#sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
#wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
#sudo dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
#sudo dpkg -i nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb


sudo apt-get update

if ls | grep cuda_9.0.176_384.81_linux-run;
    then echo "File already present";
    else
        wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run;
fi

printf "\nNOW YOU WILL SEE A BUNCH OF QUESTIONS, ANSWER THEM AS FOLLOWS: \n\nYou are attempting to install on an unsupported configuration. Do you wish to continue?\n[PRESS y] \n\nInstall NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81? \n[PRESS n]\n\nInstall the CUDA 9.0 Toolkit?\n[PRESS y] \n\nEnter Toolkit Location\n[PRESS ENTER] \n\nDo you want to install a symbolic link at /usr/local/cuda?\n[PRESS y] \n\nInstall the CUDA 9.0 Samples?\n[PRESS y]\n\nEnter CUDA Samples Location\n[PRESS ENTER]\n\n"

sleep 5s

chmod +x cuda_9.0.176_384.81_linux-run
sudo ./cuda_9.0.176_384.81_linux-run --override

sudo apt-get install cuda9.0 cuda-cublas-9-0 cuda-cufft-9-0 cuda-curand-9-0 \
  cuda-cusolver-9-0 cuda-cusparse-9-0 libcudnn7=7.1.4.18-1+cuda9.0 \
   libnccl2=2.2.13-1+cuda9.0 cuda-command-line-tools-9-0

sudo apt-get update
sudo apt-get install libnvinfer4=4.1.2-1+cuda9.0

sudo ln -s /usr/bin/gcc-6 /usr/local/cuda/bin/gcc
sudo ln -s /usr/bin/g++-6 /usr/local/cuda/bin/g++

sudo printf "\nexport PATH=/usr/local/cuda-9.0/bin\${PATH:+:\${PATH}}" >> ~/.bashrc
sudo printf "\nexport LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}" >> ~/.bashrc
sudo printf "\nexport LD_LIBRARY_PATH=/usr/local/cuda-9.0/extras/CUPTI/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}" >> ~/.bashrc
sudo printf "\nalias python=\"python3\"" >> ~/.bashrc

printf "\nSome environment variables were added to ~/.bashrc.\nThe system will reboot now, after reboot, please run the script again!!"
sleep 10s
reboot
