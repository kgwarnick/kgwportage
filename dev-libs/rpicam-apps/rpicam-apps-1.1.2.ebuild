# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="libcamera-based command line apps"
HOMEPAGE="https://github.com/raspberrypi/rpicam-apps"
SRC_URI="https://github.com/raspberrypi/rpicam-apps/archive/refs/tags/v1.1.2.tar.gz -> ${PF}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="drm X qt5"

DEPEND="|| ( dev-libs/libcamera dev-libs/libcamera-raspberrypi )
	virtual/jpeg media-libs/tiff
	dev-libs/boost
	X? ( media-libs/libepoxy )
	qt5? ( >=dev-qt/qtcore-5.15:5 >=dev-qt/qtgui-5.15:5 >=dev-qt/qtwidgets-5.15:5 )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		$(usex drm "-DENABLE_DRM=1" "-DENABLE_DRM=0")
		$(usex X "-DENABLE_X11=1" "-DENABLE_X11=0")
		$(usex qt5 "-DENABLE_QT=1" "-DENABLE_QT=0")
	)
	cmake_src_configure
}
