# Colors
GREEN=\033[0;32m
YELLOW=\033[0;33m
NC=\033[0m

NVM_USE := export NVM_DIR="$$HOME/.nvm" && . "$$NVM_DIR/nvm.sh" && nvm use
UV := "$$HOME/.local/bin/uv" # keep the quotes incase the path contains spaces

# Install uv
install-uv:
	@echo "${YELLOW}=========> installing uv ${NC}"
	@if [ -f $(UV) ]; then \
		echo "${GREEN}uv exists at $(UV) ${NC}"; \
		$(UV) self update; \
	else \
	     echo "${YELLOW}Installing uv${NC}"; \
		 curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$$HOME/.local/bin" sh ; \
	fi

###### NVM & npm packages ########
install-nvm:
	echo "${YELLOW}=========> Installing Evaluation app $(NC)"

	@if [ -d "$$HOME/.nvm" ]; then \
		echo "${YELLOW}NVM is already installed.${NC}"; \
		$(NVM_USE) --version; \
	else \
		echo "${YELLOW}=========> Installing NVM...${NC}"; \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash; \
	fi

	# Activate NVM (makefile runs in a subshell, always use this)
	@echo "${YELLOW}Restart your terminal to use nvm.  If you are on MacOS, run nvm ls, if there is no node installed, run nvm install ${NC}"
	@bash -c ". $$HOME/.nvm/nvm.sh; nvm install"

pre-commit-install:
	@echo "${YELLOW}=========> Installing pre-commit...${NC}"
	@$(UV) pip install pre-commit
	$(UV) run pre-commit install
pre-commit:
	@echo "${YELLOW}=========> Running pre-commit...${NC}"
	$(UV) run pre-commit run --all-files

PYTHON_VERSION := $(shell cat .python-version)
NVM_VERSION := $(shell cat .nvmrc)
docker-build:
	@echo "$(cat .python-version)-$(cat .nvmrc)"
	@echo "${YELLOW}=========> Building docker image...${NC}"
	docker build -t aminedjeghri/python-uv-node:$(PYTHON_VERSION)-$(NVM_VERSION) --platform linux/amd64,linux/arm64 .
	docker build -t aminedjeghri/python-uv-node:latest --platform linux/amd64,linux/arm64 .


docker-run:
	@echo "${YELLOW}=========> Running docker image...${NC}"
	docker run -it aminedjeghri/python-uv-node:latest
