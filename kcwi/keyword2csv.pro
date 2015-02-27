; $Id: keyword2csv.pro,v 1.3 2014/10/27 15:37:30 neill Exp $
; KCWI utility routine
pro keyword2csv,ifile,ofile
;+
;	parse a KTL keyword configuration file into a csv file
;-
pre='KEYWORD2CSV'
;
; check inputs
if n_params(0) lt 2 then begin
	print,pre,' Usage - keyword2csv,<KeywordInFile>,<csvOutFile>'
	return
endif
;
; test input file
if not file_test(ifile,/read) then begin
	print,pre,' Error file not found: ',ifile
	return
endif
;
; open output file
filestamp,ofile,/verbose
openw,ol,ofile,/get_lun
;
; open input file
openr,il,ifile,/get_lun
rec=''
;
; loop over input file records
while not eof(il) do begin
	;
	; read record
	readf,il,rec
	;
	; set up output record
	kw = ''
	type = ''
	acc = ''
	value = ''
	units = ''
	remark = ''
	;
	; check for comment
	if strmid(rec,0,1) eq '#' then begin
		jnk = gettok(rec,' ')
		orec = rec + ',,,,'
	endif else begin
		kw   = gettok(rec,' ')
		local= gettok(rec,' ')
		if strpos(rec,'val=') gt 0 then begin
			str = strmid(rec,strpos(rec,'val='))
			jnk = gettok(str,'"')
			value = gettok(str,'"')
		endif
		if strpos(rec,'units=') gt 0 then begin
			str = strmid(rec,strpos(rec,'units='))
			jnk = gettok(str,'"')
			units = gettok(str,'"')
		endif
		if strpos(rec,'remark=') gt 0 then begin
			str = strmid(rec,strpos(rec,'remark='))
			jnk = gettok(str,'"')
			remark = gettok(str,'"')
			remark = repchr(remark,',',';')
		endif
		while strlen(rec) gt 0 do begin
			val = gettok(rec,' ')
			key = gettok(val,'=')
			case strlowcase(strtrim(key,2)) of
				'type': type = val
				'access': acc = val
				else:
			endcase
		endwhile
		orec = kw+','+type+' '+acc+','+value+','+units+','+remark
	endelse
	printf,ol,orec
endwhile	; loop over keywords (i=0,nk-1)
;
; close file
free_lun,ol
return
end
