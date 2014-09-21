if [ ! -L $HOME/doc ]; then
  ln -si $(pwd)/__doc $HOME/doc
fi

if [ ! -L $HOME/cuccok ]; then
  cd ../../
  ln -si $(pwd) $HOME/cuccok
fi
