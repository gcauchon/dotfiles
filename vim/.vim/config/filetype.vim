" Ruby
augroup rubyfiletype
  autocmd BufRead,BufNewFile *.ru setfiletype ruby
  autocmd BufRead,BufNewFile Gemfile setfiletype ruby
augroup END

" tmux
augroup tmuxfiletype
  autocmd BufRead,BufNewFile .tmux.conf setfiletype tmux
augroup END

" JavaScript
augroup javascriptfiletype
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript
  autocmd BufRead,BufNewFile *.js.es6 setfiletype javascript
  autocmd BufRead,BufNewFile *.json setfiletype javascript
  autocmd BufRead,BufNewFile .bowerrc setfiletype javascript
augroup END

" SASS
augroup sassfiletype
  autocmd BufRead,BufNewFile *.scss setfiletype scss
augroup END

" Elixir
augroup elixirfiletype
  autocmd BufRead,BufNewFile *.eex setfiletype html
augroup END

" Foreman
augroup foremanfiletype
  autocmd BufRead,BufNewFile Procfile setfiletype yaml
  autocmd BufRead,BufNewFile .env setfiletype sh
  autocmd BufRead,BufNewFile .env.* setfiletype sh
augroup END

" LESS
augroup lessfiletype
  au BufNewFile,BufRead *.less setlocal filetype=scss
augroup END

" Configuration
augroup conf
  autocmd BufNewFile,BufRead *.conf setfiletype conf
augroup END

