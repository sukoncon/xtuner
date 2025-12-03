set -ex
REPLICAS=32
# name=multinode$REPLICAS-dsv3-sft-mb1-32k-sp4-fp8
name=n$REPLICAS-dsv3-30l-ep8-g-router-32k-2-shared-szl-69
cd /mnt/shared-storage-user/suzhongling/xtuner_11_27/
rjob submit -e DISTRIBUTED_JOB=true \
    --image=registry.h.pjlab.org.cn/ailab-llmrazor/xtuner:pt26_20251113_7302ba5_grouped_router_topk1 \
    --host-network=true --name $name -P $REPLICAS --gpu 8 --cpu 120  --memory 1500000 --charged-group bw_gpu \
    --private-machine='group' --namespace ailab-pj \
    --gang-start=true \
    --mount=gpfs://gpfs1/caoweihan:/mnt/shared-storage-user/caoweihan \
    --mount=gpfs://gpfs1/llmrazor-share:/mnt/shared-storage-user/llmrazor-share \
    --mount=gpfs://gpfs1/large-model-center-share-weights:/mnt/shared-storage-user/large-model-center-share-weights \
    --mount=gpfs://gpfs1/suzhongling:/mnt/shared-storage-user/suzhongling \
    --custom-resources rdma/mlnx_shared=8 \
    --custom-resources mellanox.com/mlnx_rdma=1 \
    -e SDC_TEST=true \
    -- bash -ecx /mnt/shared-storage-user/suzhongling/xtuner_11_27/ci/dsv3_30l_ep8_customed/dsv3_30l_ep8_32k_2_grouped_router_256gpu.bash
    --positive-tags node/gpu-lg-cmc-h-h200-3083.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-3074.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-3071.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-3026.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-3010.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-2921.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-2861.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-2294.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-2172.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-1885.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-1868.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-1077.host.h.pjlab.org.cn,node/gpu-lg-cmc-h-h200-0502.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0383.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0375.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0371.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0347.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0336.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0322.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0318.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0312.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0311.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0303.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0299.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0264.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0263.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0252.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0251.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0248.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0202.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0187.host.h.pjlab.org.cn,node/gpu-l-lg-cmc-h-h200-0177.host.h.pjlab.org.cn \
