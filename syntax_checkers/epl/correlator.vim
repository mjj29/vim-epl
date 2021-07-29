

if exists('g:loaded_syntastic_epl_correlator_checker')
	finish
endif
let g:loaded_syntastic_epl_correlator_checker = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:syntastic_epl_correlator_src')
	let g:syntastic_epl_correlator_src=fnamemodify(findfile("root.xpybuild.py", ".;"), ":p:h:h")."/apama-src"
endif

if !exists('g:syntastic_epl_correlator_executable')
	if has('win32')
		let g:syntastic_epl_correlator_executable=g:syntastic_epl_correlator_src . '\output-amd64-win-release\test-tools\bin\testInterpreter.exe'
	else
		let g:syntastic_epl_correlator_executable=g:syntastic_epl_correlator_src . '/output-amd64-rhel8-release/test-tools/bin/testInterpreter'
	endif
endif

if !exists('g:syntastic_epl_correlator_options')
	if has('win32')
		let g:syntastic_epl_correlator_options='-l '. g:syntastic_epl_correlator_src .'\..\apama-test\tools\output-amd64-win-release\apwork\license\ApamaServerLicense.xml'
	else
		let g:syntastic_epl_correlator_options='-l '. g:syntastic_epl_correlator_src .'/../apama-test/tools/output-amd64-rhel8-release/apwork/license/ApamaServerLicense.xml'
	endif
endif

function! SyntaxCheckers_epl_correlator_IsAvailable() dict "{{{1
	return executable(expand(g:syntastic_epl_correlator_executable, 1))
endfunction " }}}1

function! SyntaxCheckers_epl_correlator_GetLocList() dict " {{{1
	let fname = expand('%:p:h', 1) . syntastic#util#Slash().expand('%:t', 1)
	let makeprg = self.makeprgBuild({
		\ 'args_before': g:syntastic_epl_correlator_options,
		\ 'exe': g:syntastic_epl_correlator_executable,
		\ 'fname': syntastic#util#shescape(fname) })

	" TODO
	let errorformat = 
		\ '%.%# ERROR %.%# - %f: Error on line %l: %m'

	if has('win32')
		let env = { 'PATH': g:syntastic_epl_correlator_src . '\output-amd64-win-release\SoftwareAG\Apama\bin;'. g:syntastic_epl_correlator_src .'\..\apama-lib5\branched\win\amd64\10.11.0.x\saginstallation\jvm\jvm\bin\server', 'APAMA_HOME':g:syntastic_epl_correlator_src.'\output-amd64-win-release\SoftwareAG\Apama'  }
	else
		let env = { 'LD_LIBRARY_PATH': g:syntastic_epl_correlator_src . '/output-amd64-rhel8-release/SoftwareAG/Apama/lib:'. g:syntastic_epl_correlator_src .'/../apama-lib5/branched/linux/amd64/10.11.0.x/saginstallation/jvm/jvm/lib/server', 'APAMA_HOME':g:syntastic_epl_correlator_src.'/output-amd64-rhel8-release/SoftwareAG/Apama'  }
	endif

	let errors = SyntasticMake({
		\ 'makeprg': makeprg,
		\ 'errorformat': errorformat,
		\ 'env': env })

	return errors

endfunction " }}}1

call g:SyntasticRegistry.CreateAndRegisterChecker({
	\ 'filetype': 'epl',
	\ 'name': 'correlator' })


let &cpo = s:save_cpo
unlet s:save_cpo
