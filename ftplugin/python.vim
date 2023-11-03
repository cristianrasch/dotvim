setlocal tabstop=4 softtabstop=4 shiftwidth=4

let b:ale_fixers = ['black', 'isort']
let b:ale_linters = ['pylsp', 'ruff']
let b:ale_python_isort_options = '--profile black'
let b:ale_python_ruff_options = '--ignore E902'

au User asyncomplete_setup call asyncomplete#ale#register_source({
    \ 'name': 'python',
    \ 'linter': 'pylsp',
    \ })
