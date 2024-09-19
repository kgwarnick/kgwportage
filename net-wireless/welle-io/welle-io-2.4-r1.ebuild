# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A DAB/DAB+ Software Radio"
HOMEPAGE="https://www.welle.io/"
SRC_URI="https://github.com/AlbrechtL/welle.io/archive/refs/tags/v2.4.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtlsdr"

S="${WORKDIR}/welle.io-${PV}"

DEPEND=">=dev-qt/qtquickcontrols2-5.9.3:5
	>=dev-qt/qtcharts-5.15.8:5
	>=dev-qt/qtwidgets-5.15.8:5
	>=dev-qt/qtmultimedia-5.15.8:5
	rtlsdr? ( >=net-wireless/rtl-sdr-0.6.0 )
	>=sci-libs/fftw-3.3.10
	>=media-libs/faad2-2.10"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DRTLSDR="$(usex rtlsdr 1 0)"
	)
	cmake_src_configure
}
