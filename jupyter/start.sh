mkdir -p /lab/jupyter/notebook
jupyter notebook --port=8888 --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='' \
      --notebook-dir=/lab/jupyter/notebook --NotebookApp.base_url='/jupyter/'