# Maintainer: zoorat <zoorat [at] protonmail [dot] com>
# Contributor: Thomas Wood <grand.edgemaster@gmail.com>

pkgname=ttf-twemoji-color
pkgver=15.1.0
pkgrel=1

pkgdesc="A color and B&W emoji SVG-in-OpenType font by Twitter with support for ZWJ, skin tone modifiers and country flags."
arch=('any')
url="https://github.com/13rac1/twemoji-color-font"
license=('custom:CCPL:by-4.0' 'MIT')

optdepends=('ttf-bitstream-vera: default fallback font used for configuration')
provides=('emoji-font' 'twemoji-color-font')

changelog="changelog.md"
install=ttf-twemoji-color.install

source=("${url}/releases/download/v${pkgver}/TwitterColorEmoji-SVGinOT-Linux-${pkgver}.tar.gz")
b2sums=('c9b36fd314cbfc163fcd585d8fc2535fc2dc3a86cbf67af14223243baabe8ecb66a3600afcb0d274482eb18f69983e8f011b689afc3926799a2c429395599224')

package() {
	cd TwitterColorEmoji-SVGinOT-Linux-${pkgver}
	install -Dm644 TwitterColorEmoji-SVGinOT.ttf -t "$pkgdir"/usr/share/fonts/twemoji-color-font/
	install -Dm644 LICENSE* -t "$pkgdir"/usr/share/licenses/$pkgname/
	install -Dm644 README.md "$pkgdir"/usr/share/doc/$pkgname/README
	install -Dm644 fontconfig/46-twemoji-color.conf "$pkgdir"/usr/share/fontconfig/conf.avail/46-$pkgname.conf
}
