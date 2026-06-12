Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  # --- Kali Linux (Attacker) ---
  config.vm.define "kali" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.hostname = "kali-attacker"
    kali.vm.network "private_network", type: "dhcp"
    kali.vm.provider "virtualbox" do |vb|
      vb.name = "EDR-Kali-Attacker"
      vb.memory = 4096
      vb.cpus = 2
    end
    kali.vm.provision "shell", path: "setup/kali-setup.sh"
  end

  # --- Windows 10/11 (Victim) ---
  config.vm.define "windows" do |win|
    win.vm.box = "gusztavvargadr/windows-10"
    win.vm.hostname = "win-victim"
    win.vm.network "private_network", type: "dhcp"
    win.vm.provider "virtualbox" do |vb|
      vb.name = "EDR-Windows-Victim"
      vb.memory = 4096
      vb.cpus = 2
      vb.gui = true
    end
    win.vm.provision "shell", path: "setup/windows-setup.ps1", privileged: true
  end
end
