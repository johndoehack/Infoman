#!/bin/bash

###############################################################################################################

internet() {
if ping -q -c 1 -W 1 google.com >/dev/null; then
	case1
else
	zenity --error --text="Please Connect to Internet";clear;exit
fi
}
###############################################################################################################

main() {
	clear && clear

	cat << "EOF"
					 _____        __                 __  __            ©
					|_   _|      / _|               |  \/  |
					  | |  _ __ | |_ ___    ______  | \  / | __ _ _ __
					  | | | '_ \|  _/ _ \  |______| | |\/| |/ _` | '_ \
					 _| |_| | | | || (_) |          | |  | | (_| | | | |
					|_____|_| |_|_| \___/           |_|  |_|\__,_|_| |_|
										      FOR PENTESTERS
EOF



#################################################################################################################
# Move cursor to screen location X,Y (top left is 0,0)

# Set a foreground colour using ANSI escape
#if ping -q -c 1 -W 1 google.com >/dev/null; then
#	tput cup 8 55
#	tput bold
#	echo " [ Active Internet Connection ] "
#	tput sgr0
#else
#	zenity --error --text="Please Connect To Internet" | clear
#	exit 0
#fi

tput bold
tput cup 9 15
tput setaf 1 45
echo "Private IP:"

tput cup 9 26
tput setaf 7
ifconfig | sed -n 2p | cut -d "t" -f2 | cut -d "n" -f1 -s

tput bold
tput cup 11 15
tput setaf 1 45
echo "Gateway   :"

tput cup 11 27
tput setaf 7
route -n | sed -n 3p | cut -c 17- | cut -d " " -f1

tput bold
tput cup 9 94
tput setaf 1 39
echo "Public IP:"

tput bold
tput cup 9 107
tput setaf 7
curl ifconfig.co

tput cup 11 99
tput setaf 7
for isp in $(curl ifconfig.co --silent); do
whois $isp;
done | grep "descr:" | sed -n 1p | cut -d ":" -f2

tput cup 11 94
tput setaf 1 45
echo "ISP:"

tput bold
tput cup 10 55
tput setaf 1 60
echo "Mac Address:"

tput cup 10 68
tput setaf 7
ifconfig | grep ether | sed -n 1p | cut -d "r" -f2 | cut -d "t" -f1

tput sgr0

tput cup 15 12
tput setaf 6
echo " ' Select The Tool You Wish '  "
tput sgr0

tput cup 18 15
echo "1. Host Discovery"

tput cup 20 15
echo "2. Network Scanner"

tput cup 22 15
echo "3. IP Enumeration"

tput cup 24 15
echo "4. Domain Enumeration"

tput cup 26 15
echo "5. Email-Host-Domain Grepper"

# Set bold mode
tput bold
tput setaf 1
tput cup 28 15
echo "6. Exit"

tput cup 30 15
tput setaf 6
read -p "Enter your choice [1-5]: " n
tput sgr0
tput clear


host() {
clear && clear
toilet -f smblock 'Host Discovery' -F gay
tput cup 10 15
echo " 1. Netdiscover "
tput cup 12 15
echo " 2. Back "
tput cup 14 15
echo " 3. Exit "
tput cup 16 15
read -p " Enter your Choice [1-2]: " n
tput sgr0
case $n in
	1)tput clear
	tput cup 1 1
	echo "List of Connected Hosts"
	echo " "
	tput setaf 4
	echo "################################################################"
	tput setaf 7
	tput cup 4 1
	echo "IP ADDRESS"
	tput cup 4 18
	echo "MAC ADDRESS"
	tput cup 4 45
	echo "DEVICE-INFO"
	tput setaf 4
	echo "################################################################"
	tput setaf 2
	arp-scan -l | sed 1,2d | head -n -3 | cut -d "(" -f1 | cut -d ")" -f2
	tput setaf 4
	echo "################################################################"
	echo " "

        if
		read enter; then
		host
	fi
	;;

	2)main
	;;


	3)exit
	;;

	*)
	clear && clear
	zenity --error --text="Invalid Option - Please Choose from List";host
	
	;;
esac
}
################################---2---#####################################

nmapf() {
clear && clear

tput bold
					toilet -f smblock 'Nmap ' -F gay
					tput setaf 5
					tput cup 9 10
					echo "
		#######################################################################################
		#  Network Mapped (Nmap) is a network scanning and host detection tool that is very   #
		#  useful during several steps of penetration testing. Nmap is not limited to merely  #
		#  gathering information and enumeration, but it is also powerful utility that can be #
		#  used as a vulnerability detector or a security scanner.			      #
		#######################################################################################"
					tput setaf 7
					tput cup 18 18			
					echo " Select The Tool"
					tput sgr0
					tput setf 6
					tput cup 21 15
					echo "1. Nmap for Pentesters"
					tput cup 23 15
					echo "2. Nmap for Beginners"
					tput cup 25 15
					tput setaf 1
					echo "3. Back"
					tput bold
					tput cup 27 15
					echo "4. Exit"
					tput cup 29 15
					read -p "Enter your choice [1-3]: " n
					tput sgr0
					tput clear
					case $n in
						1)tput clear
						toilet -f smblock 'Nmap for Pentesters' -F gay
						tput cup 9 1
						echo "List of Connected Hosts"
						echo " "
						tput setaf 4
						echo "################################################################"
						tput setaf 7
						tput cup 12 1
						echo "IP ADDRESS"
						tput cup 12 18
						echo "MAC ADDRESS"
						tput setaf 4
						echo "################################################################"
						tput setaf 2
						arp-scan -l | sed 1,2d | head -n -3 | cut -d "(" -f1 | cut -d ")" -f2
						tput setaf 4
						echo "################################################################"
						echo " "
						tput setaf 1
						echo "USAGE: -p- / -Sn- / -Ss- 192.168.XX.XX"
						echo " "
						tput setaf 3
						read -p "Enter IP Address/Domain Name: " var
						tput sgr0
						tput clear
						nmap  $var
						nmap $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Pentesters/$"(date +"%Y_%m_%d_%I_%M_%p").log"
						tput bold
						tput setaf 1
						echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Pentesters"
						echo " 	    \***Press Enter To Go Back***/"
						read enter
						sleep 1
						tput sgr0;nmapf
						;;
						3)main
						;;
						4)clear && clear;exit
						;;
						2)tput clear
						toilet -f smblock 'Nmap For Beginners' -F gay
						tput cup 9 1
						echo "List of Connected Hosts"
						echo " "
						tput setaf 4
						echo "################################################################"
						tput setaf 7
						tput cup 12 1
						echo "IP ADDRESS"
						tput cup 12 18
						echo "MAC ADDRESS"
						tput setaf 4
						echo "################################################################"
						tput setaf 2
						arp-scan -l | sed 1,2d | head -n -3 | cut -d "(" -f1 | cut -d ")" -f2
						tput setaf 4
						echo "################################################################"
						echo " "
						echo " "
						tput setaf 3
						tput sgr0
						read -p "Enter IP Address / Domain Name: " var
						tput clear
						tput setaf 4
						tput cup 3 45
						printf "You Had Choosen: $var"
						tput setaf 2
						tput cup 5 1
						echo "Choose a Command You Require: "
						tput setaf 3
						tput cup 7 0
						echo "1.  Probe only (host discovery, not port scan"
						echo "2.  SYN Scan"
						echo "3.  TCP Connect Scan"
						echo "4.  UDP Scan"
						echo "5.  Version Scan"
						echo "6.  OS Detection"
						echo "7.  Disable reverse IP address lookups"
						echo "8.  Use IPv6 only"
	echo "9.  Use several features, including OS Detection, Version Detection, Script Scanning (default), and traceroute"
						echo "10. Don't probe (assume all hosts are up)"
						echo "11. Default probe (TCP 80, 445 & ICMP)"
						echo "12. Check whether targets are up by probing TCP ports"
						echo "13. Use ICMP Echo Request"
						echo "14. Use ICMP Timestamp Request"
						echo "15. Use ICMP Netmask Request"
						echo "16. Scan 100 most popular ports"
						echo "17. Scan ports 1-65535"
						echo "18. Scan using default safe scripts"
						echo "19. Scan with a set of scripts"
						echo "20. *Vuln Scanner"
						echo " "
						echo "21. Back"
						echo "22. Exit"
						tput setaf 1
						tput bold
						read -p "Enter your choice [1-20]: " n
						tput sgr0
						tput clear
						case $n in
							1)nmap -sn $var
	 						nmap -sn  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 						tput bold
	 						tput setaf 1
	 						echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 						echo " 	    \***Press Enter To Go Back***/"
	 						read enter
							tput sgr0;nmapf
							;;
							2)nmap -sS $var
	  nmap -sS  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	3)nmap -sT $var
	nmap -sT  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	4)nmap -sU $var
		nmap -sU  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	5)nmap -sV $var
	 nmap -sV  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	6)nmap -O $var
	nmap -O  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	7)nmap -n $var
	  nmap -n  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	8)nmap -6 $var
	  nmap -6  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	9)nmap -A $var
	  nmap -A  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	10)nmap -Pn $var
	   nmap -Pn  $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	11)nmap -PB $var
	   nmap -PB $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	12)nmap -PS $var
	   nmap -PS $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	13)nmap -PE $var
	   nmap -PE $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	14)nmap -PT $var
	   nmap -PT $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	15)nmap -PM $var
	   nmap -PM $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	 tput bold
	 tput setaf 1
	 echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	 echo " 	    \***Press Enter To Go Back***/"
	 read enter
	 sleep 1
	tput sgr0;nmapf
	;;
	16)nmap -F $var
	   nmap -F $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	   tput bold
	   tput setaf 1
	   echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	   echo " 	    \***Press Enter To Go Back***/"
	   read enter
	   sleep 1
	   tput sgr0;nmapf
	;;
	17)nmap -p- $var
	   nmap -p- $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	   tput bold
	   tput setaf 1
	   echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	   echo " 	    \***Press Enter To Go Back***/"
	   read enter
	   sleep 1
	   tput sgr0;nmapf
	;;
	18)nmap -sV -sC $var
	   nmap -sV -sC $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	   tput bold
	   tput setaf 1
	   echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	   echo " 	    \***Press Enter To Go Back***/"
	   read enter
	   sleep 1
	   tput sgr0;nmapf
	;;
	19)nmap -sV --script=smb* $var
	   nmap -sV --script=smb* $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	   tput bold
	   tput setaf 1
	   echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	   echo " 	    \***Press Enter To Go Back***/"
	   read enter
	   sleep 1
           tput sgr0;nmapf
	;;
	20)nmap -Pn --script vuln $var
	   nmap -Pn --script vuln $var >>/root/Infoman/outputs/Network-Scanner/Nmap-Begginers/"$(date +"%Y_%m_%d_%I_%M_%p").log"
	   tput bold
	   tput setaf 1
	   echo " Your Result is Saved to Directory nmap/Outputs/Nmap-Beginners"
	   echo " 	    \***Press Enter To Go Back***/"
	   read enter
	   sleep 1
	   tput sgr0;nmapf
	;;
	21)nmapf
	;;
	22)exit
	;;
	*)
	clear && clear
	zenity --error --text="Invalid Option - Please Choose from List";nmapf
	;;
	esac
	;;
	*)
	clear && clear
	zenity --error --text="Invalid Option - Please Choose from List";nmapf
	;;
esac
}

################################---3---#####################################

ipenum() {
clear && clear
tput bold
toilet -f smblock 'IP Enumeration ' -F gay
tput setaf 5
tput cup 10 18
echo " Select The Tool"
tput sgr0
tput setf 6
tput cup 14 15
echo "1. IP Lookup"
tput cup 16 15
echo "2. TraceIt"
tput cup 18 15
tput setaf 1
echo "3. Back"
tput cup 20 15
echo "4. Exit"
tput bold
tput cup 22 15
read -p "Enter your choice [1-3]: " n
tput sgr0
tput clear
	case $n in
		1)toilet -f smblock 'IP LookUp' -F gay
		tput cup 9 10
		tput setaf 2
		echo "
####################################################################################
#										   #
# WHOIS is a query and response protocol that is widely used for querying 	   #
# databases that store the registered users or assignees of an Internet resource,  #
# such as a domain name, an IP address block or an autonomous system, 		   #
# but is also used for a wider range of other information. 			   #
#										   #
#################################################################################### "
		tput setaf 1
		tput cup 19 10
		read -p "Enter Public IP Address: " var
		tput setaf 3
		tput cup 21
		whois $var
		whois $var >>/root/Infoman/outputs/IP-Enumeration/IP-Lookup/"$(date +"%Y_%m_%d_%I_%M_%p").log"
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory ipenum/Outputs/whois."
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 5
		tput sgr0;ipenum
		;;
		2)tput clear
		toilet -f smblock 'TraceIt' -F gay
		tput cup 9 10
		tput setaf 2
		echo "
################################################################################################
#											       #
# Traceroute is a utility that records the route (the specific gateway computers at each hop)  #
# through the Internet between your computer and a specified destination computer. 	       #
# It also calculates and displays the amount of time each hop took.			       #
#											       #
################################################################################################ "
		tput setaf 1
		tput cup 18 10
		read -p "Enter Domain Name or IP Address: " var
		tput setaf 3
		tput cup 20
		traceroute $var
		traceroute $var >>/root/Infoman/outputs/IP-Enumeration/Traceit/"$(date +"%Y_%m_%d_%I_%M_%p").log"
		tput bold
		tput setaf 1
		echo " Your Result is Saved in Directory ipenum/Outputs/Traceit."
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 5
		tput sgr0;ipenum
		;;
		3)main
		;;
		4)exit
		;;
		*)
		clear && clear
		zenity --error --text="Invalid Option - Please Choose from List";ipenum
		;;
esac
}

################################---4---#####################################

domain() {
clear && clear
toilet -f smblock 'Domain Enumeration ' -F gay
tput setaf 5
tput cup 10 18
echo " Select The Tool"
tput sgr0
tput setf 6
tput cup 14 15
echo "1. Dnsenum"
tput cup 16 15
echo "2. Dnsmap"
tput cup 18 15
echo "3. WaFW00F"
tput setaf 1
tput cup 20 15
echo "4. Back"
tput cup 22 15
echo "5. Exit"
tput bold
tput cup 24 15
read -p "Enter your choice [1-4]: " n
tput sgr0
tput clear
	case $n in
		1)toilet -f smblock 'Dnsenum' -F gay
		tput setaf 1
		tput cup 15 10
		read -p "Enter Domain Name: " var
		tput setaf 3
		tput cup 21
		dnsenum $var
		dnsenum $var >>/root/Infoman/outputs/Domain-Enumeration/DnsEnum/"$(date +"%Y_%m_%d_%I_%M_%p").log"
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory ipenum/Outputs/whois."
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;domain
		;;
		2)toilet -f smblock 'Dnsmap' -F gay
		tput setaf 1
		tput cup 15 10
		read -p "Enter Domain Name: " var
		tput setaf 3
		tput cup 21
		dnsmap $var
		dnsmap $var >>/root/Infoman/outputs/Domain-Enumeration/Dnsmap/"$(date +"%Y_%m_%d_%I_%M_%p").log"
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory ipenum/Outputs/whois."
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;domain
		;;
		3)toilet -f smblock 'WaFW00F' -F gay
		tput setaf 1
		tput cup 15 10
		read -p "Enter Domain Name: " var
		tput setaf 3
		tput cup 21
		wafw00f $var
		wafw00f $var >>/root/Infoman/outputs/Domain-Enumeration/Waaf-W00f/"$(date +"%Y_%m_%d_%I_%M_%p").log"
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory ipenum/Outputs/whois."
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;domain
		;;
		4)main
		;;
		5)exit
		;;
		*)
		clear && clear
		zenity --error --text="Invalid Option - Please Choose from List";domain
		;;
esac
}
################################---5---#####################################

harvester() {
#################################################################################################################	
harvbanner() {
clear && clear
toilet -f smblock 'TheHarvester' -F gay
}
#################################################################################################################
harvbanner
tput cup 18 18
echo "1. TheHarvester"
tput setaf 1
tput cup 20 18
echo "2. Back"
tput bold
tput cup 22 18
echo "3. Exit"
tput cup 24 18
read -p "Enter your Choice:" n

subharv() {
harvbanner
tput setaf 5
tput cup 9 10
			echo "
	      #######################################################################################################
	      # The objective of this program is to gather emails, subdomains, hosts, employee names, open ports and# 
	      # banners from different public sources like search engines, PGP key servers and SHODAN computer      #
	      # database.This tool is intended to help Penetration testers in the early stages of the penetration   #
	      # test in order to understand the customer footprint on the Internet. It is also useful for  	    #
	      # anyone that wants to know what an attacker can see about their organization.                        #
	      #######################################################################################################"
tput setaf 7
tput cup 18 18
read -p "Enter the Domain Name: " var
tput cup 20 18
read -p "Enter the limit for result 0-500: " var1

clear && clear

harvbanner

tput cup 8 5
tput setaf 4
echo " <- Choose Your Data Source -> "
echo " "
 

tput setaf 6
echo "1. Google "
echo "2. LinkedIn "
echo "3. Twitter "
echo "4. Bing "
echo "5. Yahoo "
echo "6. Virus Total "
echo "7. Baidu "
echo "8. Bingapi "
echo "9. Dogpile "
echo "10. Googlecse"
echo "11. Google Plus"
echo "12. Google Profiles"
echo "13. PGP"
echo "14. VHost"
echo "15. Threat Crowd"
echo "16. crtsh"
echo "17. Net Craft"
echo "18. ALL "
echo "19. Back "
echo "20. Exit "
tput setaf 1
read -p " choose your source:" n

case $n in
	1)clear
		theharvester -d $var -l $var1 -b google -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	2)clear
		theharvester -d $var -l $var1 -b linkedin -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	3)clear
		theharvester -d $var -l $var1 -b twitter -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	4)clear && clear
		theharvester -d $var -l $var1 -b bing -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	5)clear && clear
		theharvester -d $var -l $var1 -b yahoo -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	6)clear && clear
		theharvester -d $var -l $var1 -b virustotal -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	7)clear && clear
		theharvester -d $var -l $var1 -b baidu -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	8)clear && clear
		theharvester -d $var -l $var1 -b bingapi -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	9)clear && clear
		theharvester -d $var -l $var1 -b dogpile -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	10)clear && clear
		theharvester -d $var -l $var1 -b googlecse -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	11)clear && clear
		theharvester -d $var -l $var1 -b googleplus -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	12)clear && clear
		theharvester -d $var -l $var1 -b google-profiles -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	13)clear && clear
		theharvester -d $var -l $var1 -b pgp -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	14)clear && clear
		theharvester -d $var -l $var1 -b vhost -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	15)clear && clear
		theharvester -d $var -l $var1 -b threatcrowd -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	16)clear && clear
		theharvester -d $var -l $var1 -b crtsh -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	17)clear && clear
		theharvester -d $var -l $var1 -b netcraft -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	18)clear && clear
		theharvester -d $var -l $var1 -b all -h 2>&1 | tee  /root/Infoman/outputs/TheHarvester/$(date +"%Y_%m_%d_%I_%M_%p").txt
		tput bold
		tput setaf 1
		echo " Your Result is Saved to Directory Domain-Email Info Grepper/Outputs/"
		echo " 	    \***Press Enter To Continue***/"
		read enter
		sleep 1
		tput sgr0;harvester
		;;
	19)clear && clear
		harvester
		;;
	20)clear && clear
		exit
		;;
	*)
	clear && clear
	zenity --error --text="Invalid Option - Please Choose from List";harvester
	;;
esac
}
case $n in
	1)subharv
		;;
	2)main
		;;
	3)clear && clear
		exit
		;;
	*)
	clear && clear
	zenity --error --text="Invalid Option - Please Choose from List";harvester
	;;
esac
}

################################---case---#####################################

case $n in
	1)host
	;;
	2)nmapf
	;;
	3)ipenum
	;;
	4)domain
	;;
	5)harvester
	;;
	6)clear;exit
	;;
	*)
	clear && clear
	zenity --error --text="Invalid Option - Please Choose from List";main
	;;
esac
}
internet;main
