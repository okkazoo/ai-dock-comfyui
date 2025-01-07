#!/bin/bash

# Install custom nodes
cd /opt/ComfyUI/custom_nodes
git clone https://github.com/some-author/some-custom-nodes
git clone https://github.com/another-author/another-custom-nodes

# Download models
cd /opt/ComfyUI/models/checkpoints
wget https://huggingface.co/somemodel/resolve/main/model.safetensors

# Download VAEs
cd /opt/ComfyUI/models/vae
wget https://huggingface.co/somevae/resolve/main/vae.safetensors

# Download LoRAs
cd /opt/ComfyUI/models/loras
wget https://civitai.com/api/download/models/somelora 