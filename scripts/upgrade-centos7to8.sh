#!/bin/bash
#
# https://www.tecmint.com/upgrade-centos-7-to-centos-8/
#
yum install epel-release -y
yum install yum-utils

yum install rpmconf -y
rpmconf -a

package-cleanup --leaves
package-cleanup --orphans

yum install dnf -y
dnf -y remove yum yum-metadata-parser
rm -Rf /etc/yum
dnf upgrade -y

dnf -y install http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-repos-8.2-2.2004.0.1.el8.x86_64.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-release-8.2-2.2004.0.1.el8.x86_64.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-gpg-keys-8.2-2.2004.0.1.el8.noarch.rpm
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

dnf clean all
rpm -e `rpm -q kernel`
rpm -e --nodeps sysvinit-tools

dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync
dnf -y install kernel-core
dnf -y groupupdate "Core" "Minimal Install"
cat /etc/redhat-release
