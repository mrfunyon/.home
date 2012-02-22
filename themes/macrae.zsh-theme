#
# A theme based on Steve Losh's prompt with VCS_INFO integration.
#
# Authors:
#   Steve Losh <steve@stevelosh.com>
#   Bart Trojanowski <bart@jukie.net>
#   Brian Carper <brian@carper.ca>
#   steeef <steeef@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

function virtualenv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    print " virtualenv:(${VIRTUAL_ENV:t}) "
  fi
}

function prompt_steeef_precmd() {
  if [[ -n "$__PROMPT_STEEEF_VCS_UPDATE" ]] ; then
    # Check for untracked files or updated submodules since vcs_info doesn't.
    if [[ ! -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
      __PROMPT_STEEEF_VCS_UPDATE=1
      fmt_branch="(${__PROMPT_STEEEF_COLORS[1]}%b%f%u%c${__PROMPT_STEEEF_COLORS[4]}●%f)"
    else
      fmt_branch="(${__PROMPT_STEEEF_COLORS[1]}%b%f%u%c)"
    fi
    zstyle ':vcs_info:*:prompt:*' formats "${fmt_branch}"

    vcs_info 'prompt'
    __PROMPT_STEEEF_VCS_UPDATE=''
  fi
}

function prompt_steeef_preexec() {
  case "$(history $HISTCMD)" in
    (*git*)
      __PROMPT_STEEEF_VCS_UPDATE=1
    ;;
    (*svn*)
      __PROMPT_STEEEF_VCS_UPDATE=1
    ;;
  esac
}

function prompt_steeef_chpwd() {
  __PROMPT_STEEEF_VCS_UPDATE=1
}

function prompt_steeef_setup() {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd prompt_steeef_precmd
  add-zsh-hook preexec prompt_steeef_preexec
  add-zsh-hook chpwd prompt_steeef_chpwd

  __PROMPT_STEEEF_VCS_UPDATE=1

  # Use extended color pallete if available.
  if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    __PROMPT_STEEEF_COLORS=(
      "%F{81}"  # turquoise
      "%F{166}" # orange
      "%F{135}" # purple
      "%F{161}" # hotpink
      "%F{118}" # limegreen
    )
  else
    __PROMPT_STEEEF_COLORS=(
      "%F{cyan}"
      "%F{yellow}"
      "%F{magenta}"
      "%F{red}"
      "%F{green}"
    )
  fi

  # Enable VCS systems you use.
  zstyle ':vcs_info:*' enable bzr git hg svn

  # check-for-changes can be really slow.
  # You should disable it if you work with large repositories.
  zstyle ':vcs_info:*:prompt:*' check-for-changes true

  # Formats:
  # %b - branchname
  # %u - unstagedstr (see below)
  # %c - stagedstr (see below)
  # %a - action (e.g. rebase-i)
  # %R - repository path
  # %S - path in the repository
  local fmt_branch="(${__PROMPT_STEEEF_COLORS[1]}%b%f%u%c)"
  local fmt_action="(${__PROMPT_STEEEF_COLORS[5]}%a%f)"
  local fmt_unstaged="${__PROMPT_STEEEF_COLORS[2]}●%f"
  local fmt_staged="${__PROMPT_STEEEF_COLORS[5]}●%f"

  zstyle ':vcs_info:*:prompt:*' unstagedstr   "${fmt_unstaged}"
  zstyle ':vcs_info:*:prompt:*' stagedstr     "${fmt_staged}"
  zstyle ':vcs_info:*:prompt:*' actionformats "${fmt_branch}${fmt_action}"
  zstyle ':vcs_info:*:prompt:*' formats       "${fmt_branch}"
  zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

  PROMPT="${__PROMPT_STEEEF_COLORS[3]}%n%f@${__PROMPT_STEEEF_COLORS[2]}%m%f in ${__PROMPT_STEEEF_COLORS[2]}"'$(virtualenv_info)'"%f${__PROMPT_STEEEF_COLORS[5]}%~%f "'${vcs_info_msg_0_}'"
 ""%(!.#.$) "
}

prompt_steeef_setup "$@"

