#!/bin/bash
# TODO read passwords from a database and read a var to set the extraction path
IFS=$'\n'  # make newlines the only separator
LIST=$(find . -type f -name '*.*' | sed 's|.*\.||' | sort -u)
PASSWORDS=$'www.mega-dvdrip.com\nvsacaba\nwww.bajarpelisgratis.com'
filepath="/path/to/data/inflating"
status_file=""


	for i in $LIST; do
	echo "Archivo=$i"
	declare -a files=$(find . -iname "*.$i" -type f -exec basename {} \;)
	echo "${files[@]}"

		for pass in $PASSWORDS; do

			for infile in ${files[@]} ; do
				echo
				echo "Testing file ${infile} with password ${pass}"
				7z -p"$pass" t "${infile}"
				status_file=$?
				if [ "${status_file}" -eq 0 ]; then
					if [[  ${#files[@]} > 0 ]]; then
						echo "Password ${pass} ok then extracting ...."
						7z -y -aoa -p"$pass" -o"$filepath" e ${infile}
						echo
						echo "=====================  Success ====================="
						echo
						declare -a patter=( ${files[@]/$infile/} )
						files=("${patter[@]}")
					else
						echo
					echo "=================  files extracted ==================="
						echo
					fi
		    else
					echo "$pass is not working with ${infile}"
		      echo
		      echo "========================  Fail ======================="
					echo
		    fi
			done
		done
	done;
