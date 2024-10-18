#compdef docker-compose.sh

_service_names() {
  local -a services
  services=($(cat */docker-compose.dev.yml | grep -v '#' | sed -n 's/^  \(\S\+\):/\1/p'))
  _describe 'services' services
}

_service_names
