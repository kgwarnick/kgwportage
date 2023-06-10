# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="IFD PC/SC driver for Reiner SCT Cyberjack card reader"
HOMEPAGE="https://www.reiner-sct.com/"
SRC_URI="https://support.reiner-sct.de/downloads/LINUX/V3.99.5_SP15/pcsc-cyberjack_3.99.5final.SP15.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/pcsc-cyberjack-3.99.5final.SP15"

inherit linux-info

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_pretend() {
	linux-info_get_any_version
	local CONFIG_CHECK="~USB_SERIAL_CYBERJACK"
	check_extra_config
}
