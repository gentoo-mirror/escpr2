Gentoo escpr2 overlay
=====================

This repository
---------------

The name of this repository is **EPSON ESC/P-R2 Inkjet Printer repository**, in short **escpr2**.

For the owners of certain Epson printers the open source **ESC/P-R Printer Driver 2 for Linux** will enable printing with CUPS, the Common Unix Printing System. While the [`net-print/epson-inkjet-printer-escpr`](https://packages.gentoo.org/packages/net-print/epson-inkjet-printer-escpr) package is in the official Gentoo [portage](https://wiki.gentoo.org/wiki/Portage) tree, `net-print/epson-inkjet-printer-escpr2` is not.

A complete list of supported printers is in the `./ppd` directory of the source file, among them are e.g. certain Epson WorkForce and EcoTank series printers.

The ebuild will download the files directly from Epson. Because Epson removes old versions upon release of a new one, **older ebuilds will not work** unless you already obtained the required files and have them available in your [distfiles](https://wiki.gentoo.org/wiki/DISTDIR) directory.

Please note that Epson releases the driver unter the LGPL-2.1 and an EULA, which is a **limited license** for **personal and internal business use!**

Brief history
-------------

The full history can be read in [Gentoo Bug #662364](https://bugs.gentoo.org/662364). In short: Because an ebuild for `net-print/epson-inkjet-printer-escpr2` was missing, an existing ebuild already written by Mike Gilbert (floppym) was updated.

How to add the repository
-------------------------

### eselect-repository

This is the prefered method.

    eselect repository enable escpr2

Running `emerge --sync escpr2` will sync only this repository. To remove it, simply use `disable` in the above command.

### repos.conf

This is the manual method. Just copy `escpr2.conf` to `/etc/portage/repos/` and suit it to your needs, e.g. using nano:

    wget https://gitlab.com/at.gentoo.repo/epson-inkjet-printer-escpr2/-/raw/master/escpr2.conf -O /etc/portage/repos.conf/escpr2.conf
    nano /etc/portage/repos.conf/escpr2.conf

Especially the `location` field must be customized, but disabling `auto-sync` could also be an interesting option for those who don't want to get regular updates.

How to add the license
----------------------

The `EPSON-EULA` must be an accepted license. After reading it, you may add it to your `make.conf`. Please consult the [Gentoo Wiki on make.conf](https://wiki.gentoo.org/wiki//etc/portage/make.conf#ACCEPT_LICENSE) on how to do that.

How to install the printer driver
---------------------------------

There are two packages available: the source tarball and the binary package. Both originate from Epson directly.

### net-print/epson-inkjet-printer-escpr2

This is the preferred ebuild. It downloads the publicly available sources from Epson.

    emerge -a net-print/epson-inkjet-printer-escpr2

### net-print/epson-inkjet-printer-escpr2-bin

The binary package and the source ebuild cannot be installed at the same time. Also, the binary ebuild requires `ACCEPT_KEYWORDS=~amd64` or `ACCEPT_KEYWORDS=~x86`. Use it only if you have problems with the source package.

    emerge -a net-print/epson-inkjet-printer-escpr2-bin

Bugs
----

Only bugs (and enhancements or suggestions) concerning the ebuilds should be reported to [Gentoo Bug #662364](https://bugs.gentoo.org/662364). Problems with the driver must be reported upstream.

Resources
---------

- <https://bugs.gentoo.org/662364>
- <https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX>
- <https://wiki.archlinux.org/index.php/CUPS/Printer-specific_problems#Epson>
- <https://aur.archlinux.org/packages/epson-inkjet-printer-escpr2/>
