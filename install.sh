# Genesis Installation Script.
echo "--------------------------------------------------------------"
echo "Genesis Installation Script for Linux Systems."
echo "--------------------------------------------------------------"
echo "Change/Uncomment any settings as needed for different versions"
echo "of Pytorch and/or to install the Docker image."

# Update system
sudo apt update && sudo apt upgrade -y

# Check if the script is executed from within the Genesis directory
if [ "$(basename "$PWD")" != "Genesis" ]; then
    # If not, check if the Genesis directory already exists
    if [ -d "Genesis" ]; then
        echo "Genesis directory already exists. Changing directory..."
        cd Genesis || exit
    else
        echo "Cloning the Genesis repository..."
        git clone https://github.com/BenevolenceMessiah/Genesis.git
        cd Genesis || exit
    fi
else
    echo "Already in the Genesis directory."
fi

# Create and activate virtual environment
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3.11 -m venv .venv
else
    echo "Virtual environment already exists."
fi

source .venv/bin/activate

# Update Pip
pip install --upgrade pip

# Install Pytorch
# Stable with CUDA 12.4
# pip3 install torch torchvision torchaudio
# Stable with CUDA 12.1
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
# Stable with CUDA 11.8
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
# Nightly with CUDA 12.6
pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu126
# Nightly with CUDA 12.4
# pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu124
# Nightly with CUDA 11.8
# pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu118
# Stable with CPU
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
# Nightly With CPU
# pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cpu

# Install Genesis
pip install -e .

# Install Docker image:Latest
# Deactivate virtual environment
# deactivate
# Build the Docker image
# docker build -t genesis -f docker/Dockerfile docker
# Run the Docker image
# xhost +local:root # Allow the container to access the display
# docker run --gpus all --rm -it \
# -e DISPLAY=$DISPLAY \
# -v /tmp/.X11-unix/:/tmp/.X11-unix \
# -v $PWD:/workspace \
# genesis


