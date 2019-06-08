# tgit

tgit is a git wrapper that adds a moving tortoise on top of the output of possibly lengthy git commands such as `git push`. 

## Installation

Download `tgit.sh` or clone the repository and add it to your `PATH`. `tgit` becomes most useful when used as an alias so you may want to set it as an alias for `git` in your shell configuration.

For ZSH, e.g.:

```
alias git="tgit.sh"
```

## Usage 

Just keep using `git` and watch the tortoise crawl to the left while files are being moved in the background.

