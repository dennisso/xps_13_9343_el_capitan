#!/bin/bash

if [ ! -d /Volumes/EFI ]; then
	echo "Mounting EFI volume"
	sudo mkdir -p /Volumes/EFI
	sudo mount -t msdos /dev/disk0s1 /Volumes/EFI
fi

if [ -d /Volumes/EFI/EFI/CLOVER/ACPI/origin ]; then
	echo "Copying raw ACPI aml"
	mkdir -p raw
	cp /Volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT*.aml raw/.
	cp /Volumes/EFI/EFI/CLOVER/ACPI/origin/DSDT.aml raw/.
fi

if [ -d raw ]; then
	iasl -da -dl -fe raw/refs.txt raw/*.aml
	echo "Moving decompiled dsl to raw_decompiled"
	mkdir -p raw_decompiled
	mv raw/*.dsl raw_decompiled/.
fi