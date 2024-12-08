# python-uv-node docker image
Docker image with python, uv, and node.

user is root, the home folder is `/root`.
- nvm location is `/root/.nvm`
- uv location is `/root/.local/bin/uv`

I will probably change this in the future to use a non-root user but some packages like tesseract require root access to install.

available tags are :
- `aminedjeghri/python-uv-node:latest`
- `aminedjeghri/python-uv-node:3.11-22.8.0` (corresponds to `aminedjeghri/python-uv-nvm:python_version-node_version`)
