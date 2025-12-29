# Guia completo de mensagens de commit (Conventional Commits)

> Baseado na especificação **Conventional Commits** e na documentação oficial do GitHub. Este guia descreve **tipos**, **escopos**, **subject**, **body** e **footer** com exemplos e regras práticas.

## Por que usar Conventional Commits
- Automatiza changelogs e releases (semver).
- Facilita revisão, triagem de PRs e entendimento histórico do projeto.

---

## 1) Tipos (type)
O primeiro elemento do cabeçalho indica a natureza da mudança. Use um só tipo por commit.

Principais tipos e quando usá-los:
- feat: nova funcionalidade (corresponde a MINOR em SemVer)
- fix: correção de bug (PATCH)
- docs: mudanças na documentação
- style: formatação, espaçamento, etc. (sem alteração de lógica)
- refactor: alteração de código que não adiciona feature nem corrige bug
- perf: melhoria de performance
- test: adicionar/ajustar testes
- chore: tarefas de manutenção (ex.: atualização de scripts)
- ci: alterações nos workflows/CI
- build: alterações nos processos de build
- revert: revert de um commit anterior

Regra prática: mantenha tipos em minúsculas e seja consistente.

---

## 2) Escopo (scope)
- Opcional. Identifica a área do código afetada (ex.: `api`, `auth`, `cli`, `docs`).
- Deve ser um substantivo curto, sem espaços, em letras minúsculas, por exemplo: `(api)`, `(cli)`, `(tests)`.
- Use scope quando ajudar a identificar rapidamente a área impactada; omita se a mudança for transversal.

Exemplos:
- `fix(api): handle null responses`
- `feat(cli): add export command`

---

## 3) Subject (linhas do cabeçalho)
- Deve ser curto (preferencialmente até 50 caracteres), descritivo e em imperativo/presente (ex.: "adicionar", "corrigir").
- Não termine com ponto final.
- Comece com letra minúscula (consistência), mas a especificação não é case-sensitive.

Exemplos:
- `feat(auth): adicionar lógica de refresh de token`
- `docs: atualizar guia de contribuição`

---

## 4) Body (corpo)
- Opcional, mas útil quando o motivo da mudança não é óbvio.
- Deve estar separado do cabeçalho por uma linha em branco.
- Use o body para explicar **por que** a mudança foi feita, se teve trade-offs e se há passos de migração.
- Quebre linhas em ~72 caracteres para melhor legibilidade em diffs e e-mails.

Exemplo:
```
fix(storage): evitar crash em payload vazio

Verificar chaves ausentes antes de parsear. Adicionar testes para casos de borda (payload nulo, arrays vazios).
```

---

## 5) Footer (rodapé)
- Use para metadados e referências — ex.: `Closes #17`, `Refs: #23`. (Observação: para que o GitHub auto-feche issues, utilize `Closes`/`Fixes` em inglês no footer.)
- Para breaking changes, indique **BREAKING CHANGE:** seguido da descrição; alternativa: use `!` no cabeçalho (ex.: `feat(api)!:`).

Exemplos:
```
feat(auth)!: remover formato de token legado

BREAKING CHANGE: formato de token alterado; clientes devem atualizar para v2.
```
ou
```
fix(api): tratar header ausente

Closes #42
```

---

## Exemplos completos
- Commit simples:
  - `docs: atualizar exemplos no README`
- Commit com scope:
  - `feat(api): adicionar paginação por cursor`
- Commit com corpo e footer:
```
feat(storage): adicionar upload multipart para S3

Adiciona suporte para upload multipart para arquivos grandes. Adiciona testes de integração.

Closes #88
```
- Breaking change com `!`:
```
refactor!: remover suporte a autenticação legada

BREAKING CHANGE: tokens de autenticação legados não são mais aceitos.
```

---

## Quando e como corrigir mensagens
- Antes do push: `git commit --amend` para corrigir a última mensagem ou `git rebase -i` para reescrever commits locais.
- Após push (mas antes do merge): rebase interativo e `git push --force-with-lease` (use com cuidado).
- Após merge/release: prefira um novo commit de correção para evitar reescrever histórico público.

---

## Validação e automação
- Este repositório inclui um workflow que valida mensagens nas PRs: `.github/workflows/commit-message-check.yml`
- Se o check falhar, corrija as mensagens (amend/rebase) ou adicione novos commits adequados.
- Ferramentas úteis: Commitizen, Commitlint, semantic-release.

---

## Boas práticas resumidas
- Faça commits atômicos (uma alteração lógica por commit).
- Prefira `squash` ao merge para um histórico limpo, se a equipe concordar.
- Use scopes quando fizer sentido e escreva corpos claros para mudanças complexas.

---

## Referências
- Conventional Commits: https://www.conventionalcommits.org/
- GitHub — About commit messages: https://docs.github.com/en/get-started/using-git/about-commit-messages
- GitHub — Commit signature verification: https://docs.github.com/en/authentication/managing-commit-signature-verification

**Nota de idioma:** escreva o `subject`, `body` e `footer` em português; mantenha o `type` em inglês para compatibilidade com ferramentas de automação.
---

Se quiser, eu adiciono exemplos práticos de templates de `commit-msg`, `commitizen` ou um snippet de `commitlint` para CI — quer que eu inclua algum desses (sim/não)?