# Branching strategies

Recomendações:

- Trunk-based: branches curtas por feature e merge contínuo para `main` via PR.
- Git-flow: use quando for preciso um processo de release formal (mais complexo).

Nomenclatura sugerida:
- `feature/<ticket>-desc`  
- `fix/<ticket>-desc`  
- `hotfix/<...>`

Proteção de branch: exigir PR review, checks e signed commits quando necessário.
