# Projects

- Estrutura recomendada: Backlog → To do → In progress → Review → Done.

- **Automations úteis**:
  - Mover issue para "In progress" quando uma PR vinculada estiver em progresso.
  - Mover cartão para "Done" quando a PR for merged.
  - Adicionar labels automaticamente com `labeler` quando PR/issue é criada.

- **Campos sugeridos**: `priority` (low/med/high), `effort` (S/M/L), `owner`.

- **Como configurar rapidamente**:
  1. Crie o Project (Projects → New project).
  2. Adicione colunas conforme a estrutura acima.
  3. Em Project Settings → Automation, adicione regras para mover cards com PR/issue events.

- **Integração**: vincule Issues e PRs diretamente no Project para visibilidade e rastreabilidade.

> Dica: use Projects como fonte única de verdade (single source of truth) para o roadmap e mantenha pequenos intervalos de grooming semanalmente.