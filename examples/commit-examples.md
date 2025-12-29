# Exemplos práticos de commits

1) Criar branch:

```bash
git checkout -b docs/commits
```

2) Commit de documentação (pequeno e atômico):

```bash
git add docs/commits.md
git commit -m "docs: add Conventional Commits guide"
```

3) Commit para adicionar config de hooks:

```bash
git add .pre-commit-config.yaml
git commit -m "chore(ci): add pre-commit configuration to validate commit messages"
```

4) Push e abrir PR:

```bash
git push -u origin docs/commits
# Open PR in GitHub and reference issue #2
```
