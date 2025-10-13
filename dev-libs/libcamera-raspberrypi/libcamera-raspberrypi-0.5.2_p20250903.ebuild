# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

PYTHON_COMPAT=( python3_{13,14})
inherit python-any-r1

DESCRIPTION="libcamera (Raspberry Pi fork)"
HOMEPAGE="https://github.com/raspberrypi/libcamera"
SRC_URI="https://github.com/raspberrypi/libcamera/releases/download/v0.5.2%2Brpt20250903/libcamera-0.5.2+rpt20250903.tar.xz -> ${PF}.tar.xz"

LICENSE="libcamera-20200626"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="cam gstreamer doc"

DEPEND="!dev-libs/libcamera
	>=dev-python/ply-3.11 >=dev-python/pyyaml-6.0
	>=dev-libs/libpisp-1.2.1
	>=dev-python/pybind11-1.12.0
	cam? ( dev-libs/libevent )
	gstreamer? ( media-libs/gstreamer media-libs/gst-plugins-base dev-libs/glib )"
# TODO "ipa? || ( gnutls openssl )"
RDEPEND="${DEPEND}"
BDEPEND=""

# PATCHES="${FILESDIR}/docdir-renamed-to-pkgname.patch"

S="${WORKDIR}/libcamera-0.5.2"

src_configure() {
	local emesonargs=(
		"-Dbuildtype=release"
		"-Dpipelines=rpi/vc4,rpi/pisp"
		"-Dipas=rpi/vc4,rpi/pisp"
		"-Dv4l2=enabled"
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

src_install() {
	meson_src_install
	python_optimize
}
