##
##  Makefile -- Top-level build procedure for www.openssl.org
##

# Used to have a hack with a lockfile.
# Not needed since this is fast now.

SNAP=/v/openssl/checkouts/openssl
PODSHOME=$(SNAP)/doc

FORCE=#-f

DIRS= about docs news source support

all: simple manpages

simple: generated
	wmk $(FORCE) -I $(SNAP) -a $(DIRS) index.wml

manpages:
	sh ./run-pod2html.sh $(PODSHOME)

generated:
	perl run-changelog.pl <$(SNAP)/CHANGES >news/changelog.inc
	perl run-faq.pl <$(SNAP)/FAQ >support/faq.inc
	perl run-fundingfaq.pl < support/funding/support-faq.txt >support/funding/support-faq.inc
	cp $(PODSHOME)/HOWTO/*.txt docs/HOWTO/.
	( cd news && xsltproc vulnerabilities.xsl vulnerabilities.xml > vulnerabilities.wml )
