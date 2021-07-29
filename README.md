# vim-epl

This repository contains syntax hilighting for the Software AG Apama EPL language. This is used in the Cumulocity IoT product to provide streaming analytics services.

It can be installed using the Plugged plugin manager. Just add this to your .vimrc:

	call plug#begin('~/.vim/plugged')
	Plug 'mjj29/vim-epl'
	call plug#end()

It will be active for any `.mon` or `.evt` files.

Also included is an extension to the Syntastic plugin to do compilation with EPL and show you errors. Currently this is only available for Apama internal developers. To enable it, add the following to your .vimrc:

	let g:syntastic_epl_checkers=['correlator']
	" optional, will automatically detect if CWD is under apama-src or apama-test
	let g:syntastic_epl_correlator_src='/path/to/apama-src'
