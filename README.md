# EDR Home Lab: Attack & Defense Simulation

**Sliver C2 + LimaCharlie EDR + Virtual Machines**

A home lab for simulating cyber attacks and defenses in a controlled environment. Use Kali Linux with Sliver C2 to attack a Windows VM, and detect/respond using LimaCharlie EDR.

## Architecture

```
┌─────────────────┐          ┌──────────────────────┐
│  Kali Linux VM  │  C2      │   Windows 10/11 VM   │
│  (Attacker)     │◄────────►│  (Victim)             │
│  - Sliver Server│  HTTPS   │  - Sliver Implant     │
│  - C2 Profiles  │  443     │  - LimaCharlie Sensor │
│  - Attack Tools │          │  - Sysmon             │
└─────────────────┘          └──────────┬───────────┘
                                         │
                                    ┌────▼────┐
                                    │LimaCharlie│
                                    │Cloud EDR │
                                    └─────────┘
```

## Project Structure

```
EDR-Home-Lab/
├── Vagrantfile              # VM automation
├── setup/                   # Setup scripts
│   ├── kali-setup.sh        # Kali provisioning
│   ├── windows-setup.ps1    # Windows provisioning
│   └── limacharlie-setup.ps1# EDR sensor installer
├── configs/                 # Configuration files
│   ├── sliver/              # Sliver C2 configs
│   └── limacharlie/         # Detection & Response rules
├── attacks/                 # Attack simulation scripts
│   ├── recon/               # Network & host enumeration
│   ├── credential-dumping/  # LSASS/SAM access sims
│   ├── ransomware-sim/      # Ransomware behavior sims
│   └── lateral-movement/    # Psexec/WMI persistence sims
├── detections/              # LimaCharlie D&R rules
├── telemetry/               # Telemetry generation scripts
└── resources/               # Links & references
```

## Prerequisites

- **Hardware**: 8GB+ RAM, 100GB+ storage, CPU with virtualization support
- **Software**: VirtualBox or VMware, Vagrant (optional)
- **Accounts**: [LimaCharlie](https://app.limacharlie.io/) free tier, GitHub

## Quick Start

### 1. Clone & Setup VMs

```bash
git clone https://github.com/Tamerktb/EDR-Home-Lab.git
cd EDR-Home-Lab

# Option A: Using Vagrant (automated)
vagrant up

# Option B: Manual (VirtualBox)
# 1. Install Kali Linux
# 2. Install Windows 10/11
# 3. Set both VMs to Host-Only or Internal Network
```

### 2. Configure Kali (Attacker)

```bash
# SSH into Kali VM
vagrant ssh kali

# Or run setup manually:
sudo ./setup/kali-setup.sh

# Start Sliver server
sudo systemctl start sliver
sliver-server
```

### 3. Configure Windows (Victim)

```powershell
# Run on Windows VM (or via Vagrant provisioner)
.\setup\windows-setup.ps1
```

### 4. Install LimaCharlie Sensor

```powershell
# Get install key from app.limacharlie.io -> Sensors -> Install
.\setup\limacharlie-setup.ps1 -InstallKey "YOUR_KEY_HERE"
```

### 5. Deploy Detection Rules

Upload `configs/limacharlie/detection-rules.yaml` and `configs/limacharlie/response-rules.yaml` to:
- LimaCharlie Console -> Artifacts -> D&R Rules

## Attack Scenarios

### Reconnaissance
```bash
# From Sliver implant
sliver > shell
.\attacks\recon\enumerate-hosts.ps1
```

### Credential Dumping
```bash
sliver > shell
.\attacks\credential-dumping\mimikatz-sim.ps1
```

### Ransomware Simulation
```bash
sliver > shell
.\attacks\ransomware-sim\simulate-ransomware.ps1
```

### Lateral Movement
```bash
sliver > shell
.\attacks\lateral-movement\psexec-sim.ps1
```

## Detection Rules Included

- **LSASS Access Detected** - Process opening lsass.exe
- **Mimikatz Detection** - Mimikatz binary detection
- **Suspicious PowerShell** - Base64/encoded/obfuscated commands
- **Scheduled Task Creation** - Suspicious task names
- **Service Installation** - Services from user-writable paths
- **Ransomware Notes** - Ransom note file creation
- **Process Injection** - Suspicious thread creation
- **Persistence** - Registry Run keys, Startup folder, WMI

## Generating Telemetry

```powershell
# Generate mixed normal + malicious events
.\telemetry\generate-events.ps1

# Simulate normal user activity (baseline)
.\telemetry\sim-user-activity.ps1 -DurationMinutes 10
```

## License

For educational purposes only. Do not use on systems without authorization.

## Resources

See `resources/links.md` for tool documentation, community links, and learning materials.
