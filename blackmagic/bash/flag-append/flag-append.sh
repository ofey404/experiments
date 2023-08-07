USE_FLAG_1="YES"

FLAGS=$(cat <<EOF
--nnodes 1 \
--nproc_per_node 1 \
./train.py \
--epoch ${epoch} \
--project_dir ${PROJECT_DIR} \
--dataset_dir ${DATASET_DIR} \
--model_dir ${MODEL_DIR} \
--output_dir ${OUTPUT_DIR}
EOF
)

if [[ ! -z "$USE_FLAG_1" ]]; then
  FLAGS="$FLAGS --flag1 $USE_FLAG_1"
fi

echo $FLAGS
# torchrun $FLAGS
