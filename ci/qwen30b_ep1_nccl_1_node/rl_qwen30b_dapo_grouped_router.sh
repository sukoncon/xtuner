set -ex
cd /mnt/shared-storage-user/suzhongling/xtuner_11_27

export PATH=/usr/local/nvidia/bin/:$PATH
export LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64:$LD_LIBRARY_PATH
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6
export CUDA_HOME=/usr/local/cuda
# export NCCL_DEBUG=INFO

export XTUNER_USE_FA3=1
export TORCH_LOGS=recompiles 
export XTUNER_ROUTER_DEBUG=false 
export XTUNER_ACTIVATION_OFFLOAD=0
ulimit -u 65536
export TORCHINDUCTOR_COMPILE_THREADS=8
export NVSHMEM_IB_GID_INDEX=3

export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'
export PYTHONPATH=.

export TORCH_NCCL_AVOID_RECORD_STREAMS=True
export TORCHINDUCTOR_CACHE_DIR=/mnt/shared-storage-user/suzhongling/xtuner_11_27/inductor_cache/${NODE_RANK}

export NCCL_MAX_CTAS=24 # We need to control the max SM used by nccl
export DISTRIBUTED_COMMUNICATION_SM=24
export DISPATCHER=agrs 
export PYTHONPATH=$PYTHONPATH:/mnt/shared-storage-user/suzhongling/GroupedGEMM/local/lib/python3.12/dist-packages/grouped_gemm-1.1.4-py3.12-linux-x86_64.egg
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6:$LD_PRELOAD


git config --global --add safe.directory /mnt/shared-storage-user/suzhongling/xtuner_11_27


# torchrun --nproc-per-node=8  \
#     --master_addr=${MASTER_ADDR} \
#     --master_port=6000 \
#     --nnodes=${NODE_COUNT} \
#     --node_rank=${NODE_RANK} \
#     xtuner/v1/train/cli/sft_ib.py --config ci/qwen30b_ep8_1_node/agrs_acc_test.py


torchrun --nproc-per-node=8  \
    --master_port=6001 \
    xtuner/v1/train/cli/sft.py --config ci/qwen30b_ep1_nccl_1_node/agrs_acc_test.py
