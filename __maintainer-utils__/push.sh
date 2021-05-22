#!/usr/bin/env sh

# Easily push changes to both repositories

github="git@github.com:MCBE-Speedrunning/Speedrunning-Rulebook.git"
gitea="https://git.mcbe.wtf/MCBE-Speedrunning/Speedrunning-Rulebook.git"

repos=$(git remote)
if ! echo $repos | grep 'github' >/dev/null; then
	git remote add github $github
fi

if ! echo $repos | grep 'gitea' >/dev/null; then
	git remote add gitea $gitea
fi

git push gitea
git push github
