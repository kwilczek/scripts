#!/bin/bash
#
# Author: Kamil Wilczek
# Date: 19 may 2015
#
# This script creates a simple output for 256 color
# terminals (only foreground). The palette preview
# is available at Wikpedia:
# http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg

# Output file (current directory) and text.
OFILE='xterm256_colors_test.sh'
OFILE_COLORS='terminal_256_colors'
OTEXT='Sed ut perspiciatis unde omnis iste natus error sit voluptatem...'

# Clearing the contents from previous runs.
if [ -e $OFILE ] || [ -e $OFILE_COLORS ]
then
	> $OFILE
	> $OFILE_COLORS
fi

# Bang!
echo -e '#!/bin/bash\n' | tee --append $OFILE $OFILE_COLORS &> /dev/null
echo -e "\necho -e \"" | tee --append $OFILE &> /dev/null

# \x1b is a control character changing behaviour of the shell.
# It is also the <Ctrl+V><Esc> sequence.
for i in {016..255}; do
	echo -e "\x1b[38;5;${i}m $OTEXT $i \x1b[0m" >> $OFILE
	echo -e "color${i}=\"\[\033[38;5;${i}m\]\"" >> $OFILE_COLORS
done

# End of echo.
echo '"' | tee --append $OFILE &> /dev/null

# The file should be executable.
chmod +x $OFILE
