# Abrir PR de exemplo

1. Crie uma branch: `git checkout -b feature/example-pr`
2. Altere `README.md` com uma linha de teste e `git add` + `git commit` seguindo Conventional Commits: `chore: example PR for testing workflows`
3. Push e abra a PR no GitHub para a branch `feature/example-pr` → `main`.
4. Verifique a execução do workflow `CI` e confira labels atribuídas automaticamente.

Esse fluxo serve para validar CI, labeler e templates em ambiente real.