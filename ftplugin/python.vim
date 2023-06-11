setlocal tabstop=4 softtabstop=4 shiftwidth=4

let b:ale_fixers = ['black', 'isort', 'ruff']
let b:ale_linters = ['ruff']
" let b:ale_linters = ['flake8']
let b:ale_python_isort_options = '--profile black'
