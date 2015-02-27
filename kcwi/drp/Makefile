prefix		= ~/kcwi/pipeline/releases
srcdir		= ~/idl
kcwidata	= ${srcdir}/data/kcwi
cwidata		= ${srcdir}/data/cwi
libsrc		= ${srcdir}/libs
utils		= ${srcdir}/util
math		= ${srcdir}/math
plot		= ${srcdir}/plot
spec		= ${srcdir}/spec

RELEASE := $(shell grep KCWI kcwi_drp_version.pro | awk '{print $$4}')

reldir		= ${prefix}/kderp-$(RELEASE)

auxdir		= ${reldir}/aux
datadir		= ${reldir}/data
libsdir		= ${reldir}/libs
cwidir		= ${reldir}/cwi
kcwidir		= ${reldir}/kcwi
stddir		= ${datadir}/stds

KCWI_FILES = $(shell ls kcwi*.pro)

CWI_FILES = $(shell ls cwi*.pro)

AUX_FILES = $(shell ls *.pro | grep -v cwi)

dist:
	mkdir $(reldir)
	mkdir $(kcwidir)
	mkdir $(auxdir)
	mkdir $(datadir)
	mkdir $(libsdir)
	mkdir $(cwidir)
	mkdir $(stddir)
	cp $(KCWI_FILES) $(kcwidir)
	cp $(AUX_FILES) $(auxdir)
	cp $(utils)/filestamp.pro $(auxdir)
	cp $(utils)/timestr.pro $(auxdir)
	cp $(utils)/struct_init.pro $(auxdir)
	cp $(math)/ccpeak.pro $(auxdir)
	cp $(math)/cntrd1d.pro $(auxdir)
	cp $(math)/djs_iterstat.pro $(auxdir)
	cp $(math)/djs_median.pro $(auxdir)
	cp $(math)/fan.pro $(auxdir)
	cp $(math)/fillarr.pro $(auxdir)
	cp $(math)/ims.pro $(auxdir)
	cp $(math)/ims_asym.pro $(auxdir)
	cp $(math)/mystats.pro $(auxdir)
	cp $(math)/pascal_shift.pro $(auxdir)
	cp $(math)/pkfind.pro $(auxdir)
	cp $(math)/polyfit.pro $(auxdir)
	cp $(math)/robust_mean.pro $(auxdir)
	cp $(math)/sign.pro $(auxdir)
	cp $(math)/splinefit.pro $(auxdir)
	cp $(plot)/psfile.pro $(auxdir)
	cp $(plot)/psclose.pro $(auxdir)
	cp $(plot)/get_plotlims.pro $(auxdir)
	cp $(spec)/rdfits1dspec.pro $(auxdir)
	cp $(spec)/gaussfold.pro $(auxdir)
	cp $(spec)/wavetopx.pro $(auxdir)
	cp $(spec)/peaks.pro $(auxdir)
	cp $(spec)/isopeaks.pro $(auxdir)
	cp $(spec)/clnpeaks.pro $(auxdir)
	cp /Users/neill/uoft/idl/util/internal/deepcolor.pro $(auxdir)
	cp /Users/neill/uoft/idl/util/internal/colordex.pro $(auxdir)
	cp $(kcwidata)/thar.fits $(datadir)
	cp $(kcwidata)/thar_list.txt $(datadir)
	cp $(kcwidata)/stds/*.fit* $(stddir)
	cp -r $(libsrc)/astrolib $(libsdir)
	cp -r $(libsrc)/buie $(libsdir)
	cp -r $(libsrc)/mpfit $(libsdir)
	cp $(CWI_FILES) $(cwidir)
	cp $(cwidata)/allhdr.txt $(cwidir)
	cp $(cwidata)/hdrfix_example.txt $(cwidir)
	cp $(srcdir)/kcwi/drp/AAAREADME $(reldir)
	cp $(srcdir)/kcwi/drp/CWI_README $(reldir)
	cp $(srcdir)/kcwi/drp/RELEASE_NOTES $(reldir)
	cp $(srcdir)/kcwi/drp/DATA_PRODUCTS $(reldir)
	cp $(srcdir)/kcwi/startup.pro $(reldir)
	(cd $(prefix); tar cvf kderp-$(RELEASE).tar ./kderp-$(RELEASE); gzip kderp-$(RELEASE).tar)

clean:
	rm -rf $(reldir)

distclean: clean
	rm -rf $(prefix)/kderp-$(RELEASE).tar.gz

# CVS Info:
# $Id: Makefile,v 1.18 2015/01/24 01:08:30 neill Exp $
