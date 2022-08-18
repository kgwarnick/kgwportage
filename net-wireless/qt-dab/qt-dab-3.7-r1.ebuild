# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Software DAB/DAB+ decoder"
HOMEPAGE="https://github.com/JvanKatwijk/qt-dab"
SRC_URI="https://github.com/JvanKatwijk/qt-dab/archive/3,7.tar.gz -> qt-dab-3.7.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="rtlsdr hackrf sdrplay airspy tryepg qtaudio"

S="${WORKDIR}/qt-dab-3-7/dab-maxi"

DEPEND=">=x11-libs/qwt-6.1.4
	>=media-libs/libsndfile-1.0.30
	>=sci-libs/fftw-3.3.8-r1
	>=media-libs/portaudio-19.06.00-r1
	>=media-libs/faad2-2.9.0
	>=media-libs/libsamplerate-0.1.9-r1
	>=dev-libs/libusb-1.0.23-r1
	>=dev-qt/qtopengl-5.15.2
	>=dev-qt/qtnetwork-5.15.2-r1
	rtlsdr? ( >=net-wireless/rtl-sdr-0.5.3 )"

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
	dodoc ../docs/qt-dab.pdf
}
