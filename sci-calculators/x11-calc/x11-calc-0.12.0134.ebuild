# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="Another RPN (Reverse Polish) calculator / HP calculator emulator"
HOMEPAGE="https://github.com/mike632t/x11-calc"
SRC_URI="https://github.com/mike632t/x11-calc/archive/refs/tags/v0.12.0134.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake -j1
}

src_install() {
	dobin bin/x11-calc-* bin/x11-calc.sh
	domenu bin/x11-calc.desktop
	dodoc README.md
}
