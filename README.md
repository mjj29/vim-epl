# vim-epl

This repository contains syntax hilighting for the Software AG Apama EPL language. This is used in the Cumulocity IoT product to provide streaming analytics services.

It can be installed using the Plugged plugin manager. Just add this to your .vimrc:

	call plug#begin('~/.vim/plugged')
	Plug 'mjj29/vim-epl'
	call plug#end()

It will be active for any `.mon` or `.evt` files.
