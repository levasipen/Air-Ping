clear

echo "==== Air-Ping Stress Tool Setup ===="
echo ""
echo "This script will install required dependencies:"
echo ""

read -p "What type of system are you using? [D]ebian/Ubuntu-based | [F]edora/RHEL/CentOS | [O]ther: " os
os=$(echo "$os" | tr '[:upper:]' '[:lower:]')

install_debian() {
    sudo apt update
    sudo apt install -y hping3 nftables parallel
	chmod +x Air-Ping.sh
}

install_fedora() {
    if command -v dnf &>/dev/null; then
        echo "[*] Using dnf..."
        sudo dnf update -y
        sudo dnf install -y hping3 nftables parallel
		chmod +x Air-Ping.sh
    elif command -v yum &>/dev/null; then
        echo "[*] Using yum..."
        sudo yum update -y
        sudo yum install -y hping3 nftables parallel
		chmod +x Air-Ping.sh
    else
        echo "[!] Neither dnf nor yum found. Cannot continue."
        exit 1
    fi
}

install_other() {
    echo "[!] Unsupported system for automatic install."
    echo "Please install manually using your system's package manager:"
    echo "- hping3"
    echo "- nftables"
    echo "- parallel"
}

case "$os" in
    d)
        echo "[*] Detected Debian/Ubuntu-based system (including Kali, Parrot, etc)."
        install_debian
        ;;
    f)
        echo "[*] Detected Fedora/RHEL/CentOS-based system."
        install_fedora
        ;;
    o)
        echo "[!] Detected Other/Legacy system."
        install_other
        ;;
    *)
        echo "[!] Invalid input. Exiting setup."
        exit 1
        ;;
esac

echo ""
echo -e "\\033[1;32mSetup complete. All required tools are installed.\\033[0m"
