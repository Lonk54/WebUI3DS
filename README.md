# WebUI3DS

A Nintendo 3DS-inspired frontend for Open WebUI with custom branding, retro handheld aesthetics, and lightweight performance tweaks.



# Features

## Core Features

* Custom branding support
* Rename Open WebUI to **WebUI3DS**
* Custom favicon support
* Lightweight UI optimizations
* Mobile-friendly interface
* Retro Nintendo 3DS inspired design
* Docker deployment support
* Persistent chat and configuration storage
* OpenAI API support
* Ollama local model support
* Multi-model support
* Chat history
* User accounts and authentication
* Dark mode support
* Custom themes
* Fast startup times



# UI Features

## Nintendo 3DS Inspired Design

* Rounded UI panels
* Dual-screen inspired layout
* Retro menu styling
* Handheld-inspired color palette
* Compact sidebar design
* Console-like animations
* Custom loading screen
* Custom browser tab title
* Animated icons
* Retro-inspired sound support (optional)



# Customization

## Branding

You can customize:

* Application title
* Browser tab name
* Login screen logo
* Sidebar logo
* Loading animation
* Accent colors
* Wallpapers/backgrounds
* Custom CSS
* Favicon



# Docker Installation

## Quick Start

Pull the latest image:

```bash
docker pull ghcr.io/open-webui/open-webui:main
```

Run the container:

```bash
docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name webui3ds \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

Open your browser:

```text
http://localhost:3000
```



# Updating Docker Installation

## Standard Update

```bash
docker rm -f webui3ds

docker pull ghcr.io/open-webui/open-webui:main

docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name webui3ds \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

Your chats and settings remain saved in the Docker volume.



# Manual Compilation Guide

## Requirements

Install:

* Git
* Node.js 20+
* npm
* Python 3.11+
* Docker (optional)

Recommended OS:

* Linux
* Windows 11
* macOS



# Clone the Repository

```bash
git clone https://github.com/open-webui/open-webui.git

cd open-webui
```



# Install Frontend Dependencies

```bash
cd frontend
npm install
```



# Install Backend Dependencies

Return to project root:

```bash
cd ..
```

Create a virtual environment:

```bash
python -m venv venv
```

Activate the virtual environment:

## Windows

```bash
venv\Scripts\activate
```

## Linux/macOS

```bash
source venv/bin/activate
```

Install backend dependencies:

```bash
pip install -r requirements.txt
```



# Compiling the Frontend

Navigate to frontend:

```bash
cd frontend
```

Build production files:

```bash
npm run build
```

Compiled files will appear in:

```text
frontend/build
```



# Running the Backend

Return to the project root:

```bash
cd ..
```

Start the backend server:

```bash
bash start.sh
```

Or on Windows:

```powershell
start_windows.bat
```



# Accessing WebUI3DS

Open:

```text
http://localhost:8080
```



# Changing the Browser Title

Edit:

```text
frontend/index.html
```

Find:

```html
<title>Open WebUI</title>
```

Replace with:

```html
<title>WebUI3DS</title>
```

Rebuild the frontend:

```bash
npm run build
```



# Changing the Favicon

Replace:

```text
frontend/static/favicon.png
```

or:

```text
frontend/static/favicon.ico
```

Recommended sizes:

* 64x64
* 128x128
* 256x256

Rebuild the frontend afterward:

```bash
npm run build
```



# Applying Custom CSS

Create:

```text
frontend/src/styles/webui3ds.css
```

Import it inside:

```text
frontend/src/app.css
```

Example:

```css
body {
  background: #111827;
  border-radius: 12px;
}
```



# Recommended Hardware

## Minimum for compiling manually

* Dual-core CPU
* 4GB RAM
* Integrated graphics

## Recommended for compiling manually

* Quad-core CPU
* 8GB+ RAM
* SSD storage
* Dedicated GPU for local models



# Troubleshooting

## Docker Container Will Not Start

Check logs:

```bash
docker logs webui3ds
```



## Frontend Build Fails

Delete node_modules:

```bash
rm -rf node_modules
```

Reinstall dependencies:

```bash
npm install
```



## Port Already In Use

Change:

```bash
-p 3000:8080
```

To another port:

```bash
-p 8081:8080
```



# Credits

## Based On

* (Open WebUI)[https://github.com/open-webui] 
* (Ollama[https://github.com/ollama/ollama]
* OpenAI APIs

## Inspired By

* Nintendo 3DS
* (Open WebUI)[https://github.com/open-webui] 



## Special thanks

* (Open WebUI)[https://github.com/open-webui] 
* DevkitPro

# License

Follow the original Open WebUI license unless modified otherwise.



# Future Plans

* Animated banner
* Gamepad navigation support

