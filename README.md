# 🏎️ Racecar Tutorial 🏎️
NNYYYYYYEEEOOOWWWWW

## Time Saver Don't Skip
Windows users click [this](https://download.mobatek.net/2512025030285413/MobaXterm_Portable_v25.1.zip)

Mac users, good luck. Try [this](https://royaltsx-v6.royalapps.com/updates/royaltsx_6.2.1.1000.dmg) maybe? 

## Connecting to Racecar
step 1
![Step 1](https://raw.githubusercontent.com/davidkott/racecar_tutorial/refs/heads/main/step1.png)
step 2
![Step 2](https://raw.githubusercontent.com/davidkott/racecar_tutorial/refs/heads/main/step2.png)
step 3
![Step 3](https://raw.githubusercontent.com/davidkott/racecar_tutorial/refs/heads/main/step3.png)
itll ask for your username and password which Zube should've given you.
## Installing Stuff and Things
Buckle up we're going 0 to 100. First copy and paste the commands bellow into 
```bash
git clone https://github.com/davidkott/racecar_tutorial.git
cd racecar_tutorial/
chmod +x hopefully_this_installs_alphafold3.sh
./hopefully_this_installs_alphafold3.sh
```

Next, copy paste this into the command line then cross your fingers and hope this works
```bash
cd $HOME/alphafold3/

nohup python run_alphafold.py --json_path=$HOME/alphafold3/sample.json \
	--model_dir=/data5/m633/model_parameters  \
	--output_dir=$HOME/alphafold3/output     \
	--db_dir=/data5/m633/database     \
	--flash_attention_implementation=xla     \
	--jax_compilation_cache_dir=$HOME/alphafold3/cache > run.out &
```

If you want to see how the progress of your run is doing run

```bash
cat run.out
```

# EVERY TIME YOU LOGIN
yes every, unless you don't want to them lmk
```bash
conda activate alphafold3

cd alphafold3/

nohup python run_alphafold.py --json_path=$HOME/alphafold3/sample.json \
	--model_dir=/data5/m633/model_parameters  \
	--output_dir=$HOME/alphafold3/output     \
	--db_dir=/data5/m633/database     \
	--flash_attention_implementation=xla     \
	--jax_compilation_cache_dir=$HOME/alphafold3/cache > run.out &
```

# Tips and Tricks
run the following command to see what GPU's are being used
```bash
nvidia-smi
```
The command will return a table that should look something like this

```bash
Mon Apr 14 20:52:34 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 570.124.04             Driver Version: 570.124.04     CUDA Version: 12.8     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  Tesla V100-PCIE-16GB           Off |   00000000:3B:00.0 Off |                    0 |
| N/A   26C    P0             26W /  250W |       5MiB /  16384MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   1  Tesla V100-PCIE-16GB           Off |   00000000:D8:00.0 Off |                    0 |
| N/A   27C    P0             23W /  250W |       5MiB /  16384MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A            1390      G   /usr/lib/xorg/Xorg                        4MiB |
|    1   N/A  N/A            1390      G   /usr/lib/xorg/Xorg                        4MiB |
+-----------------------------------------------------------------------------------------+

```

If you see one of the two GPUs (0 or 1) is being used, be respectively and use the other.


If GPU 0 is being used, run:
```bash
export CUDA_VISIBLE_DEVICES=1
```

If GPU 1 is being used, run:
```bash
export CUDA_VISIBLE_DEVICES=0
```

Once that is taken care of go into the alphafold3 folder to do what ever ya gotta do
```bash
cd alphafold3/
```

To check the progress of a run you've already launched use the cat command after you use cd to get into the alphafold3 folder.
```bash
cat run.out
```
