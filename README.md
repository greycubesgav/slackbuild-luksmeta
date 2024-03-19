# slackbuild-luksmeta

Slackware Builds script to build a slackware package of the luksmeta application, require by clevis remote disk decryption

## Application description
luksmeta (tool for storing metadata in the LUKSv1 header)

LUKSMeta is a simple library for storing metadata in the LUKSv1
header.

Some projects need to store additional metadata about a LUKS volume
that is accessable before unlocking it. Two such examples are
USBGuard and Tang.

Homepage: https://github.com/latchset/luksmeta/

## Build instructions

The following instructs show how to build the package locally under Slackware.

```bash
# Clone the git repo
git clone https://github.com/greycubesgav/slackbuild-luksmeta
cd slackbuild-luksmeta
# Grab the url from the .info file and download it
wget $(sed -n 's/DOWNLOAD="\(.*\)"/\1/p' luksmeta.info)
./luksmeta.SlackBuild
# Slackware package will be created in /tmp
```

## Install instructions

Once the package is built, it can be installed with

```bash
upgradepkg --install-new --reinstall /tmp/luksmeta-*.tgz
```