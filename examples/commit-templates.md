# Modelos e exemplos de commit messages

## Resumo rápido
Use este arquivo para copiar modelos ao criar commits. Inclui exemplos para `type`, `scope`, `subject`, `body` e `footer`.

### Simples
- `feat(storage): adicionar uploader para S3`
- `fix(api): tratar resposta vazia`
- `docs: atualizar README com exemplo de uso`

### Com scope e subject
- `feat(auth): adicionar rotação de tokens`
- `fix(cli): evitar crash com argumentos vazios`

### Com corpo (quando necessário)
```
feat(cli): adicionar comando exportar

Adiciona o comando `export` para gerar a cópia da configuração em JSON.
Útil para debug e para integração com CI.

Closes #45
```

### Footer e referências
- `Closes #<issue>` fecha automaticamente a issue quando a PR for mergeada.
- `Refs: #<issue>` para referência sem fechamento.

### Breaking Change
```
refactor!: remover middleware de autenticação legado

BREAKING CHANGE: a assinatura do middleware mudou; clientes devem atualizar.
```
ou usando footer
```
feat(api): remover formato de paginação legado

BREAKING CHANGE: os clientes devem usar o novo parâmetro `page` em vez de `cursor`.
```

### Sequência de commits em uma feature (exemplo)
1. `feat(api): adicionar endpoint de paginação`
2. `test(api): adicionar testes para paginação`
3. `docs: adicionar exemplos de uso da paginação`
4. `chore: atualizar versão`

### Revert (exemplo)
```
revert: revert "feat(cli): adicionar comando exportar"

Reverte o commit 1234abcd.
```

---

## Como usar esses modelos
- Copie o modelo que mais se aproxima do seu caso e adapte o `scope` e o `subject`.
- Mantenha mensagens curtas no cabeçalho e coloque explicações no `body` quando necessário.
- Se estiver em dúvida, prefira criar commits atômicos e use o PR para agrupar as mudanças.
