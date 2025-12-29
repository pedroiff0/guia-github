# SonarCloud (Guia do GitHub)

## O que é

SonarCloud é o serviço em nuvem da SonarSource para análise contínua da qualidade e segurança do código, integrado diretamente ao GitHub por meio de GitHub Actions. Como um serviço gerenciado, o SonarCloud executa análises estáticas que identificam bugs, vulnerabilidades, code smells e duplicações, fornece métricas (cobertura, complexidade, duplicação) e aplica Quality Gates sem a necessidade de infraestrutura própria. Ele suporta muitas linguagens e é otimizado para rodar análises em pushs e em pull requests usando a Action oficial do GitHub.

## Para que serve

- Identificar problemas de qualidade e segurança no código antes que cheguem à produção.
- Rastrear dívida técnica ao longo do tempo e medir melhorias.
- Aplicar regras e padrões de qualidade (linguagem-agnóstica, com plugins para muitas linguagens).
- Integrar com CI/CD para análise automática em cada build.

## Principais funcionalidades

- Análises estáticas de código (bugs, vulnerabilidades, smells).
- Métricas (cobertura, duplicação, complexidade, etc.).
- Regras configuráveis e plugins.
- Painéis e relatórios históricos.
- Integração com ferramentas de build e pipelines.

## Pré-requisitos

- Repositório no GitHub (público ou privado).
- Conta em SonarCloud (https://sonarcloud.io) conectada ao GitHub.
- Permissões de administrador na organização/repositório para instalar o SonarCloud GitHub App (recomendado) ou criar `Secrets` para tokens.
- Para usar tokens em workflows: crie um token em SonarCloud (My Account > Security > Tokens) e salve-o como `SONAR_TOKEN` no GitHub Secrets.

## Configuração rápida no SonarCloud

Siga estes passos para começar a usar SonarCloud com seu repositório GitHub:

1. Acesse https://sonarcloud.io e clique em **Sign in with GitHub**. Autorize a aplicação e escolha a organização do GitHub que contém o repositório.
2. No SonarCloud, clique em **Analyze new project** e selecione o repositório a ser analisado.
3. Conecte via **GitHub App** (recomendado) para provisionamento automático de projetos e PR decoration. Como alternativa, gere um token em *My Account > Security > Tokens* e configure-o como `SONAR_TOKEN` no GitHub Secrets.
4. Siga as instruções para configurar o projeto (por exemplo, `sonar-project.properties`) ou use a configuração automática para Maven/Gradle/Node quando disponível.
5. Adicione o workflow do GitHub Actions (exemplos na seção abaixo) para executar a análise em pushes e pull requests.

## Como analisar um projeto (exemplos)

1. Gere um token de análise em SonarCloud (My Account > Security > Tokens) ou prefira instalar o SonarCloud GitHub App para integração automática e PR decoration.

2. Exemplos de execução:

- Maven

```bash
mvn sonar:sonar \
	-Dsonar.projectKey=my-project \
	-Dsonar.host.url=https://sonarcloud.io \
	-Dsonar.login=<SEU_TOKEN>
```

- Gradle

```bash
./gradlew sonarqube \
	-Dsonar.host.url=https://sonarcloud.io \
	-Dsonar.login=<SEU_TOKEN>
```

- SonarScanner CLI (genérico)

```bash
sonar-scanner \
	-Dsonar.projectKey=my-project \
	-Dsonar.sources=. \
	-Dsonar.host.url=https://sonarcloud.io \
	-Dsonar.login=<SEU_TOKEN>
```

- Projetos JavaScript/TypeScript (ex.: usando `sonarqube-scanner` ou `sonar-scanner` instalado localmente)

```bash
npm install -g sonarqube-scanner
sonar-scanner -Dsonar.projectKey=my-js -Dsonar.sources=./src -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=<SEU_TOKEN>
```

## Integração com CI/CD

- Adicione a etapa de análise após a compilação/testes no pipeline.
- Armazene o token do SonarCloud como segredo (ex.: `SONAR_TOKEN`) no provider de CI e use-o nas variáveis de ambiente.
- Exemplos de integração: GitHub Actions, GitLab CI, Azure Pipelines, Jenkins (cada um tem runners e plugins recomendados).

Exemplo simplificado (GitHub Actions):

```yaml
- name: SonarQube Scan
	run: mvn sonar:sonar -Dsonar.host.url=${{ secrets.SONAR_URL }} -Dsonar.login=${{ secrets.SONAR_TOKEN }}
```

## Dicas rápidas de troubleshooting (SonarCloud)

- Token inválido / permissão negada: verifique se `SONAR_TOKEN` está correto ou se o GitHub App está instalado com permissão de leitura para o repositório.
- Repositório não aparece ao importar: confirme que a conta GitHub autorizada tem acesso à organização/repositório.
- Análise não é executada no workflow: confira o trigger do workflow e se o passo SonarCloud está presente após a build/test.
- PR decoration não aparece: verifique se o SonarCloud GitHub App está instalado e autorizado; para tokens, confirme permissões.
- Projeto privado: SonarCloud permite análise de projetos privados mediante plano; projetos open-source públicos são gratuitos.
- Erros de análise: veja os logs do passo do GitHub Actions para mensagens do scanner e ajuste `sonar-project.properties` ou parâmetros do scanner conforme necessário.

## Recursos e boas práticas

- Usar SonarCloud como um serviço gerenciado e instalar o GitHub App para maior integração.
- Usar análise em PRs/MRs para bloquear mudanças que reduzam a qualidade.
- Ajustar regras, quality gates e regras por time/projeto para refletir prioridades.

---

Conteúdo preparado para este repositório: guia rápido do SonarCloud com foco na integração via GitHub e exemplos de GitHub Actions.

## Uso com GitHub Actions

Para SonarCloud, use a Action oficial `SonarSource/sonarcloud-github-action` e prefira integrar com o GitHub via GitHub App.

Observações:
- Instale o SonarCloud GitHub App para PR decoration e provisionamento automático de projetos.
- Armazene `SONAR_TOKEN` como secret se escolher usar token em vez do GitHub App.
- Configure a execução em `push` e `pull_request` para analisar branches e PRs e aplicar Quality Gates.

### Exemplo (SonarCloud - Maven/Gradle)

```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up JDK 11
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '11'
      - name: Build
        run: mvn -B -DskipTests package
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@v2
        with:
          args: >-
            -Dsonar.login=${{ secrets.SONAR_TOKEN }}
```

### Exemplo (SonarCloud - Node.js)

```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm test
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@v2
        with:
          args: >-
            -Dsonar.login=${{ secrets.SONAR_TOKEN }}
```

Se precisar usar `sonar-scanner` diretamente, instale-o no runner e execute `sonar-scanner` passando `-Dsonar.login=${{ secrets.SONAR_TOKEN }}`.

