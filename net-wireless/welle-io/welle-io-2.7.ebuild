# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A DAB/DAB+ Software Radio"
HOMEPAGE="https://www.welle.io/"
SRC_URI="https://github.com/AlbrechtL/welle.io/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtlsdr"

S="${WORKDIR}/welle.io-${PV}"

DEPEND=">=dev-qt/qtquickcontrols2-5.15.17
	>=dev-qt/qtcharts-6.9.3
	>=dev-qt/qtwidgets-5.15.17
	>=dev-qt/qtmultimedia-5.15.17
	rtlsdr? ( >=net-wireless/rtl-sdr-2.0.2-r1 )
	>=sci-libs/fftw-3.3.10
	>=media-libs/faad2-2.11.1"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DRTLSDR="$(usex rtlsdr 1 0)"
	)
	cmake_src_configure
}
