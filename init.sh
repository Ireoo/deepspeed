sudo su
apt update
apt install wget curl zsh git -y
python3 --version
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
chmod +x Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
bash Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
echo "export PATH=/home/ubuntu/miniconda3/bin/:$PATH" >> ~/.bashrc
source ~/.bashrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#nvidia
wget https://us.download.nvidia.com/tesla/515.105.01/NVIDIA-Linux-x86_64-515.105.01.run
chmod +x NVIDIA-Linux-x86_64-525.89.02.run
./NVIDIA-Linux-x86_64-525.89.02.run -no-x-check -no-nouveau-check -no-opengl-files
nvidia-smi

# cuda
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda
echo "export PATH=/usr/local/cuda-11.7/bin：$PATH" >>  ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-11.7/bin:$LD_LIBRARY_PATH" >>  ~/.bashrc
source ~/.bashrc




# conda
conda create -n py3.11 python=3.11
conda activate py3.11
conda init zsh

# deepspeed
pip install deepspeed>=0.9.0

git clone https://github.com/microsoft/DeepSpeedExamples.git
cd DeepSpeedExamples/applications/DeepSpeed-Chat/
pip install -r requirements.txt

python train.py --actor-model facebook/opt-13b --reward-model facebook/opt-350m --deployment-type single_node
