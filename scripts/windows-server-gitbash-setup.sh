#!/usr/bin/env bash
# Run in Git Bash on the Windows server after Git for Windows is installed.
# No secrets in this file. First clone uses Git Credential Manager (browser sign-in typical).

set -euo pipefail

git config --global user.name "Baqer-Marayati"
git config --global user.email "Baqer-Marayati@users.noreply.github.com"

mkdir -p /c/Work
cd /c/Work

if [[ -d reporting-hub ]]; then
  echo "reporting-hub exists — pulling latest."
  cd reporting-hub
  git pull origin main
else
  git clone https://github.com/Baqer-Marayati/reporting-hub.git
  cd reporting-hub
fi

git status
git log -1 --oneline

printf '\nOpen in Power BI Desktop:\n  C:\\Work\\reporting-hub\\Reports\\Finance\\Financial Report\\Financial Report.pbip\n'
