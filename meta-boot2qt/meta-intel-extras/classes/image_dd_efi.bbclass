############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:GPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
############################################################################

DESCRIPTION = "Extends image_dd class to boot via GRUB-EFI and initramfs."
LICENSE = "CLOSED"

inherit image_dd

EXTRA_IMAGECMD_ext3 += "-L rootfs"

do_populate_boot() {
    GRUB_IMAGE="grub-efi-bootia32.efi"
    DEST_IMAGE="bootia32.efi"
    if [ "${TARGET_ARCH}" = "x86_64" ]; then
        GRUB_IMAGE="grub-efi-bootx64.efi"
        DEST_IMAGE="bootx64.efi"
    fi

    mkdir -p ${WORKDIR}/EFI/BOOT/
    # Path where EFI firmware searches for EFI executable
    cp ${DEPLOY_DIR_IMAGE}/${GRUB_IMAGE} ${WORKDIR}/EFI/BOOT/${DEST_IMAGE}
    mcopy -s -i ${WORKDIR}/boot.img ${WORKDIR}/EFI ::/EFI
}
