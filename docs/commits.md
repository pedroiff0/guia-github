# Commit messages e Convenções (Conventional Commits)

## Resumo rápido
Este documento descreve **Conventional Commits**, boas práticas de granularidade de commits, ferramentas (pre-commit / commit-msg hooks) e exemplos práticos para projetos em Python.

## Conventional Commits — formato
Formato básico:

```
type(scope?): short subject

[optional body]

[optional footer]
```

- **type**: feat, fix, docs, style, refactor, perf, test, chore, ci, build
- **scope** (opcional): área afetada, ex.: `cli`, `auth`, `api`
- **subject**: resumo em tempo presente e curto (<= 50 caracteres)
- **body**: explique *por que* a mudança foi feita, não apenas o *que*
- **footer**: referências para issues (`Closes #42`) ou breaking changes (`BREAKING CHANGE: ...`)

### Exemplos
- `feat(cli): add 'release' command to automate tagging`
- `fix(auth): handle token refresh error`  
- `docs: update contributing guide with commit policy`

Commit com corpo e footer:
```
fix(api): avoid crash when payload is empty

Previously we attempted to parse a missing key which caused an exception.
Now we check for existence before parsing and add tests.

Closes #17
```

## Por que usar branches aqui?
- **Isolamento**: cada feature/bugfix/documentação tem sua própria branch (ex.: `feature/docs/commits`), permitindo trabalhar sem afetar `main`.
- **Revisão**: abra uma PR da branch para `main` e peça revisão antes de merge.
- **Histórico limpo**: mantemos commits atômicos por branch; podemos optar por squash/rebase ao merge para manter `main` legível.

Recomendações de nomenclatura:
- `feature/<ticket>-descrição` ou `feat/<ticket>-descrição`
- `fix/<ticket>-descrição`
- `docs/<descrição>`

## Granularidade de commits
- Um commit = uma mudança lógica. Evite "tudo em um".
- Prefira commits pequenos (até onde tiver sentido): alteração de código, testes, docs, formatação (separados).
- Use commits de correção (fix) para bugs, `feat` para novas funcionalidades.

## Assinaturas (signed commits)
- Para segurança/atribuição, habilite GPG ou SSH-signed commits:
  - `git config --global user.signingkey <GPG_KEY_ID>`
  - `git config --global commit.gpgSign true`

## Hooks e validação automática
- Use `pre-commit` para instalar hooks localmente e validar mensagens com `validate-commit-msg`.
- Exemplo de instalação (recomendado para colaboradores):
  - `pip install pre-commit`
  - `pre-commit install --hook-type commit-msg`

Exemplo de `.pre-commit-config.yml` (ver repositório):

```yaml
repos:
  - repo: https://github.com/ejwa/validate-commit-msg
    rev: v1.0.0
    hooks:
      - id: validate-commit-msg
        stages: [commit-msg]
        args: ["--pattern", "^(feat|fix|docs|style|refactor|perf|test|chore|ci)(\\([a-z0-9_-]+\\))?:\\s.+$"]
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.0.1
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
```

### Integração com CI
- Adicione um job em CI que valida mensagens de commit nos PRs (opcional, mas útil para equipes que não exigem `pre-commit`).
- Exemplo de ação: `wagoid/commitlint-action` ou um script que executa `validate-commit-msg` contra commits do PR.

## Como escrever um bom commit message
- Comece com um **subject** curto e informativo.
- Use o **body** para explicar motivos e impacto.
- Inclua links para issues no **footer**.

## Fluxo recomendado (exemplo)
1. `git checkout -b feature/docs/commits`
2. Editar arquivos e `git add` por passo lógico
3. `git commit -m "docs: add Conventional Commits guide"`
4. `git push -u origin feature/docs/commits`
5. Abrir PR para `main`, marcar reviewers e linkar issue #2

## Recursos
- https://www.conventionalcommits.org/
- https://pre-commit.com/
- https://commitizen-tools.github.io/commitizen/
