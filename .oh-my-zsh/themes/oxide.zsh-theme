# Oxide theme for Oh My Zsh
#
# Author: Diki Ananta <diki1aap@gmail.com>
# Repository: https://github.com/dikiaap/dotfiles
# License: MIT

export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_info {
    [ "$VIRTUAL_ENV" ] && echo '('"%F{blue}$(basename "$VIRTUAL_ENV")"%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

# use extended color palette if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    turquoise="%F{73}"
    orange="%F{179}"
    purple="%F{140}"
    red="%F{167}"
    limegreen="%F{107}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    red="%F{hotpink}"
    limegreen="%F{green}"
fi

# enable VCS systems you use.
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories.
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats.
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%} ●"
FMT_STAGED="%{$limegreen%} ✚"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

function oxide_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec oxide_preexec

function oxide_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd oxide_chpwd

function oxide_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't.
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="on %{$turquoise%} %b%u%c%F{red} ● ${PR_RST}"
        else
            FMT_BRANCH="on %{$turquoise%} %b%u%c${PR_RST}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd oxide_precmd

PROMPT=$'
%{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)
%(?.%F{white}.%F{red})$%f '
