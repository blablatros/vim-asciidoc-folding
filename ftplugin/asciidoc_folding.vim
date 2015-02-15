function! AsciiDocFold(lnum)
	let current_line = getline(a:lnum)

	if current_line =~ '\v^[=#]+\s.+$'
		" line is a heading
		" asciidoctor allows # for headings as well
		let b:blank_level = '1'
		return '>1'
	elseif current_line =~ '\v%(TIP|NOTE|IMPORTANT|WARNING|CAUTION):\s.*$'
		" inline admonition
		return '10'
	elseif current_line =~ '\v\[.+\]$'
		" block opening
		" WARNING: will match special heading types (e.g. glossary, floating, etc.)
		" not a problem unless set fml=0
		return '>10' " nested blocks will not work!
	elseif current_line =~ '\v^--|[-+/.*_=]{4,}$'
		" multi-paragraph block, opening|closing
		" WARNING: will match 2-line headings
		if b:blank_level =~ '1' " opening
			let b:blank_level = '10'
		elseif b:blank_level =~ '10' " closing
			let b:blank_level = '1'
		endif
		return '10'
	elseif current_line =~ '\v^//.*$'
		" line is a comment
		return '20'
	elseif current_line =~? '\v^\s*$'
		" line is blank
		return b:blank_level
	else
		" return same as previous
		" WARNING: coments can be glued with other paragraphs
		return '='
	endif
endfunction

setlocal foldexpr=AsciiDocFold(v:lnum)
setlocal foldmethod=expr
