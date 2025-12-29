#!/usr/bin/env bash
# Simple local validator for commit messages: use for testing before push
pattern='^(feat|fix|docs|style|refactor|perf|test|chore|ci)(\([a-z0-9._-]+\))?: .{1,100}$'
invalid=0
for sha in "$@"; do
  msg=$(git log --format=%B -n 1 "$sha")
  echo "Checking commit $sha: $msg"
  if ! echo "$msg" | grep -Eq "$pattern"; then
    echo "INVALID: $msg"
    invalid=1
  fi
done
if [ "$invalid" -ne 0 ]; then
  echo "One or more commits do not match Conventional Commits pattern"
  exit 1
fi

echo "All checked commit messages are valid."