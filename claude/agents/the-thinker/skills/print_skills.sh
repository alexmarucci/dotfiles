#!/bin/bash

this_folder=$(dirname "$0")
abs_path="$(cd "${this_folder}" && pwd)"

for skill in $(ls "${abs_path}"); do
  f="${abs_path}/${skill}/SKILL.md"
  echo "Skill: ${f}"

  head -n 4 "${f}"
  echo
  echo
done

