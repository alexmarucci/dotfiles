# NPM (https://npmjs.org) completions for Fish shell
# __fish_npm_needs_* and __fish_npm_using_* taken from:
# https://stackoverflow.com/questions/16657803/creating-autocomplete-script-with-sub-commands
# see also Fish's large set of completions for examples:
# https://github.com/fish-shell/fish-shell/tree/master/share/completions

function __fish_yarn_run
  if test -e package.json; and type -q jq
    jq -r '.scripts | to_entries | map("\(.key)\t\(.value | tostring | .[0:20])") | .[]' package.json
  else if type -q jq
    command yarn run --json 2> /dev/null | jq -r '.data.hints? | to_entries | map("\(.key)\t\(.value | tostring |.[0:20])") | .[]'
  end
end

# run
# complete -c yr -n "test true" -a "(__fish_npm_run)"
complete -f -c y -n '__fish_use_subcommand' -a "(__fish_yarn_run)"

