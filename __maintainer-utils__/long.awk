#!/usr/bin/env -S awk -f

# Print all lines longer than 80 characters long
# This doesn't work perfectly with tabs, but it is still useful

length > 80 { print FILENAME, "\t\t", $0 }
