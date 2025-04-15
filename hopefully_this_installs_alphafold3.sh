#!/bin/bash
cd $HOME
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
source $HOME/miniconda/bin/activate  # Ensures Conda is in the current session
conda init
source $HOME/.bashrc || source $HOME/.zshrc  
conda create --name alphafold3 python=3.11.11 -y
conda activate alphafold3
conda install -c conda-forge gcc gxx cmake  zlib -y
export LD_LIBRARY_PATH="\$CONDA_PREFIX/lib:\$CONDA_PREFIX/lib/gcc/x86_64-conda-linux-gnu/14.2.0:\$CONDA_PREFIX/x86_64-conda-linux-gnu/lib:\$LD_LIBRARY_PATH"
export CPPFLAGS="-I$CONDA_PREFIX/include"
export CFLAGS="-I$CONDA_PREFIX/include"
export CXXFLAGS="-I$CONDA_PREFIX/include"
export LDFLAGS="-L$CONDA_PREFIX/lib"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
mkdir -p $HOME/hmmer_build $HOME/hmmer
wget http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz -P $HOME/hmmer_build
cd $HOME/hmmer_build && tar zxf hmmer-3.4.tar.gz && rm hmmer-3.4.tar.gz
cd $HOME/hmmer_build/hmmer-3.4 && ./configure --prefix=$HOME/hmmer
cd $HOME/hmmer_build/hmmer-3.4 && make -j8
cd $HOME/hmmer_build/hmmer-3.4 && make install
cd $HOME/hmmer_build/hmmer-3.4/easel && make install
rm -r $HOME/hmmer_build
cd $HOME
git clone https://github.com/google-deepmind/alphafold3.git
cd alphafold3
pip3 install -r dev-requirements.txt
pip3 install --no-deps .
build_data
mkdir output
mkdir cache
mv $HOME/racecar_tutorial/sample.json ./

# Append the variables to the end of .bashrc
cat <<EOF >> $HOME/.bashrc

# Added by script
export XLA_FLAGS="--xla_gpu_enable_triton_gemm=false --xla_disable_hlo_passes=custom-kernel-fusion-rewriter --xla_force_host_platform_device_count=2"
export XLA_PYTHON_CLIENT_PREALLOCATE=false
export TF_FORCE_UNIFIED_MEMORY=true
export XLA_CLIENT_MEM_FRACTION=10
export PATH="$HOME/hmmer/bin:$PATH"
EOF

source $HOME/.bashrc
