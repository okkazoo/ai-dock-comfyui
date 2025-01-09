# For build automation - Allows building from any ai-dock base image
# Use a *cuda*base* image as default because pytorch brings the libs
ARG IMAGE_BASE="ghcr.io/ai-dock/python:3.10-v2-cuda-12.1.1-base-22.04"
FROM ${IMAGE_BASE}

LABEL org.opencontainers.image.source="https://github.com/ai-dock/comfyui"
LABEL org.opencontainers.image.description="ComfyUI Stable Diffusion backend and GUI"
LABEL maintainer="Rob Ballantyne <rob@dynamedia.uk>"

ENV COMFYUI_VENV=$VENV_DIR/comfyui
ENV COMFYUI_VENV_PYTHON=$COMFYUI_VENV/bin/python
ENV COMFYUI_VENV_PIP=$COMFYUI_VENV/bin/pip

ENV API_VENV=$VENV_DIR/api
ENV API_VENV_PYTHON=$API_VENV/bin/python
ENV API_VENV_PIP=$API_VENV/bin/pip

ENV IMAGE_SLUG="comfyui"
ENV OPT_SYNC=ComfyUI

# Prepare environment
ARG PYTHON_VERSION="3.10"
ENV PYTHON_VERSION=${PYTHON_VERSION}
ARG PYTORCH_VERSION="2.4.0"
ENV PYTORCH_VERSION="${PYTORCH_VERSION}"

# Copy build files
COPY --chown=0:1111 ./COPY_ROOT_0/ /
ARG IMAGE_BASE
RUN set -eo pipefail && /opt/ai-dock/bin/build/layer0/init.sh | tee /var/log/build.log

RUN echo "bust cache"
# Install software
ARG COMFYUI_BUILD_REF
ENV COMFYUI_BUILD_REF=${COMFYUI_BUILD_REF}
COPY --chown=0:1111 ./COPY_ROOT_1/ /
RUN set -eo pipefail && /opt/ai-dock/bin/build/layer1/init.sh | tee -a /var/log/build.log

# Pre-download essential models
RUN mkdir -p /workspace/storage/stable_diffusion/models/{ckpt,vae} && \
    wget -P /workspace/storage/stable_diffusion/models/ckpt \
    https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt && \
    wget -P /workspace/storage/stable_diffusion/models/vae \
    https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors

# Install essential nodes
RUN cd /opt/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager

# Copy final configuration
COPY --chown=0:1111 ./COPY_ROOT_99/ /
RUN set -eo pipefail && /opt/ai-dock/bin/build/layer99/init.sh | tee -a /var/log/build.log

ENV PYTHON_DEFAULT_VENV=comfyui

CMD ["init.sh"]