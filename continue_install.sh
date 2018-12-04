#!/usr/bin/env bash

base_dir=`(pwd)`

printf "Checking CUDA installation\nIf you see some graphics then Congratulations!!\n\n"
cd ~/NVIDIA_CUDA-9.0_Samples/5_Simulations/smokeParticles
make
# ./smokeParticles

cd $base_dir

cuDNN_check=`(cat /usr/include/x86_64-linux-gnu/cudnn_v*.h | grep CUDNN_MAJOR -A 2)`

#if echo $cuDNN_check | grep CUDNN_MAJOR;
#    then printf "cuDNN is already installed on your system!\n"
#    else
        if ls | grep libcudnn;
        then
            printf "\nInstalling cuDNN\n"
            sudo dpkg -i ./libcudnn7_7.3.1.20-1+cuda9.0_amd64.deb;
            sudo dpkg -i ./libcudnn7-dev_7.3.1.20-1+cuda9.0_amd64.deb;
        else
            printf "cuDNN files not found. Please register at nvidia developers https://developer.nvidia.com/cudnn Download 9.1 runtime & developer library for 16.04 (Files cuDNN v7.3.1 Runtime Library for Ubuntu16.04 (Deb) & cuDNN v7.1.3 Developer Library for Ubuntu16.04 (Deb)) Open the files with software manager and install them.\n\n";
        fi
#fi

sudo apt-get install libcupti-dev
printf "\nInstalling tensorflow gpu\n"
pip install --upgrade tensorflow-gpu --user



printf "\nInstallation complete!!\nVerifying..... If you see some high level mathamatical calculations, you've successfully installed tensorflow\n\n"
python3 test_tensorflow.py

