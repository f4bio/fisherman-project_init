function pinit -d "setup project"
  set -l current_dir (pwd)
  set -e project_directory
  set -e project_name

  if test (count $argv) -lt 1
    __project_init_usage > /dev/stderr
    return 1
  end

  for idx in (seq (count $argv))

    switch $argv[$idx]
      case -h --help help
        __project_init_usage > /dev/stderr
        return
      case -v --version version
        echo -e "\nv$hashfile_version (using: $rhash_version)\n"
        return
      case --verbose
        set -g verbose 1
        break
      case --name -n
        set project_name $argv[$idx+1]
        break
    end
  end

  set project_directory (realpath $argv[-1])
  if test ! -d $project_directory
    mkdir -p $project_directory
    __project_init_log "creating project directory '$project_directory'"
  end

  if test -n $project_name
    set project_name (basename $project_directory)
    __project_init_log "guessing project name: '$project_name'"
  end

  cd $project_directory

  __project_init_log "fetching files..."
  curl -o README.md https://raw.githubusercontent.com/f4bio/git-files/master/_README.md
  curl -o LICENSE https://raw.githubusercontent.com/f4bio/git-files/master/_LICENSE
  curl -o .editorconfig https://raw.githubusercontent.com/f4bio/git-files/master/_editorconfig
  curl -o .gitconfig https://raw.githubusercontent.com/f4bio/git-files/master/_gitconfig

  __project_init_log "initializing repo"
  git init
  git add README.md LICENSE .gitignore .editorconfig
  git commit -m "repo init"

  git add -A
  git commit -m "files init"

  # cd $current_dir
  echo "done! see: '$project_directory'"
end
