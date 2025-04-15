#!/bin/bash
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
cd ~
conda create --name alphafold32 python=3.11.11 -y
conda init
source ~/.bashrc 
conda activate alphafold32
conda install -c conda-forge gcc gxx cmake -y
export LD_LIBRARY_PATH="\$CONDA_PREFIX/lib:\$CONDA_PREFIX/lib/gcc/x86_64-conda-linux-gnu/14.2.0:\$CONDA_PREFIX/x86_64-conda-linux-gnu/lib:\$LD_LIBRARY_PATH"
mkdir -p ~/hmmer_build ~/hmmer
wget http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz -P ~/hmmer_build
cd ~/hmmer_build && tar zxf hmmer-3.4.tar.gz && rm hmmer-3.4.tar.gz
cd ~/hmmer_build/hmmer-3.4 && ./configure --prefix=~/hmmer
cd ~/hmmer_build/hmmer-3.4 && make -j8
cd ~/hmmer_build/hmmer-3.4 && make install
cd ~/hmmer_build/hmmer-3.4/easel && make install
rm -r ~/hmmer_build
cd ~
git clone https://github.com/google-deepmind/alphafold3.git
cd alphafold3
pip3 install -r dev-requirements.txt
pip3 install --no-deps .


# Append the variables to the end of .bashrc
cat <<EOF >> ~/.bashrc

# Added by script
export XLA_FLAGS="--xla_gpu_enable_triton_gemm=false --xla_disable_hlo_passes=custom-kernel-fusion-rewriter --xla_force_host_platform_device_count=2"
export XLA_PYTHON_CLIENT_PREALLOCATE=false
export TF_FORCE_UNIFIED_MEMORY=true
export XLA_CLIENT_MEM_FRACTION=10
export PATH="~/hmmer/bin:$PATH"
EOF

source ~/.bashrc
