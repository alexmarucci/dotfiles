# alias y='yarn'
# # Yarn shortener (with args only)
function y
  set --local bin '';
  set --local pnpm_lock (_doesFileExists 'pnpm-lock.yaml');
  set --local yarn_lock (_doesFileExists 'yarn.lock');
  set --local package_lock (_doesFileExists 'package-lock.json');

  if test "$pnpm_lock" = true
    set bin pnpm
  else if test "$yarn_lock" = true
    set bin yarn
  else if test "$package_lock" = true
    set bin npm
  else
    echo 'No known lockfile found, unable to guess package manager.'
    echo 'You may run the install manually: e.g. $ npm install'
    exit -1
    return;
  end

  if count $argv > /dev/null
    $bin $argv;
  else
    $bin install
  end
end

function _doesFileExists
  set --local file $argv[1];
  set --local root_dir (git rev-parse --show-toplevel 2> /dev/null || pwd);

  if test \( -f "$root_dir/$file" -o -f "$file" \)
    echo true;
  else
    echo false;
  end 
end
