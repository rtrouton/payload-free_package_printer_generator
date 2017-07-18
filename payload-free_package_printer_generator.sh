#!/bin/bash

# Parameters: 
#
# Name of the print queue (required)
# Location of the printer (optional)
# The printer's displayed name (required) 
# The IP or DNS address of the printer (required)
# Printer driver name (required)
# Up to nine additional printer options, like setting printer to print double-sided or to set specified trays to have certain paper sizes (optional)
# Apple Developer certificate, used to sign the payload-free package (optional)
# 
# By default, printer sharing is disabled.
#
# Usage:
# When using the script to create payload-free packages, command should look something like this:
#
# /path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz
#
# To create a signed payload-free package using a Developer ID Installer certificate: 
#
# /path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz -c "Developer ID Installer: Your Name (F487797D)"
#
# To create a signed payload-free package which creates a printer using a displayed name with spaces and/or special characters, add quotation marks to the displayed printer name:
# 
# /path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d "Printer Name Goes Here!" -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz  -c "Developer ID Installer: Your Name (F487797D)"
#
# Other flags can be added as needed:
#
# To add one additional option to the printer configuration (in this example, a custom tray for an HP printer):
#
# /path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz -1 HPOptionDuplexer=True
#
# To add two additional options to the printer configuration (in this example, a custom tray for an HP printer and a specified output mode) and sign the payload-free package:
#
# /path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz -1 HPOptionDuplexer=True -2 OutputMode=normal -c "Developer ID Installer: Your Name (F487797D)"

phelp() {
	echo ""
	echo "Usage: ./payload-free_package_printer_generator.sh options: -n -l -d -a -p -1 -2 -3 -4 -5 -6 -7 -8 -9 -c"
	echo ""
	echo "n: Name of the print queue. May not contain spaces, tabs, # or / characters. >> REQUIRED <<"
	echo "l: The physical location of the printer. Examples may include 'Reception Desk', 'Librarian's Office' or 'Second Floor, Room 2C456'. (optional)"
	echo "d: The printer name which is displayed in the Printers & Scanners pane of System Preferences, as well as in the print dialogue boxes. >> REQUIRED <<"
	echo "a: The IP or DNS address of the printer. Protocol must be specified as the address (for example, use 'lpd://ip.address.goes.here' or 'lpd://dns.address.goes.here' for LPR printing. >> REQUIRED <<"
	echo "p: Name of the driver file in /Library/Printers/PPDs/Contents/Resources/. This must use the full path to the drive (starting with /Library). >> REQUIRED <<"
	echo "1: Specify first printer option. (optional)"
	echo "2: Specify second printer option. (optional)"
	echo "3: Specify third printer option. (optional)"
	echo "4: Specify fourth printer option. (optional)"
	echo "5: Specify fifth printer option. (optional)"
	echo "6: Specify sixth printer option. (optional)"
	echo "7: Specify seventh printer option. (optional)"
	echo "8: Specify eighth printer option. (optional)"
	echo "9: Specify ninth printer option. (optional)"
	echo "c: Name of the Apple Developer ID Installer certificate being used to sign the payload-free package. Certificate name should be formatted like 'Developer ID Installer: Your Name' or 'Developer ID Installer: Your Name (F487797D)'. (optional)"
	echo ""
}

while getopts n:l:d:a:p:1:2:3:4:5:6:7:8:9:c: option
do
        case $option in
                n)
					printerqueue=${OPTARG};
					FLAG=false;
					if [ -z "${printerqueue}" ]; then
						ERR=true
						MSG="$MSG | Please make sure to enter a printer queue name. Queue name cannot have spaces."
					fi
					;;
                l)
					location=${OPTARG}
					if [ -z "${location}" ]; then
						ERR=true
						MSG="$MSG | Please make sure to enter the location of the printer."
					fi
					;;
				d)
					gui_display_name=${OPTARG}
					FLAG=false;
					if [ -z "${location}" ]; then
						ERR=true
						MSG="$MSG | Please make sure to enter a display name for the printer."
					fi
					;;
                a)
					address=${OPTARG}
					FLAG=false;
					if [ -z "${address}" ]; then
						ERR=true
						MSG="$MSG | Please make sure to enter the address URL for the printer. "
					fi
					;;
				p)
					driver_ppd=${OPTARG}
					FLAG=false;
					if [ -z "${driver_ppd}" ]; then
						ERR=true
						MSG="$MSG | Please make sure to enter the driver file in /Library/Printers/PPDs/Contents/Resources/. This can be either a relative path or the full path (starting with /Library). "
					fi
					;;
                1)
					option_1=${OPTARG}
					if [ -z "${option_1}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option."
					fi
					;;
                2)
					option_2=${OPTARG}
					if [ -z "${option_2}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option."
					fi
					;;
                3)
					option_3=${OPTARG}
					if [ -z "${option_3}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option."
					fi
					;;
                4)
					option_4=${OPTARG}
					if [ -z "${option_4}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option."
					fi
					;;
                5)
					option_5=${OPTARG}
					if [ -z "${option_5}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option"
					fi
					;;
                6)
					option_6=${OPTARG}
					if [ -z "${option_6}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option"
					fi
					;;
                7)
					option_7=${OPTARG}
					if [ -z "${option_7}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option"
					fi
					;;
                8)
					option_8=${OPTARG}
					if [ -z "${option_8}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option"
					fi
					;;
                9)
					option_9=${OPTARG}
					if [ -z "${option_9}" ]; then
						ERR=true
						MSG="$MSG | Please enter the desired printer option"
					fi
					;;
				c)
					signing_cert=${OPTARG}
					if [ -z "${signing_cert}" ]; then
						ERR=true
						MSG="$MSG | Please make sure to enter the name of your Apple Developer ID Installer certificate. Certificate name should be formatted like 'Developer ID Installer: Your Name' or 'Developer ID Installer: Your Name (F487797D)'"
					fi
					;;
				\?) echo "Unknown option: -$OPTARG" >&2; phelp; exit 1;;
        		:) echo "Missing option argument for -$OPTARG" >&2; phelp; exit 1;;
        		*) echo "Unimplemented option: -$OPTARG" >&2; phelp; exit 1;;
        esac
done

if [ -z "${printerqueue}" ]; then
    echo ""
	echo ">> PROBLEM << : Please make sure to enter a printer queue name using the -n option. Displaying script options below."
    echo ""
	phelp
	exit 1
fi

if [ -z "${gui_display_name}" ]; then
    echo ""
	echo ">> PROBLEM << : Please make sure to enter a display name for the printer with the -d parameter. Displaying script options below."
    echo ""
	phelp
	exit 1
fi

if [ -z "${address}" ]; then
    echo ""
	echo ">> PROBLEM << : Please make sure to enter the address URL for the printer with the -a parameter. Displaying script options below."
    echo ""
	phelp
	exit 1
fi

if [ -z "${driver_ppd}" ]; then
    echo ""
	echo ">> PROBLEM << : Please make sure to enter the driver file for the printer with the -p parameter. Displaying script options below."
    echo ""
	phelp
	exit 1
fi

# Display the options which have been selected for creating the printer

echo ""
echo "You have chosen the following printer configuration options:"
echo ""

if [[ "${printerqueue}" != "" ]]; then
    echo "Printer Queue Name:  ${printerqueue}" 
fi

if [[ "${location}" != "" ]]; then
    echo "Printer Location:  ${location}" 
fi

if [[ "${gui_display_name}" != "" ]]; then
    echo "Printer Display Name:  ${gui_display_name}" 
fi

if [[ "${address}" != "" ]]; then
     echo "Printer Address:  ${address}" 
fi

if [[ "${driver_ppd}" != "" ]]; then
    echo "Printer Driver:  ${driver_ppd}" 
fi

if [[ "${option_1}" != "" ]]; then
     echo "Additional Printer Option:  ${option_1}" 
fi

if [[ "${option_2}" != "" ]]; then
    echo "Additional Printer Option:  ${option_2}" 
fi

if [[ "${option_3}" != "" ]]; then
    echo "Additional Printer Option:  ${option_3}" 
fi

if [[ "${option_4}" != "" ]]; then
   echo "Additional Printer Option:  ${option_4}" 
fi

if [[ "${option_5}" != "" ]]; then
   echo "Additional Printer Option:  ${option_5}" 
fi

if [[ "${option_6}" != "" ]]; then
   echo "Additional Printer Option:  ${option_6}" 
fi

if [[ "${option_7}" != "" ]]; then
   echo "Additional Printer Option:  ${option_7}" 
fi

if [[ "${option_8}" != "" ]]; then
   echo "Additional Printer Option:  ${option_8}" 
fi

if [[ "${option_9}" != "" ]]; then
   echo "Additional Printer Option:  ${option_9}" 
fi

echo "Printer Sharing:  Disabled"

if [[ "${signing_cert}" != "" ]]; then
   echo "The payload-free package will be signed with the following certificate:  ${signing_cert}"
fi
echo ""

#Creating the payload-free package script

if [[ -d /tmp/"${printerqueue}" ]]; then
    rm -rf /tmp/"${printerqueue}"
fi

# Create build directories for the payload-free package

mkdir -p /tmp/"${printerqueue}"/scripts
mkdir -p /tmp/"${printerqueue}"/nopayload

if [[ "${option_1}" != "" ]]; then
   add_option1="-o \"${option_1}\" "
fi

if [[ "${option_2}" != "" ]]; then
    add_option2="-o \"${option_2}\" "
fi

if [[ "${option_3}" != "" ]]; then
    add_option3="-o \"${option_3}\" "
fi

if [[ "${option_4}" != "" ]]; then
    add_option4="-o \"${option_4}\" "
fi

if [[ "${option_5}" != "" ]]; then
    add_option5="-o \"${option_5}\" "
fi

if [[ "${option_6}" != "" ]]; then
    add_option5="-o \"${option_6}\" "
fi

if [[ "${option_7}" != "" ]]; then
    add_option5="-o \"${option_7}\" "
fi

if [[ "${option_8}" != "" ]]; then
    add_option5="-o \"${option_8}\" "
fi

if [[ "${option_9}" != "" ]]; then
    add_option5="-o \"${option_9}\" "
fi


# Create postinstall script

postinstall=/tmp/"${printerqueue}"/scripts/postinstall

touch "$postinstall"
echo "#!/bin/bash" >> "$postinstall"
echo "" >> "$postinstall"
echo "# This payload-free package will configure a printer with the following options:" >> "$postinstall"
echo "" >> "$postinstall"
if [[ "${printerqueue}" != "" ]]; then
    echo "# Printer Queue Name:  ${printerqueue}"  >> "$postinstall"
fi

if [[ "${location}" != "" ]]; then
    echo "# Printer Location:  ${location}"  >> "$postinstall"
fi

if [[ "${gui_display_name}" != "" ]]; then
    echo "# Printer Display Name:  ${gui_display_name}"  >> "$postinstall"
fi

if [[ "${address}" != "" ]]; then
    echo "# Printer Address:  ${address}"  >> "$postinstall"
fi

if [[ "${driver_ppd}" != "" ]]; then
    echo "# Printer Driver:  ${driver_ppd}"  >> "$postinstall"
fi

if [[ "${option_1}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_1}"  >> "$postinstall"
fi

if [[ "${option_2}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_2}"  >> "$postinstall"
fi

if [[ "${option_3}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_3}"  >> "$postinstall"
fi

if [[ "${option_4}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_4}"  >> "$postinstall"
fi

if [[ "${option_5}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_5}"  >> "$postinstall"
fi

if [[ "${option_6}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_6}"  >> "$postinstall"
fi

if [[ "${option_7}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_7}"  >> "$postinstall"
fi

if [[ "${option_8}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_8}"  >> "$postinstall"
fi

if [[ "${option_9}" != "" ]]; then
    echo "# Additional Printer Option:  ${option_9}"  >> "$postinstall"
fi

echo "# Printer Sharing:  Disabled"  >> "$postinstall"
echo "" >> "$postinstall"
echo "# Remove existing printer queue if one exists." >> "$postinstall"
echo "/usr/sbin/lpadmin -x ${printerqueue}" >> "$postinstall"
echo "" >> "$postinstall"
echo "# Add new printer queue with the specified options" >> "$postinstall"
echo "/usr/sbin/lpadmin -E -p \"${printerqueue}\" -L \"${location}\" -D \"${gui_display_name}\" -v \"${address}\" -P \"${driver_ppd}\" -o \"printer-is-shared=false\" ${add_option1}${add_option2}${add_option3}${add_option4}${add_option5}${add_option6}${add_option7}${add_option8}${add_option9}-E" >> "$postinstall"

# Set script to be executable

/bin/chmod a+x "$postinstall"

pkgid="com.github.create_${printerqueue}_printer"
pkgvers=$(date +"%Y.%j.%H.%s")

if [[ -z "${signing_cert}" ]]; then
    pkgbuild --identifier "${pkgid}" --version "${pkgvers}" --root /tmp/"${printerqueue}"/nopayload --scripts /tmp/"${printerqueue}"/scripts /tmp/"${printerqueue}"/"Create ${gui_display_name} Printer.pkg"
else
    pkgbuild --identifier "${pkgid}" --version "${pkgvers}" --root /tmp/"${printerqueue}"/nopayload --scripts /tmp/"${printerqueue}"/scripts --sign "${signing_cert}" /tmp/"${printerqueue}"/"Create ${gui_display_name} Printer.pkg"
fi

open /tmp/"${printerqueue}"