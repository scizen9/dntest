;$Id: kcwi_read_raw.pro | Fri Feb 27 10:38:33 2015 -0800 | Don Neill  $
;
;+
;
;-
function kcwi_read_raw,ppar,imgno,header=header,silent=silent
	;
	; initialize
	pre = 'KCWI_READ_RAW'
	version = repstr('$Revision: v0.1.3-beta-8-ge4c27b8 $ $Date: Fri Feb 27 10:38:33 2015 -0800 $','$','')
	;
	; check input
	if kcwi_verify_ppar(ppar,/init) ne 0 then return,-1
	;
	; create file name
	fspec = ppar.rawdir + ppar.froot + $
		string(imgno,form='(i0'+strn(ppar.fdigits)+')')+'.fit*'
	flist = file_search(fspec,count=nf)
	;
	; check results
	if nf ne 1 then begin
		print,pre+': Error - file not found or ambiguous: ',imgno
		header=''
		return,-1
	endif
	im = mrdfits(flist[0],0,header,silent=silent,/unsigned)
	;
	return,im
end
