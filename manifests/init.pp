class collectd {
  case $::operatingsystem {
    debian, ubuntu: {
      include apt

      apt::ppa { 'ppa:joey-imbasciano/collectd5': }
      package { 'collectd':
        require => Apt::Ppa['ppa:joey-imbasciano/collectd5']
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}
