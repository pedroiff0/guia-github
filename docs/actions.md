# GitHub Actions — guia prático

- Use workflows pequenos e específicos (tests, lint, build, release).
- Reusable workflows: escreva jobs que possam ser chamados por outros repositórios.
- Matrix builds para testar múltiplas versões do Python.
- Cache de dependências com `actions/cache` para acelerar CI.
- Use `workflow_dispatch` para criar workflows acionáveis manualmente (úteis como exemplos 'in-loco').

Exemplo: ver `.github/workflows/ci.yml` para um pipeline básico em Python.