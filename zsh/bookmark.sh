#!/bin/bash

readonly BOOKMARKS_FILE=~/.local/share/snippets

## Utils 

notify() {
  # escape double quotes
  msg=$(echo $1 | sed -e 's/"/\\"/g')

  /usr/bin/osascript -e "display notification \"$msg\" with title \"Bookmark Manager\""
}

input() {
  # escape double quotes
  default=$(echo $2 | sed -e 's/"/\\"/g')
  value=$(/usr/bin/osascript -e "display dialog \"$1\" default answer \"$default\"")

  text=$(echo $value | sed -e 's/.*text returned:\(.*\)/\1/')

  echo ${text// /}
}

## Commands

list_bookmarks() {
  while IFS= read -r line; do
    # ignore comments
    if [[ $line == \#* ]]; then continue; fi
    # ignore empty lines
    if [[ -z $line ]]; then continue; fi

    echo $line
  done < $BOOKMARKS_FILE
}

copy_bookmark() {
  readonly bookmark=$(list_bookmarks | choose);

  if [[ -z $bookmark ]]; then return 0; fi

  # ignore inline comments
  value="${bookmark%#*}"
  # remove spaces
  value="${value// /}";

  # Copy to clipboard
  echo -n ${value} | pbcopy

  notify "Bookmark copied to clipboard"
}

add_bookmark() {
  value=$(pbpaste);

  value=$(input "Enter bookmark:" "${value}");
  if [[ -z $value ]]; then return 0; fi

  if grep -q "$value" $BOOKMARKS_FILE; then
    notify "Bookmark already exists"
    return 0
  fi

  comment=$(input "Enter comment (optional):");

  if [[ -n $comment ]]; then
    comment=" # ${comment}"
  fi

  echo "${value} ${comment}" >> $BOOKMARKS_FILE
}

case $1 in
  add) add_bookmark;;
  copy) copy_bookmark;;
  list) list_bookmarks;;

  *) echo "Usage: $0 [add|copy|list]";;
esac
