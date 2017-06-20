function pinit -d "setup project"
  set -g pinit_version 0.0.1
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
        echo -e "\nv$pinit_version\n"
        return
      case --verbose
        set -g verbose 1
      case --name -n
        set project_name $argv[$idx+1]
			case --description -d
        set project_description $argv[$idx+1]
			case --username -u
        set project_username $argv[$idx+1]
			case --email -e
        set project_email $argv[$idx+1]
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
  curl -o README.md https://raw.githubusercontent.com/f4bio/project-files/master/_README.md
  curl -o LICENSE https://raw.githubusercontent.com/f4bio/project-files/master/_LICENSE
  curl -o .editorconfig https://raw.githubusercontent.com/f4bio/project-files/master/_editorconfig
  curl -o .gitignore https://raw.githubusercontent.com/f4bio/project-files/master/_gitignore

	sed -i "s/{{PROJECT_NAME}}/$project_name/g" {README.md,LICENSE,.editorconfig,.gitignore}
	sed -i "s/{{PROJECT_DESCRIPTION}}/$project_description/g" {README.md,LICENSE,.editorconfig,.gitignore}
	sed -i "s/{{USER_NAME}}/$project_username/g" {README.md,LICENSE,.editorconfig,.gitignore}
	sed -i "s/{{USER_EMAIL}}/$project_email/g" {README.md,LICENSE,.editorconfig,.gitignore}

  __project_init_log "initializing repo"
  git init
  git add README.md LICENSE .gitignore .editorconfig
  git commit -m "repo init"

  git add -A
  git commit -m "files init"

  # cd $current_dir
  echo "done! see: '$project_directory'"
end
