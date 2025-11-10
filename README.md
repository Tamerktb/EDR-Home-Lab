EDR Home Lab: Attack & Defense - Simulation using Sliver, LimaCharlie, VMs, C&C, & Threat Detection
Overview
This home lab simulates cyber attacks and defenses in a controlled environment. You'll use Kali Linux as the attacker machine to deploy Sliver (a Command & Control framework), target a Windows victim VM, and detect/respond using LimaCharlie (a cloud-based EDR platform). This helps practice threat simulation, detection, and response skills.
Key Components:

Attacker: Kali Linux VM (for Sliver C2 server).
Victim: Windows VM (e.g., Windows 10/11 with LimaCharlie sensor).
Tools: Sliver for C&C, LimaCharlie for threat detection, Virtual Machines for isolation.
Simulations: Basic reconnaissance, credential dumping, and ransomware-like actions.
Goals: Set up C2, execute attacks, detect them, and create response rules.

Warning: This is for learning only. Do not use on production systems or without permission. Ensure all activities comply with laws.
Prerequisites

Hardware: A host machine with at least 8GB RAM and 100GB storage.
Software:
Virtualization tool: VirtualBox (free) or VMware Workstation/Player.
Kali Linux ISO: Download from kali.org.
Windows ISO: Download a trial/evaluation from Microsoft.

Accounts:
Free LimaCharlie account: Sign up at app.limacharlie.io.
GitHub account (for hosting this repo).

Networking: Ensure VMs can communicate (e.g., via NAT or Internal Network in VirtualBox).
Time: 2-4 hours for setup.
