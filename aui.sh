#!/usr/bin/bash

if [[ ! $(type fzf 2>/dev/null) ]]; then
  echo -e "Required utility \033[1mfzf\033[0m was not found. You can find instructions for installing it at \033[4mhttps://github.com/junegunn/fzf\033[0m."
elif [[ ! $(type yq 2>/dev/null) ]]; then
  echo -e "Required utility \033[1myq\033[0m was not found. You can find instructions for installing it at \033[4mhttps://mikefarah.github.io/yq/\033[0m."
else
  dict_key="$(yq eval 'keys' aui.yaml | sed 's/^- //' | fzf)"
  echo "\$(yq eval ".${dict_key}" aui.yaml)"

  dict_def="$(yq eval ".${dict_key}" aui.yaml)"

  echo
  echo "${dict_key}:"
  echo "${dict_def}"
  echo
fi
