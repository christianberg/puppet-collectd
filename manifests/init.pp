class collectd ($graphite_server, $graphite_port = 2003) {
  case $::operatingsystem {
    debian, ubuntu: {
      include apt

      apt::ppa { 'ppa:joey-imbasciano/collectd5': }
      package { 'collectd':
        require => Apt::Ppa['ppa:joey-imbasciano/collectd5'],
        ensure  => latest,
        before  => File['/etc/collectd.conf'],
      }

      file { '/etc/collectd.conf':
        ensure  => present,
        content => template('collectd/collectd.conf.erb'),
      }

      service { 'collectd':
        ensure    => running,
        enable    => true,
        subscribe => File['/etc/collectd.conf'],
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}
