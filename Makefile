# Copyright (C) 2002, 2003 John Goerzen
# <jgoerzen@complete.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; version 2 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
clean:
	-python2.2 setup.py clean --all
	-rm -f `find . -name "*~"`
	-rm -f `find . -name "*.pyc"`
	-rm -f `find . -name "*.pygc"`
	-rm -f `find . -name "*.class"`
	-rm -f `find . -name "*.bak"`
	-rm -f `find . -name ".cache*"`
	-find . -name auth -exec rm -vf {}/password {}/username \;
	-svn cleanup

changelog:
	svn log -v > ChangeLog

docs:
	docbook2man pygopherd.sgml
	docbook2man pygopherd.sgml
	docbook2html -u pygopherd.sgml
	mv pygopherd.html manual.html
	man -t -l pygopherd.8 > manual.ps
	ps2pdf manual.ps
	groff -Tascii -man pygopherd.8 | sed $$'s/.\b//g' > manual.txt
	-rm manpage.links manpage.refs
