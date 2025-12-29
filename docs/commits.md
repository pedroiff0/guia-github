## Resumo rápido

- Usamos **Conventional Commits** como padrão **recomendado**: `type(scope?): subject` (ex.: `docs: add contributing guide`).
- Tipos comuns: **feat, fix, docs, style, refactor, perf, test, chore, ci**.
- O CI valida as mensagens na PR — não é obrigatório configurar hooks localmente, mas recomendamos `pre-commit` para conveniência.

## Exemplo mínimo
- `feat(cli): add release command`
- `fix(auth): handle token refresh`
- `docs: add commit message guide`

## Como validar localmente (opcional e simples)
1. Instale `pre-commit` (opcional):
   - `python -m pip install --user pre-commit`
2. Rode: `pre-commit run --all-files` (aplica apenas formatação/cheks simples, nós não forçamos commit-msg).

## Integração com o CI (implementada)
- O repositório possui um workflow (`.github/workflows/commit-message-check.yml`) que valida todas as mensagens de commit em PRs e falha o check se alguma não seguir o padrão básico.

## Fluxo recomendado
1. Crie uma branch pequena: `git checkout -b feature/<descrição>`
2. Faça commits atômicos e claros: `docs: add commit examples`
3. Abra PR e aguarde CI e review
4. Squash/rebase ao merge conforme política do projeto

## Recursos
- https://www.conventionalcommits.org/

> Simples e prático — se quiser, posso adicionar um `pre-commit` opcional que valide mensagens localmente, mas por enquanto mantemos o hook **leve** e deixamos o CI fazer a validação.