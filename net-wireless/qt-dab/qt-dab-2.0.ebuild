# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Software DAB/DAB+ decoder"
HOMEPAGE="https://github.com/JvanKatwijk/qt-dab"
SRC_URI="https://github.com/JvanKatwijk/qt-dab/archive/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtlsdr hackrf sdrplay airspy"

S="${WORKDIR}/${PN}-${P}"

DEPEND=">=x11-libs/qwt-5.2.3
	>=media-libs/libsndfile-1.0.28
	>=sci-libs/fftw-3.3.6_p2
	>=media-libs/portaudio-19_pre20140130
	>=media-libs/faad2-2.7
	>=media-libs/libsamplerate-0.1.9
	>=dev-libs/libusb-1.0.21
	>=dev-qt/qtopengl-5.9.4
	>=dev-qt/qtnetwork-5.9.4
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
	)
	cmake-utils_src_configure
}
