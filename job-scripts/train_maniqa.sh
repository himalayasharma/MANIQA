#!/bin/bash
#SBATCH --account=rrg-zhouwang
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:v100l:4
#SBATCH --time=01:00:00
#SBATCH --mail-user=himalaya.sharma.india@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --output=%x-%j.out

# Copy repo to compute node
rsync -r ~/projects/def-zhouwang/himsha/models/MANIQA $SLURM_TMPDIR/
# Create directory to store dataset
mkdir -p $SLURM_TMPDIR/datasets/pipal-22/
# Copy train dataset
rsync -r ~/projects/def-zhouwang/himsha/datasets/pipal-22/Train_distort.tar.gz $SLURM_TMPDIR/datasets/pipal-22/Train_distort.tar.gz
# Copy validation dataset
rsync -r ~/projects/def-zhouwang/himsha/datasets/pipal-22/Val_distort.tar.gz $SLURM_TMPDIR/datasets/pipal-22/Val_distort.tar.gz
# Traverse to dataset directory
cd $SLURM_TMPDIR/datasets/pipal-22/
# Extract train and validation datasets
tar -xf $SLURM_TMPDIR/datasets/pipal-22/Train_distort.tar.gz
tar -xf $SLURM_TMPDIR/datasets/pipal-22/Val_distort.tar.gz
# Load python 3.7
module purge
module load python/3.7
# Activate virtual environment
source ~/maniqa-py37/bin/activate
# Run train.py
cd $SLURM_TMPDIR
python ./MANIQA/train_maniqa.py
