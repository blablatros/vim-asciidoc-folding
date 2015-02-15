function! AsciiDocFold(lnum)
	let current_line = getline(a:lnum)

	if current_line =~ '\v^[=#]+\s.+$'
		" line is a heading
		" asciidoctor allows # for headings as well
		let b:blank_level = '1'
		return '>1'
	elseif current_line =~ '^//.*$'
		" line is a comment
	elseif current_line =~ '\v%(TIP|NOTE|IMPORTANT|WARNING|CAUTION):\s.*$'
		" inline admonition
		return '10'
		return '10'
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
