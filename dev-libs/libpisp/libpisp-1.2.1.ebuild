# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Helper library to generate run-time configuration for the Raspberry Pi ISP"
HOMEPAGE="https://github.com/raspberrypi/libpisp"
SRC_URI="https://github.com/raspberrypi/libpisp/archive/refs/tags/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm"
# TODO IUSE="+logging examples"

DEPEND=">=dev-cpp/nlohmann_json-3.11.2"
RDEPEND="${DEPEND}"
BDEPEND=""
