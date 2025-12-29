# Snyk (Guia do GitHub)

## O que é

Snyk é uma plataforma de segurança de código e de dependências que ajuda a encontrar e corrigir vulnerabilidades em dependências (SCA), código aberto e imagens de container. Snyk oferece integração nativa com o GitHub (GitHub App e Actions) para detectar problemas automaticamente em pushes e pull requests, além de monitorar projetos ao longo do tempo.

## Para que serve

- Identificar vulnerabilidades em dependências e código (SAST e SCA).
- Detectar problemas em imagens de container e infra-as-code.
- Bloquear merges que introduzam vulnerabilidades via PR checks/Status checks.
- Monitorar projetos continuamente e gerar relatórios de impacto.

## Principais funcionalidades

- Testes locais com `snyk test` (dependências, Docker, infra-as-code).
- Monitoramento contínuo com `snyk monitor` (cria snapshots no Snyk para rastreamento de regressões).
- Integração com GitHub via GitHub App (recomendado) para análise automática e PR decoration.
- GitHub Actions oficiais para testes e monitoramento durante CI.
- Correções automatizadas via PRs (dependabot-style) quando disponíveis.

## Pré-requisitos

- Repositório no GitHub (público ou privado).
- Conta no Snyk (https://snyk.io) e vínculo com o GitHub (Sign in with GitHub) ou criação de token (My Account > API Tokens).
- Permissão para instalar o Snyk GitHub App na organização/repositório ou adicionar `SNYK_TOKEN` no GitHub Secrets.

## Configuração rápida no Snyk + GitHub

1. Acesse https://snyk.io e faça **Sign in with GitHub**; autorize o Snyk GitHub App para a organização/repositório.
2. No painel do Snyk, importe o repositório para começar a monitorá‑lo (opção automática via GitHub App).
3. Para integração em CI com tokens, gere um API Token em *Account settings > API token* e salve como `SNYK_TOKEN` em **Secrets** do GitHub.
4. Adicione um workflow do GitHub Actions para executar `snyk test`/`snyk monitor` em push e pull_request (exemplos abaixo).

## Como testar localmente

- Instale o CLI (npm):

```bash
npm install -g snyk
snyk auth # cole o token gerado em https://app.snyk.io/account
```

- Testar dependências do projeto (Node.js, Maven, Gradle etc.):

```bash
snyk test
```

- Monitorar e enviar snapshot para o Snyk (gera projeto no dashboard):

```bash
snyk monitor
```

- Testar imagens Docker:

```bash
snyk container test <imagem>
```

## Uso com GitHub Actions (exemplos)

> Observação: prefira instalar o **Snyk GitHub App** para integração automática e PR decoration; use `SNYK_TOKEN` em `Secrets` se necessário.

### Exemplo (Node.js - Snyk Test + Monitor)

```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Node
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Install
        run: npm ci
      - name: Run tests
        run: npm test
      - name: Snyk Test
        uses: snyk/actions/node@master
        with:
          args: test
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      - name: Snyk Monitor
        uses: snyk/actions/node@master
        with:
          args: monitor
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

### Exemplo (Container scan)

```yaml
name: Container scan
on: [push]
jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build image
        run: docker build -t my-app:${{ github.sha }} .
      - name: Snyk Container Test
        uses: snyk/actions/docker@master
        with:
          args: test my-app:${{ github.sha }}
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

### Exemplo (Monitor via CLI em workflow genérico)

```yaml
- name: Snyk Monitor
  run: |
    npm install -g snyk
    snyk auth ${{ secrets.SNYK_TOKEN }}
    snyk monitor
  env:
    SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

## Integração com CI/CD e recomendações

- Execute `snyk test` após a etapa de build/test para verificar vulnerabilidades antes de publicar.
- Use `snyk monitor` para enviar snapshots e acompanhar histórico de vulnerabilidades no painel do Snyk.
- Configure status checks (branch protection) para bloquear merges quando certas severidades forem detectadas.
- Armazene `SNYK_TOKEN` como secret no GitHub ao usar o token (evite expor tokens em logs).

## Dicas rápidas de troubleshooting

- `snyk auth` falha: verifique se o token está correto e se o token tem permissões suficientes.
- Falso positivo/aviso: verifique a descrição e, se necessário, ignore com justificativa usando policy ou ignore rules.
- Erros de rate limit/API: aguarde ou contate suporte; para grandes orgs, considere plano empresarial.
- Projetos privados: verifique o plano do Snyk (projetos open-source públicos têm opções gratuitas).

## Recursos e boas práticas

- Instale o **Snyk GitHub App** para uma integração mais simples e PR decoration.
- Rodar testes em PRs e proteger branches com status checks do Snyk.
- Habilitar monitoramento contínuo para detectar regressões.
- Priorizar correções por severidade e impacto no projeto.

---

Conteúdo preparado para este repositório: guia rápido do Snyk com foco na integração via GitHub Actions e uso do CLI.