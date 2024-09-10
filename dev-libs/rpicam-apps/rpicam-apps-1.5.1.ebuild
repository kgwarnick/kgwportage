# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="libcamera-based command line apps"
HOMEPAGE="https://github.com/raspberrypi/rpicam-apps"
SRC_URI="https://github.com/raspberrypi/rpicam-apps/archive/refs/tags/v1.5.1.tar.gz -> ${PF}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="libav +drm egl qt5 opencv tflite"

DEPEND=">=dev-libs/libcamera-raspberrypi-0.3.1
	x11-libs/libdrm
	egl? ( media-libs/libepoxy )
	libav? ( media-video/ffmpeg )
	virtual/jpeg
	media-libs/tiff
	media-libs/libpng
	media-libs/libexif
	dev-libs/boost
	qt5? ( >=dev-qt/qtcore-5.15:5 >=dev-qt/qtgui-5.15:5 >=dev-qt/qtwidgets-5.15:5 )"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES="${FILESDIR}/postprocstages-meson-includedir-core.patch"

src_configure() {
	local emesonargs=(
		$(meson_feature libav "enable_libav")
		$(meson_feature drm "enable_drm")
		$(meson_feature egl "enable_egl")
		$(meson_feature qt5 "enable_qt")
		$(meson_feature opencv "enable_opencv")
		$(meson_feature tflite "enable_tflite")
	)
	meson_src_configure
}
