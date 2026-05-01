# 🚀 ItsMynaX Ultimate Installer - Beta Version (v7.0)

**ItsMynaX Ultimate Installer** is a high-performance, automated Windows deployment engine built on PowerShell. Designed for power users and developers, this tool replaces the sluggish traditional Windows Setup with a streamlined, direct-to-disk deployment method using the **DISM (Deployment Image Servicing and Management)** API.

---

## 🔥 Why ItsMynaX? (Beta Features)

*   **MynaX High-Speed Engine:** Automatically forces the system into **High Performance Power Mode** and sets PowerShell to **High Priority**, ensuring your SSD hits its maximum write speed during deployment.
*   **Zero-Restriction Install:** Native **Windows 11 Bypass** for TPM 2.0, Secure Boot, RAM, and unsupported CPUs. No ISO modification required.
*   **MynaX Turbo Optimizations:** 
    *   **Space Saver:** Disables Windows "Reserved Storage" during install, reclaiming **~7GB** of disk space immediately.
    *   **Privacy First:** Strips basic Telemetry and kills Hibernation for a leaner, faster OS.
*   **Advanced Hardware Telemetry:** Provides a professional-grade audit of your storage (Model, Bus Type, Health) before you commit to a wipe.
*   **Clean-State Logic:** Automatically reconstructs a fresh **GPT/UEFI** partition structure to eliminate boot-sector viruses or legacy partition errors.

---

## 🛠 Prerequisites

1.  **Environment:** Best used within **WinPE** (Win10/11 PE) or a secondary Windows environment.
2.  **Permissions:** Must be executed as **Administrator**.
3.  **Source:** Requires a valid Windows `.iso`, `.wim`, or `.esd` file.

---

## 📖 Deployment Guide

1.  **Launch:** Right-click `MynaBETA.ps1` and select **Run with PowerShell**.
2.  **Targeting:** Identify your target drive using the MynaX Disk Matrix.
3.  **Purge:** Confirm the disk wipe by typing `YES` (Warning: Data destruction is permanent).
4.  **Payload:** Drag and drop your Windows Image source into the console.
5.  **Configure:** Choose your Windows Edition Index and assign a Computer Name.
6.  **Finalize:** Once the process hits 100%, remove your installation media and reboot.

---

## ⚠️ Beta Phase Disclaimer

> **DANGER:** This tool performs low-level disk operations. ItsMynaX is not responsible for data loss due to incorrect Disk ID selection. Always backup your critical files before deployment. As this is a **Beta Version**, please report any bugs to the developer.

---

## 👨‍💻 Development Status

*   **Core Developer:** ItsMynaX
*   **Project Name:** Myna X System
*   **Build:** 7.0-BETA
*   **Language:** Full English (International Edition)

---
*Stay Clean. Stay Fast. Use **ItsMynaX**.*
