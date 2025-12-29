# Exemplos 'in-loco' no GitHub

Este documento explica como testar os exemplos do repositório diretamente na interface do GitHub.

## Testar workflows
- Vá em **Actions** → selecione `Manual actions` → clique **Run workflow** para executar o exemplo manual.
- Abra uma PR para `main` com mudanças em `README.md` e veja `CI` rodar automaticamente.

## Testar templates de issue/PR
- Criar uma issue usando os templates em **Issues → New issue → Choose a template**.
- Abrir uma PR usando o template em `.github/PULL_REQUEST_TEMPLATE.md` e certificar que o checklist e labels são aplicados.

## Testar automações
- Abra uma PR com um arquivo `docs/*` e veja o `Auto Labeler` atribuir `docs`.
- Deixe uma issue sem atividade por 30 dias para ver o bot `Stale` atuar (pode forçar via `workflow_dispatch`).
