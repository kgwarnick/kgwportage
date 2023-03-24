# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Software DAB/DAB+ decoder"
HOMEPAGE="https://github.com/JvanKatwijk/qt-dab"
SRC_URI="https://github.com/JvanKatwijk/qt-dab/archive/refs/tags/4.4.2.tar.gz -> qt-dab-4.4.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="rtlsdr hackrf sdrplay airspy tryepg qtaudio"

S="${WORKDIR}/${P}/dab-maxi"

DEPEND=">=x11-libs/qwt-6.1.4
	>=media-libs/libsndfile-1.2.0
	>=sci-libs/fftw-3.3.10
	>=media-libs/portaudio-19.07.00-r2
	>=media-libs/faad2-2.10.1
	>=media-libs/libsamplerate-0.1.9-r1
	>=virtual/libusb-1-r2
	>=dev-qt/qtopengl-5.15.8
	>=dev-qt/qtnetwork-5.15.8
	>=x11-libs/qwt-6.1.5
	rtlsdr? ( >=net-wireless/rtl-sdr-0.6.0 )"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/bin"
		$(usex rtlsdr "-DRTLSDR=ON" "-URTLSDR")
		$(usex rtlsdr "-DRTLTCP=ON" "-URTLTCP")
		$(usex hackrf "-DHACKRF=ON" "-UHACKRF")
		$(usex sdrplay "-DSDRPLAY=ON" "-USDRPLAY")
		$(usex airspy "-DAIRSPY=ON" "-UAIRSPY")
		$(usex tryepg "-DTRY_EPG=ON" "-UTRY_EPG")
		$(usex qtaudio "-DQT_AUDIO=ON" "-UQT_AUDIO")
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc ../README.md
	dodoc ../docs/manual.pdf
}
