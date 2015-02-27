; $Id: csv2keyword.pro,v 1.3 2014/12/18 00:19:05 neill Exp $
; KCWI utility routine
pro csv2keyword,ifile,ofile
;+
;	parse a csv file into a KTL keyword configuration file
;-
pre='CSV2KEYWORD'
;
; check inputs
if n_params(0) lt 2 then begin
	print,pre,' Usage - csv2keyword,<csvInFile>,<KeywordOutFile>'
	return
endif
;
; read in data
readcol,ifile,kw,tya,val,units,rem,format='a,a,a,a,a',delim=',',/preserve
nk = n_elements(kw)
if nk le 0 then begin
	print,pre,' Error - no keyword data in file ',ifile
	return
endif
;
; open output file
filestamp,ofile,/verbose
openw,ol,ofile,/get_lun
;
; format without units
fmtnu = '(a-16,"local ",a-12," ",a-9,"    ",a-54,a)'
;
; format with units
fmtu = '(a-16,"local ",a-12," ",a-9,"    ",a-32,a-22,a)'
;
; process header
ip = 0
repeat begin
	key = strupcase(strtrim(kw[ip],2))
	if key ne 'SERVER' and key ne '' and key ne 'KEYWORDS' then $
		service = kw[ip]
	ip += 1
endrep until strtrim(kw[ip],2) eq 'NAME'
ip += 1
;
; print header
printf,ol,'# '+service+' KEYWORD CONFIG FILE'
printf,ol,'#'
printf,ol,'# Defines keywords for KCWI '+strlowcase(service)+' server'
;
; loop over keywords
for i=ip,nk-1 do begin
	;
	; check for comment
	if strlen(strtrim(tya[i],2)) eq 0 then begin
		printf,ol,''
		printf,ol,'# '+kw[i]+' '+rem[i]
	endif else begin
		acc  = tya[i]
		type = 'type='+gettok(acc,' ')
		acc  = 'access='+acc
		value = 'val="'+strtrim(val[i],2)+'"'
		alias= 'alias="'+strtrim(rem[i],2)+'"'
		;
		if strlen(strtrim(units[i],2)) eq 0 then begin
			printf,ol,kw[i],type,acc,value,alias,format=fmtnu
		endif else begin
			unts = 'units="'+strtrim(units[i],2)+'"'
			printf,ol,kw[i],type,acc,value,unts,alias,format=fmtu
		endelse
	endelse
endfor	; loop over keywords (i=0,nk-1)
;
; close file
free_lun,ol
return
end
