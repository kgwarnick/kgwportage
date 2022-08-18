# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A DAB/DAB+ Software Radio"
HOMEPAGE="https://www.welle.io/"
SRC_URI="https://github.com/AlbrechtL/welle.io/archive/V1.0-rc3.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtlsdr"

S="${WORKDIR}/welle.io-1.0-rc3"

DEPEND=">=dev-qt/qtquickcontrols2-5.9.3
	>=dev-qt/qtcharts-5.9.3
	>=dev-qt/qtwidgets-5.9.3
	>=dev-qt/qtmultimedia-5.9.3
	rtlsdr? ( >=net-wireless/rtl-sdr-0.5.3 )
	>=sci-libs/fftw-3.3.6
	>=media-libs/faad2-2.7"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DRTLSDR="$(usex rtlsdr 1 0)"
	)
	cmake_src_configure
}
