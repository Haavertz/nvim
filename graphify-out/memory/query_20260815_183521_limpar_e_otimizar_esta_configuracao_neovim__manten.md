---
type: "query"
date: "2026-08-15T18:35:21.456232+00:00"
question: "Limpar e otimizar esta configuracao Neovim, mantendo Live Server e Flash, e decidir Blink versus nvim-cmp"
contributor: "graphify"
outcome: "useful"
source_nodes: ["start_jdtls()", "M.setup_install_commands()", "format_java_file()"]
---

# Q: Limpar e otimizar esta configuracao Neovim, mantendo Live Server e Flash, e decidir Blink versus nvim-cmp

## Answer

A configuracao foi simplificada, Oil e mini.icons foram removidos, Treesitter migrou para a API atual, Blink foi mantido com matcher Rust, LSP e Mason ficaram lazy com PATH corrigido, Java permaneceu separado no nvim-jdtls, e Live Server e Flash ficaram intocados.

## Outcome

- Signal: useful

## Source Nodes

- start_jdtls()
- M.setup_install_commands()
- format_java_file()