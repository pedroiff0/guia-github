#!/usr/bin/env bash
# Simple local validator for commit messages: use for testing before push
pattern='^(feat|fix|docs|style|refactor|perf|test|chore|ci)(\([a-z0-9._-]+\))?: .{1,150}$'
invalid=0
for sha in "$@"; do
  subject=$(git log --format=%s -n 1 "$sha")
  echo "Verificando commit $sha: $subject"
  # Pular commits de merge
  if echo "$subject" | grep -qE "^Merge"; then
    echo "Pulando commit de merge: $subject"
    continue
  fi
  if [ -z "$subject" ]; then
    echo "INVÁLIDO: assunto vazio para $sha"
    invalid=1
    continue
  fi
  if ! echo "$subject" | grep -Eq "$pattern"; then
    echo "INVÁLIDO: $subject"
    invalid=1
  fi
done
if [ "$invalid" -ne 0 ]; then
  echo "Um ou mais commits não seguem o padrão Conventional Commits"
  exit 1
fi

echo "Todos os assuntos de commit verificados são válidos."