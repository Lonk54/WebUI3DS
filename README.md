# WebUI3DS

This technical guide outlines the workflow for compiling the **WebUI3DS** environment into native Nintendo 3DS binaries. This process utilizes the **devkitARM** toolchain to produce hardware-executable files.

---

## 1. Prerequisites & Toolchain Setup

Before attempting a build, your development environment must be configured for ARM cross-compilation.

### Core Components
* **devkitPro:** The primary installer and environment manager.
* **devkitARM:** The GNU compiler collection for ARM (arm-none-eabi).
* **libctru:** The standard user-mode library for 3DS homebrew.

### Mandatory Dependencies
Open your **devkitPro MSYS2** terminal and execute the following to install the required libraries:
```bash
pacman -S 3ds-curl 3ds-dev 3ds-libjson-c 3ds-zlib 3ds-bzip2 3ds-libpng

```

---

## 2. Project Architecture

The Makefile expects a specific directory structure to resolve source files and assets during the linking phase. Ensure your project is organized as follows:

```text
WebUI3DS_Native/
├── source/             # C/C++ source files (.c, .cpp)
├── include/            # Header files (.h, .hpp)
├── gfx/                # Graphical assets (.png)
├── data/               # Binary data blobs (fonts, raw audio)
├── resources/          # App metadata (icon.png, banner.png)
└── Makefile            # The devkitPro 3DS build script

```

---

## 3. Compilation Workflow

Follow these steps within the **MSYS2** environment to compile your binaries.

### Step 1: Environment Variables

Ensure your shell recognizes the devkitPro paths:

```bash
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM

```

### Step 2: Workspace Cleanup

Remove previous object files and stale binaries to ensure a clean link:

```bash
make clean

```

### Step 3: Binary Generation

Run the compiler. This will trigger the asset pipeline (converting PNGs to t3x) and link the source code against libctru:

```bash
make

```

---

## 4. Output Artifacts

Successful compilation will result in the following files in your project root:

| File Extension | Description | Deployment |
| --- | --- | --- |
| **.3dsx** | Homebrew Executable | Run via Homebrew Launcher |
| **.smdh** | Metadata & Icon | Contains name/author info |
| **.cia** | CTR Importable Archive | Install via FBI to Home Menu |

---

## 5. Asset Pipeline Specifications

To maintain the **WebUI3DS** aesthetic on hardware, ensure your branding assets meet these requirements:

* **Icon:** `icon.png` must be $48 \times 48$.
* **Banner:** `banner.png` should be $256 \times 128$ for the top screen display.
* **Textures:** Use `citra-t3x` (automated via Makefile) for hardware-accelerated UI rendering.

---

## 6. Troubleshooting

* **Linker Error (CURL):** If the build fails with `undefined reference to 'curl'`, verify `-lcurl` is present in the `LIBS` section of your Makefile.
* **Texture Corruption:** Ensure `.png` assets are in a standard RGB/RGBA format before the `Tex3DS` conversion.
* **Missing Tools:** If `makerom` or `bannertool` are not found, ensure your PATH includes `/opt/devkitpro/tools/bin`.

---

## Credits

* **Toolchain:** devkitPro & devkitARM teams.
* **SDK:** libctru contributors.
* **WebUI:** WebUI for making this idea possible.
