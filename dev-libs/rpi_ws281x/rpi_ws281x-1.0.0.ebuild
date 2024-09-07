# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 python3_11 python3_12 python3_13 )
inherit python-any-r1 scons-utils

DESCRIPTION="Userspace Raspberry Pi PWM library for WS281X LEDs"
HOMEPAGE="https://github.com/jgarff/rpi_ws281x"
SRC_URI="https://github.com/jgarff/rpi_ws281x/archive/refs/tags/v1.0.0.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~arm ~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	escons
}

src_install() {
	dolib.a libws2811.a
	mkdir rpi_ws281x || die
	cp -p clk.h dma.h gpio.h mailbox.h pcm.h pwm.h rpihw.h version.h ws2811.h rpi_ws281x || die
	doheader -r rpi_ws281x
}
