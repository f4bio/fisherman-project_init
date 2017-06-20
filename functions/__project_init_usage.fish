function __project_init_usage
    # set -l uline (set_color -u)
    # set -l nc (set_color normal)

    echo "Usage: pinit [--verbose]"
		echo -e "\t--name <NAME> --description <DESCRIPTION>"
		echo -e "\t--username <USERNAME> --email <EMAIL>"
		echo -e "\t<DIRECTORY>"
    echo
    echo "where NAME is the project name"
    echo "where DESCRIPTION is the project description"
    echo "where USERNAME is the project username"
    echo "where EMAIL is the project email"
    echo "where DIRECTORY is the project directory"
    # echo "       "$uline"u"$nc"se  Use the given node version (default)"
    # echo "       "$uline"r"$nc"m   Remove the given node version/s"
    # echo "       "$uline"l"$nc"s   List the available node version/s"
    echo
end
