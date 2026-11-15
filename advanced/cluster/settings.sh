# The only file you need to edit. Every job reads these values.

# Your Slurm allocation (sbatch --account) and the partition to run on.
ACCOUNT="CHANGE_ME"
PARTITION="CHANGE_ME"

# A folder with plenty of space (scratch) for container images and temporary files.
# Container images take about 10 GB.
CACHE_DIR="$HOME/scratch/apptainer"

# If nextflow is not already on your PATH, add the folder it lives in here.
export PATH="$HOME/.local/bin:$PATH"
