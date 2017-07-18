# Payload-Free Package Printer Generator

This script is designed to generate payload-free packages, where the package's embedded script uses the `lpadmin` command to create printers with a pre-set configuration.

Usage: `/path/to/payload-free_package_printer_generator.sh -n -l -d -a -p -1 -2 -3 -4 -5 -6 -7 -8 -9 -c`

Options:

* **-n**: Name of the print queue. May not contain spaces, tabs, # or / characters. (**required**)
* **-l**: The physical location of the printer. Examples may include `Reception Desk`, `Librarian's Office` or `Second Floor, Room 2C456` (optional)
* **-d**: The printer name which is displayed in the **Printers & Scanners** pane of System Preferences, as well as in the print dialogue boxes. (**required**)
* **-a**: The IP or DNS address of the printer. Protocol must be specified as the address (for example, use `lpd://ip.address.goes.here` or `lpd://dns.address.goes.here` for LPR printing.) (**required**)
* **-p**: Name of the driver file in `/Library/Printers/PPDs/Contents/Resources/`. This must use the full path to the drive (starting with `/Library`). (**required**)
* **-1**: Specify first printer option. (optional)
* **-2**: Specify second printer option. (optional)
* **-3**: Specify third printer option. (optional)
* **-4**: Specify fourth printer option. (optional)
* **-5**: Specify fifth printer option. (optional)
* **-6**: Specify sixth printer option. (optional)
* **-7**: Specify seventh printer option. (optional)
* **-8**: Specify eighth printer option. (optional)
* **-9**: Specify ninth printer option. (optional)
* **-c**: Name of the Apple Developer ID Installer certificate being used to sign the payload-free package. Certificate name should be formatted like `Developer ID Installer: Your Name` or `Developer ID Installer: Your Name (F487797D)`. (optional)

**Note:** By default, printer sharing is disabled as part of the printer configuration.

**Examples:**

To create an unsigned payload-free package using only the required printer configuration options:

`/path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz`

To create a signed payload-free package using only the required printer configuration options:

`/path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz -c "Developer ID Installer: Your Name (F487797D)"`

To create a signed payload-free package which creates a printer using a displayed name with spaces, add quotation marks to the displayed printer name:
 
`/path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d "Printer Name Goes Here" -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz  -c "Developer ID Installer: Your Name (F487797D)"`


Other flags can be added as needed:

To add one additional option to the printer configuration (in this example, a custom tray for an HP printer) and create an unsigned payload-free package:

`/path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz -1 HPOptionDuplexer=True`

 To add two additional options to the printer configuration (in this example, a custom tray for an HP printer and a specified output mode) and sign the payload-free package:

`/path/to/payload-free_package_printer_generator.sh -n PrinterQueueGoesHere -d PrinterNameGoesHere -a lpd://ip.address.goes.here -p /Library/Printers/PPDs/Contents/Resources/PrinterDriverPPDHere.gz -1 HPOptionDuplexer=True -2 OutputMode=normal -c "Developer ID Installer: Your Name (F487797D)"`



Inspired by [Nick McSpadden](https://github.com/nmcspadden)'s **PrinterGenerator** tool: [https://github.com/nmcspadden/PrinterGenerator](https://github.com/nmcspadden/PrinterGenerator)
