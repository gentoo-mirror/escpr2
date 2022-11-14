Gentoo escpr2 overlay
=====================

This repository
---------------

The name of this repository is **Epson Inkjet Printer Driver 2 (ESC/P-R)**, in short **escpr2**.

For the owners of certain Epson printers the open source **Printer Driver 2 (ESC/P-R) for Linux** or **`escpr2`** will enable printing with CUPS (Common Unix Printing System). While the [`net-print/epson-inkjet-printer-escpr`](https://packages.gentoo.org/packages/net-print/epson-inkjet-printer-escpr) package is in the official Gentoo [portage](https://wiki.gentoo.org/wiki/Portage) tree, `net-print/epson-inkjet-printer-escpr2` is not.

A complete list of supported printer series is in the `./ppd` directory of the source file, among them e.g. Epson WorkForce and EcoTank series printers. For your convenience [a list of PPDs](latest-ppd-list.txt) is compiled from the current escpr2-version.

The ebuild will download the files directly from the *Seiko Epson Corporation*. Because Epson often removes old versions upon release of a new one, **older ebuilds likely won't work** unless you already obtained the required files and have them available in your [distfiles](https://wiki.gentoo.org/wiki/DISTDIR) directory.

Please note that Epson releases the driver under the LGPL-2.1 and an EULA, which is a **limited license** for **personal and internal business use!**

**The quality of this repository is purely experimental!** You use it at your own risk! I don't do a lot of testing other than installing the source package myself and printing with it on an EcoTank series printer. Specifically this means that, currently, the binary package is not tested, nor is the escprlib useflag. Also, since I'm not a developer, should newer versions require more ebuild work, a longer delay is to be expected.

Brief history
-------------

The full history can be found in [Gentoo Bug #662364](https://bugs.gentoo.org/662364). In short: Because an ebuild for `net-print/epson-inkjet-printer-escpr2` was missing in the tree, an existing but too old ebuild already written by Mike Gilbert (floppym) was used and updated.

How to add the repository
-------------------------

Please read the Gentoo Wiki [ebuild repository](https://wiki.gentoo.org/wiki/Ebuild_repository) page before you proceed, especially section [best practices](https://wiki.gentoo.org/wiki/Ebuild_repository#Best_practices)...

### eselect-repository

This is the prefered method.

    eselect repository enable escpr2

Running `emerge --sync escpr2` will sync only this repository. To remove it, simply use `disable` in the above command.

### repos.conf

This is the manual method. Just copy `escpr2.conf` to `/etc/portage/repos.conf/` and modify it for your configuration, e.g. using your default editor:

    wget https://gitlab.com/at.gentoo.repo/epson-inkjet-printer-escpr2/-/raw/master/escpr2.conf -O /etc/portage/repos.conf/escpr2.conf
    $EDITOR /etc/portage/repos.conf/escpr2.conf

Especially the `location` field must be set correctly, but disabling `auto-sync` could also be an interesting option for those who don't want to get regular updates. Since a lot of updates only add new printer models, this could be a preferred option. Refer to [NEWS](NEWS) for version update information regarding bug fixes.

How to add the license
----------------------

The `EPSON-EULA` must be an accepted license. After reading it you may add it to your `make.conf`. Please consult the Gentoo Wiki page on [make.conf](https://wiki.gentoo.org/wiki//etc/portage/make.conf#ACCEPT_LICENSE) for more information on how to do that.

How to install the printer driver
---------------------------------

There are two packages available: the source tarball and the binary package. Both originate from Epson directly.

### net-print/epson-inkjet-printer-escpr2

This is the preferred ebuild. It downloads the publicly available sources from Epson.

    emerge -a net-print/epson-inkjet-printer-escpr2

### net-print/epson-inkjet-printer-escpr2-bin

The binary package and the source ebuild cannot be installed at the same time. Also, the binary ebuild requires [`ACCEPT_KEYWORDS`](https://wiki.gentoo.org/wiki/ACCEPT_KEYWORDS) of either `~x86` or `~amd64`. Use it only if you have problems with the source package.

    echo "net-print/epson-inkjet-printer-escpr2-bin ~amd64" >> /etc/portage/package.accept_keywords
    emerge -a net-print/epson-inkjet-printer-escpr2-bin

What to do after installation
-----------------------------

Refer to the README file in `/usr/share/doc`. In short: Add the printer to your CUPS configuration. There are mupltiple ways to do this, one of which is to navigate to ``http://localhost:631/``. When adding a new printer, select model "EPSON-ESC/P-R Printer Driver for Linux" and the correct printer series should be available for selection.

Bugs
----

Only bugs (and enhancements or suggestions) concerning the ebuilds should be reported, [Gentoo Bug #662364](https://bugs.gentoo.org/662364). Problems with the driver must be reported upstream, from ./AUTHORS in the source tarball: Seiko Epson Corporation <linux-printer@epson.jp>.

Resources
---------

- <https://wiki.gentoo.org/wiki/Printing>
- <https://bugs.gentoo.org/662364>
- <https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX>
- <https://wiki.archlinux.org/index.php/CUPS/Printer-specific_problems#Epson>
- <https://aur.archlinux.org/packages/epson-inkjet-printer-escpr2/>
