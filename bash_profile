## copy & paste in ~/.bash_profile
# export DOTFILES=$HOME/dotfiles
# if [ -f $DOTFILES/_bash_profile ]; then
#   source $DOTFILES/_bash_profile
# fi

# ~/.bash_profile -> dotfiles/_bash_profile
#                 -> ~/.bashrc  (private)
#                 -> ~/dotfiles/_bashrc


# .bash_profile
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

ls
