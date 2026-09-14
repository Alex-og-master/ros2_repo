.PHONY: all info docker vscode extensions terminator

# Instala todo lo necesario del día 1
all: docker vscode extensions terminator
	@echo "Todo instalado. Ya puedes empezar a trabajar."

# Muestra los targets disponibles
info:
	@echo "Targets disponibles:"
	@echo "  make all          - Instala Docker Desktop, VSCode, extensiones y Terminator"
	@echo "  make docker       - Instala Docker Desktop"
	@echo "  make vscode       - Instala VSCode"
	@echo "  make extensions   - Instala las extensiones de C++ y Python en VSCode"
	@echo "  make terminator   - Instala Terminator"

# --- Docker Desktop ---
docker:
	@if command -v docker >/dev/null 2>&1; then \
		echo "Docker ya está instalado."; \
	else \
		echo "Instalando Docker..."; \
		sudo apt update; \
		sudo apt install -y ca-certificates curl; \
		sudo install -m 0755 -d /etc/apt/keyrings; \
		sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc; \
		sudo chmod a+r /etc/apt/keyrings/docker.asc; \
		echo "deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $$(. /etc/os-release && echo $$VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null; \
		sudo apt update; \
		sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; \
		sudo usermod -aG docker $$USER; \
		echo "Docker instalado. Cierra sesión y vuelve a entrar para usarlo sin sudo."; \
	fi

# --- VSCode ---
vscode:
	@if command -v code >/dev/null 2>&1; then \
		echo "VSCode ya está instalado."; \
	else \
		echo "Instalando VSCode..."; \
		sudo apt update; \
		sudo apt install -y wget gpg; \
		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg; \
		sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg; \
		echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null; \
		rm -f packages.microsoft.gpg; \
		sudo apt update; \
		sudo apt install -y code; \
		echo "VSCode instalado."; \
	fi

# --- Extensiones de VSCode (C++ y Python) ---
extensions:
	@command -v code >/dev/null 2>&1 || { echo "VSCode no está instalado. Corre 'make vscode' primero."; exit 1; }
	code --install-extension ms-vscode.cpptools
	code --install-extension ms-python.python
	code --install-extension ms-python.vscode-pylance
	@echo "Extensiones de C++ y Python instaladas."

# --- Terminator ---
terminator:
	@if command -v terminator >/dev/null 2>&1; then \
		echo "Terminator ya está instalado."; \
	else \
		echo "Instalando Terminator..."; \
		sudo apt update; \
		sudo apt install -y terminator; \
		echo "Terminator instalado."; \
	fi