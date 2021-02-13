#!/usr/bin/env -S awk -f

# Print all lines longer than 80 characters long
# This doesn't work perfectly with tabs, but it is still useful

length($0) > 80 {
	printf("%s\t\t\t%s\n", FILENAME, $0)
}