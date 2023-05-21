# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="libcamera (Raspberry Pi fork)"
HOMEPAGE="https://github.com/raspberrypi/libcamera"
SRC_URI="https://github.com/raspberrypi/libcamera/archive/refs/tags/release-v0.0.4+23-06bbff9c.tar.gz -> ${PF}.tar.gz"

LICENSE="libcamera-20200626"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="+cam gstreamer"

DEPEND="!dev-libs/libcamera
	>=dev-python/ply-3.11 >=dev-python/pyyaml-6.0
	cam? ( dev-libs/libevent )
	gstreamer? ( media-libs/gstreamer media-libs/gst-plugins-base )"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES="${FILESDIR}/docdir-renamed-to-pkgname.patch"

S="${WORKDIR}/libcamera-release-v0.0.4-23-06bbff9c"

src_configure() {
	local emesonargs=(
		$(meson_feature cam)
		$(meson_feature gstreamer)
	)
	meson_src_configure
}
