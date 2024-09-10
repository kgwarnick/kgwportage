# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="libcamera (Raspberry Pi fork)"
HOMEPAGE="https://github.com/raspberrypi/libcamera"
SRC_URI="https://github.com/raspberrypi/libcamera/releases/download/v0.3.1%2Brpt20240906/libcamera-0.3.1+rpt20240906.tar.xz -> ${PF}.tar.xz"

LICENSE="libcamera-20200626"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="cam gstreamer doc"

DEPEND="!dev-libs/libcamera
	>=dev-python/ply-3.11 >=dev-python/pyyaml-6.0
	>=dev-libs/libpisp-1.0.7
	>=dev-python/pybind11-1.12.0
	cam? ( dev-libs/libevent )
	gstreamer? ( media-libs/gstreamer media-libs/gst-plugins-base dev-libs/glib )"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES="${FILESDIR}/docdir-renamed-to-pkgname.patch"

S="${WORKDIR}/libcamera-0.3.1"

src_configure() {
	local emesonargs=(
		"-Dbuildtype=release"
		"-Dpipelines=rpi/vc4,rpi/pisp"
		"-Dipas=rpi/vc4,rpi/pisp"
		"-Dv4l2=true"
		"-Dtest=false"
		"-Dlc-compliance=disabled"
		$(meson_feature gstreamer)
		$(meson_feature cam)
		"-Dqcam=disabled"
		$(meson_feature doc documentation)
		"-Ddocumentation=disabled"
		"-Dpycamera=enabled"
	)
	meson_src_configure
}
