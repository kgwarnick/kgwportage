# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Software DAB/DAB+ decoder"
HOMEPAGE="https://github.com/JvanKatwijk/qt-dab"
SRC_URI="https://github.com/JvanKatwijk/qt-dab/archive/refs/tags/6.5Beta.tar.gz -> qt-dab-6.5_beta.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="rtlsdr rtltcp hackrf sdrplay-v2 sdrplay-v3 airspy soapysdr qtaudio fdk-aac"

S="${WORKDIR}/qt-dab-6.5Beta/qt-dab-s6"

DEPEND=">=x11-libs/qwt-6.2.0-r3
	>=media-libs/libsndfile-1.2.2-r2
	>=sci-libs/fftw-3.3.10
	>=media-libs/portaudio-19.07.00-r2
	!fdk-aac? ( >=media-libs/faad2-2.11.1 )
	fdk-aac? ( >=media-libs/fdk-aac-2.0.3 )
	>=media-libs/libsamplerate-0.2.2
	>=virtual/libusb-1-r2
	>=dev-qt/qtopengl-5.15.12
	>=dev-qt/qtnetwork-5.15.12-r1
	>=x11-libs/qwt-6.2.0-r3
	rtlsdr? ( >=net-wireless/rtl-sdr-0.6.0_p2020802 )
	sdrplay-v2? ( >=net-wireless/sdrplay-2.13.1-r1 )
	sdrplay-v3? ( >=net-wireless/sdrplay-3.07.1 )
	airspy? ( >=net-wireless/airspy-1.0.10 )
	soapysdr? ( >=net-wireless/soapysdr-0.8.1 )"

RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/bin"
		$(usex rtlsdr "-DRTLSDR_LINUX=ON" "-URTLSDR_LINUX")
		$(usex rtltcp "-DRTLTCP=ON" "-URTLTCP")
		$(usex hackrf "-DHACKRF=ON" "-UHACKRF")
		$(usex sdrplay-v2 "-DSDRPLAY_V2=ON" "-USDRPLAY_V2")
		$(usex sdrplay-v3 "-DSDRPLAY_V3=ON" "-USDRPLAY_V3")
		$(usex airspy "-DAIRSPY=ON" "-UAIRSPY")
		$(usex qtaudio "-DQT_AUDIO=ON" "-UQT_AUDIO")
		$(usex fdk-aac "-DFDK_AAC=ON" "-UFDK_AAC")
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc ../README.md
	dodoc ../docs/manual-6.pdf
}
