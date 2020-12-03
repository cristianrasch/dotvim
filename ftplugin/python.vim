setlocal tabstop=4 softtabstop=4 shiftwidth=4

let b:ale_python_auto_pipenv = 1
let b:python_black_auto_pipenv = 1
let b:python_flake8_auto_pipenv = 1
let b:python_isort_use_global = 1

let b:ale_fixers = ['black', 'isort']
let b:ale_linters = ['flake8']
