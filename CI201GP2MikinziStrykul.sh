#!/bin/bash
#CI 201 Spring 2024 Group Project #2 Mikinzi Strykul Section 02
#References: https://www.geeksforgeeks.org/how-to-find-out-file-types-in-linux/
#https://www.geeksforgeeks.org/nslookup-command-in-linux-with-examples/
#https://www.stationx.net/linux-file-permissions-cheat-sheet/
#This script is meant to serve as System Admin menu for command line functions. These functions include: "Disk Management", "File Management", "Network Management", "Process Management", "User Account" and "Utilities". Each contains code that may be used by a system admin regularly. For the Disk Management function, the following is implemented: Display device info, Display disk partition info, Display block device info, and Display mounted disk info. For the File Management function, the following is implemented: Present Working Directory, List Directory Contents, Create a File, Change File Permissions, Remove a File, and Read a File. For the Network Mangement function, the following is implemented: ifconfig, ping, traceroute, nslookup, View network interfaces, View network routing table, View Current system users, and View Client machine information. For the Process Management function, the following is implemented: display Processes, Display Processes by usage, Terminate a Process, Display Disk Usage, Display Free Disk Space, and Display System Uptime. For the User Account function, the following is implemented: Add user, Delete user, Lock user password, Get information on user, Add group, Delete group, Find user (Determine if user exists in the system), and Find group (Determine if group exists in the system). Lastly, the Utilities function implements: Date/Time, Calendar, View Manual (man) Pages, Determine File Type, Determine Command Type, Sort File (Query for input and output files), and Search file (Query for input, file, output file, and search parameter).

MainMenu()
{
#clarify that this is the main menu for aesthetic 
    echo "----- Main Menu -----"
    
#print this just to help clarify for the user what they need to do
    echo "Select an option (1-7):"
    
#options array to store the options for the select statement
    options=("Disk Management" "File Management" "Network Management" "Process Management" "User Account" "Utilities" "Exit")
    
#select statement of the choices from the options array
    select choice in "${options[@]}"; do
    
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
    		DiskManagement
    		;;
    	2)
    		FileManagement
    		;;
    	3)
    		NetworkManagement
    		;;
    	4)
    		ProcessManagement
    		;;
    	5)
    		UserAccountManagement
    		;;
    	6)
    		Utilities
    		;;
#exit function
    	7)
    		echo "You are exiting the program."
    		exit 0
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done
}



#Disk Management function.
DiskManagement(){
#echo the name for aesthetic 
    echo "----- Disk Management -----"
  
    optionsDisk=("Display device info" "Display disk partition info" "Display block device info" "Display mounted disk info" "Return to Main Menu")
    #select statement of the choices from the options array
    select choice in "${optionsDisk[@]}"; do
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
    	#Display device info
    	#use the cd /dev file to display device info
    		cd /dev
			
	#call back to parent
		DiskManagement
    		;;
    	2)
    	#Display disk partition info
    	#make sure the user knows they will need sudo
    		echo "You will need sudo access for this" 
    	#use fdisk wiith -l to list the disk partition info
    		sudo fdisk –l
    		
		#call back to parent
		DiskManagement
    		;;
    	3)
    	#Display block device info
    	#use lsblk to display the block device info
    		lsblk
    		
		#call back to parent
		DiskManagement
    		;;
    	4)
    	#Display mounted disk info
    	#use df to display the mounted disk info
    		df sdb
    		
		#call back to parent
		DiskManagement
    		;;
    	5)
    	#return to mainmenu
    		MainMenu
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done

    
    MainMenu
}

#file Management function that will print the name and go back to main menu
FileManagement(){
     echo "----- File Management -----"
     optionsDisk=("Present working directory" "List Directory Contents" "Create a file" "Change File Permissions" "Remove a file" "Read a file" "Return to Main Menu")
    #select statement of the choices from the options array
    select choice in "${optionsDisk[@]}"; do
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
    	#Present working directory
		#use pwd to present the working directory
		
    		pwd
			
		#call back to parent
		FileManagement
    		;;
    	2)
    	#List directory contents
		#ask the user what directory to list the contents of and store it in directoryl
		
    		read -p "What directory do you want to list? " directoryl
			
		#use ls on the directory variable with ~/ to get to the current user's home folder
			
		ls ~/$directoryl
			
		#call back to parent
		FileManagement
    		;;
    	3)
    	#Create a file
		#ask the user where this file will go and put that in filedirectory
		
		read -p "Enter the directory to put this file into: " filedirectory
			
		#have the user enter the name for the file and read it into filename
		
    		read -p "Enter the name for the file: " filename
			
		#have the user enter the extension and read it into ext
		
		read -p "Enter the extension for the file: " ext
			
		#use touch to create a file with the filename and the extension
		
		touch ~/$filedirectory/$filename.$ext
			
		#call back to parent
		FileManagement
    		;;
    	4)
    	#Change file permissions
    	#have the user enter the file to change the permissions of into permfile
    		read -p "Enter in the file to change the permissions of: " permfile
    	#tell the user about how Linux uses the octal numbers for file permissions so that they know what to input
    		echo "For the permissions, you will need to provide the octal representation for file permissions. For example, if you want the owner to read/write/search, but others and group can only search, use 755."
    		echo "Octal digit	Permission(s) granted	Symbolic"
    		echo "
	0		None			[u/g/o]-rwx
	1	Execute permission only		[u/g/o]=x
	2	Write permission only		[u/g/o]=w
	3	Write and execute permissions only: 2 + 1 = 3	[u/g/o]=wx
	4	Read permission only		[u/g/o]=r
	5	Read and execute permissions only: 4 + 1 = 5	[u/g/o]=rx
	6	Read and write permissions only: 4 + 2 = 6	[u/g/o]=rw
	7	All permissions: 4 + 2 + 1 = 7	[u/g/o]=rwx"
	#have the user enter the three numbers for the permission into the permnumbers variable
    		read -p "Enter the three octal numbers: " permnumbers
    		
    	#use chmod with the permnumbers and permfile to change the permissions of the file
    		chmod $permnumbers $permfile
    	
    		#call back to parent
		FileManagement
    		;;
    	5)
    	#remove a file
		#ask the user the directory of the file and store it in filedirectory
		
		read -p "Enter the directory to find the file: " fileddirectory
			
		#have the user enter the file name with the extension to delete in the variable filedelete
		
    		read -p "Enter the file you want to delete (w/ extension): " filedelete
		
		#use the rm to remove the file in the directory given by the user with the filen ame given by the user
		
		rm ~/$fileddirectory/$filedelete
			
		#call back to parent
		FileManagement
			
    		;;
    	6)
    	#read a file
		#have the user enter the directory of the file and store it in filerdirectory
		
		read -p "Enter the directory to find the file: " filerdirectory
		
		#have the user enter the file name they want to read and store it in fileread
		
    		read -p "Enter the file you want to read (w/ extension): " fileread
			
		#use cat with the directory and file name to read the file
		
		cat ~/$filerdirectory/$fileread
			
		#call back to parent
			FileManagement
    		;;
    	7)
    	#return to mainmenu
    		MainMenu
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done
     MainMenu
}

#Network Management function that will print the name and go back to main menu
NetworkManagement(){
     echo "----- Network Management -----"
      optionsDisk=("ifconfig" "ping" "traceroute" "nslookup" "View network interfaces" "View networking routing table" "View current system users" "View client machine info" "Return to Main Menu")
    #select statement of the choices from the options array
    select choice in "${optionsDisk[@]}"; do
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
    		#ifconfig
		#call ifconfig
		
    		ifconfig
			
		#call back to parent
		
		NetworkManagement
    		;;
    	2)
    		#ping
		#have the user enter in the IP address into the IP variable 
		
    		read -p "Enter an IP Address to ping (Example: 172.80.19.10):" IP
			
		#Ping the IP given by the user
		
		ping $IP
			
		#call back to parent
		
		NetworkManagement
    		;;
    	3)
    		#traceroute
		#read in the host name to traceroute to into hostname
		
		read -p "Enter the host to traceroute to: " hostname
		
		#use traceroute with the hostname
		
		traceroute $hostname
		
    		#call back to parent
		
		NetworkManagement
    		;;
    	4)
    		#nslookup
		#read in the name of the domain to look up from the user into domainname
		
		read -p "Enter the domain to look up: " domainname
		
		#use nslookup with the domain name
		nslookup $domainname
			
  	 	#call back to parent
		
		NetworkManagement
    		;;
    	5)
    		#view network interfaces
		#use netstat with the -i switch to show all network interfaces
			
		netstat -i
		
    		#call back to parent
		
		NetworkManagement
    		;;
    	6)
    	#view networking routing table
		#use netstat with the -r switch to view the network routing table
			
		netstat -r 
			
    		#call back to parent
		
		NetworkManagement
    	
    		;;
    	7)
    	#view current system users
		#use finger to view the current system users
		finger
		
    		#call back to parent
		
		NetworkManagement
    	
    		;;
    	8)
    	#view client machine
		#use uname with the -a switch to display all information 
			
    		uname -a 
			
    		#call back to parent
		
		NetworkManagement
    		;;
    	9)
    	#return to mainmenu
    		MainMenu
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done
     MainMenu
}

#Process Management function that will print the name and go back to main menu
ProcessManagement(){
     echo "----- Process Management -----"
     optionsUser=("Display Processes" "Display Processes by usage" "Terminate a process" "Display Disk Usage" "Display Free Disk Space" "Display System Uptime" "Return to Main Menu")
    #select statement of the choices from the options array
    select choice in "${optionsUser[@]}"; do
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
    		#display processes
    		#use ps aux to display the info about running processes 
    		ps aux 
    		
    		#call back to parent
    		ProcessManagement
    		;;
    	2)
    		#display processes by usage
    		#use top to display processes by usage 
    		top
    		
    		#call back to parent
    		ProcessManagement
    		;;
    	3)
    		#terminate a process
    		#read in the process name
    		read -p "Enter the name of the process to terminate: " processname
    		
    		#tell the user they need sudo in case they dont know 
			
		echo "You will need sudo access for this."
		
		#use killall command with -i to ask before terminating the process given by the user.
		
    		killall -i $processname
    		
    		#call back to parent
    		ProcessManagement
    		;;
    	4)
    		#display disk usage
    		#use du to show the used disk space with the -a to show all files and -h to put it in human-readable format
    		
    		du -ah
    		
    		#call back to parent
    		ProcessManagement
    		;;
    	5)
    	#display free disk space
    	
    	#use df to show the free disk space with -h to make it human readable
    	
    		df -h
    		
    		#call back to parent
    		ProcessManagement
    		;;
    	6)
    	#display system uptime
    	#use uptime to display the system uptime
    		uptime 
    		
    		#call back to parent
    		ProcessManagement
    		;;

    	7)
    	#call back to mainmenu
    		MainMenu
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done
     MainMenu
}

#User Account Management function that will print the name and go back to main menu
UserAccountManagement(){

     echo "----- User Account Management -----"
     optionsUser=("Add user" "Delete user" "Lock user password" "Get info on user" "Add group" "Delete group" "Find user (if they exist)" "Find group (if they exist)" "Return to Main Menu")
    #select statement of the choices from the options array
    select choice in "${optionsUser[@]}"; do
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
    		#add user
		#tell the user they need sudo in case they dont know 
			
		echo "You will need sudo access for this."
			
		#read in the username to add 
		read -p "Enter the name for the user to add: " username
			
		#use the command useradd to add this user with sudo permissions 
		
		sudo useradd $username
			
		#call back to main
		UserAccountManagement
    		;;
    	2)
    		#delete user
		#tell the user they need sudo in case they dont know 
			
		echo "You will need sudo access for this."
			
		#read in the name for the user to delete
			
		read -p "Enter the name for the user to delete: " deluser
			
		#use sudo and userdel to delete the user, with -r to remove the home directory
			
		sudo userdel -r $deluser
			
		#call back to main
		UserAccountManagement
    		;;
    	3)
    		#lock user password 
			
		#tell the user they need sudo in case they dont know 
			
		echo "You will need sudo access for this."
		
		#read in the name from the user to lock the password of
			
		read -p "Enter the name of the user to lock the password of: " passuser
			
		#use sudo and passwd with the -l switch to lock the password of the user 
			
		sudo passwd -l $passuser 
			
		#call back to main
		UserAccountManagement
    		;;
    	4)
    		#get info on user
			
		#read in the username to get info on
			
		read -p "Enter the name of the user: " infouser
			
		#use id to get information on the user
			
		id $infouser
			
		#call back to main
		UserAccountManagement
    		;;
    	5)
		#add a group
			
		#tell the user they need sudo in case they dont know 
			
		echo "You will need sudo access for this."
			
		#read in the name for the new group
			
		read -p "Enter the name for the new group: " groupname
			
		#read in the group ID for the new group
			
		read -p "Specify the group ID: " groupid
			
		#using sudo and groupadd, specify the group ID with -g and create the group with the given name and ID
			
		sudo groupadd -g $groupid $groupname
		
		#call back to main
			
    		UserAccountManagement
    		;;
    	6)
    		#delete a group
			
		#tell the user they need sudo in case they dont know 
			
		echo "You will need sudo access for this."
			
		#read in the name of the group to delete 
			
		read -p "Enter the name of the group to delete: " delgroupname
			
		#using sudo and groupdel, delete the group given by the user
			
		sudo groupdel $delgroupname
			
		#call back to main
			
    		UserAccountManagement
    		;;
			
		7)
		#find user 
		
		#read in the name of the user you want to find
		
		read -p "Enter the username of the user you want to find: " fusername
			
		#use grep with the username on the /etc/passwd file to see if the user exists 
		
		grep $fusername /etc/passwd
			
		#if the exit code is not equal to zero, which is the success exit code, then it did not find a user. If it didn't find a user, it doesn't exist. 
			
		if [ $? -ne 0 ]
		then 
			echo "This user does not exist."
		fi
			
		#call back to main
			
    		UserAccountManagement
			
		;;
			
		8)
		#find group
		
		#read in the name of the group you want to find
		
		read -p "Enter the group name of the group you want to find: " fgroupname
			
		#use grep with the groupname on the /etc/group file to see if the group exists 
			
		grep $fgroupname /etc/group
			
		#if the exit code is not equal to zero, which is the success exit code, then it did not find a group. If it didn't find a group, it doesn't exist. 
			
		if [ $? -ne 0 ]
		then 
			echo "This group does not exist."
		fi
			
				
		#call back to main
			
    		UserAccountManagement
			
		;;
#return to main menu
    	9)
    		MainMenu
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done

     MainMenu
}


#Utilities function that will print the name and go back to main menu
Utilities(){
    echo "----- Utilities-----"
    optionsU=("Date/Time" "Calendar" "View Manual Pages" "Determine File Type" "Determine Command Type" "Sort File" "Search File" "Return to Main Menu")
     echo "Choose an option (1-8):"
    #select statement of the choices from the options array
    select choice in "${optionsU[@]}"; do
#case statement using the reply from the select statement to call the function that the user specified 
    case $REPLY in
    	1)
		#date/time print
    		date 
		#call back to the sub-directory menu
    		Utilities
    		;;
    	2)
		#print the calendar 
    		cal
		#call back to the sub-directory menu
    		Utilities
    		;;
    	3)
		#view man pages
    	#read in what command the user wants to man
		
    	   	read -p "What command do you want to man? " command
			
    	#man the command 
		
    	   	man $command
			
		#call back to the sub-directory menu
    	    Utilities
    		;;
    	4)
		#determine file type
		#read in the file they want to use
			read -p "What file do you want to determine the type of? " file
		
		#read in the directory you want to find this in
		
			read -p "What is the directory you want to find this in? " directory
			
		#use the command file to determine what kind of file this is
			file ~/$directory/$file
			
		#call back to the sub-directory menu
			Utilities 
    		;;
    	5)
		#determine command type
		#read in the command the user wants to determine the type of 
		
    		read -p "Enter a command to determine the command type: " commandt
			
		#use type to determine the command type of the user input
		
			type $commandt
			
		#call back to the sub-directory menu
			Utilities
    		;;
    	6)
		#sort files
		#read in the input file from the user
		
			read -p "Enter the input file to sort: " inputfile
			
		#read in the output file from the user
		
			read -p "Enter the output file: " outputfile
			
		#use the sort command on the input file and print this to the output file and the terminal 
			
			sort $inputfile | tee -a $outputfile
			
    		#call back to the sub-directory menu
			Utilities
    		;;
    	7)
		#search file
		#read in the input file to search
		
			read -p "Enter the input file to search: " inputfiles
			
		#read in the output file 
		
			read -p "Enter the output file: " outputfiles
			
		#read in the search parameters
			read -p "Enter the search parameter: " parameter
			
		#use grep to search for the parameter provided in the input file, tee this to the output file and to screen
			
			grep $parameter $inputfiles | tee -a $outputfiles
		
    		#call back to the sub-directory menu
			Utilities
    		;;
#main menu return function
    	8)
    		MainMenu
    		;;
#error catching 
    	*)
    		echo "Invalid option. Please try again"
    		;;
    	esac
    	done

    MainMenu
}


#clear the screen
clear
#call the mainmenu function
MainMenu

