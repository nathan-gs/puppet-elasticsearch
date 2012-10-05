class elasticsearch
(
    $node_name   = '',
    $cluster_name    = 'elasticsearch'
)
{
    package { 'elasticsearch':
    	ensure		=> installed,
    	provider	=> rpm,
    	source		=> 'http://dl.dropbox.com/u/25821613/elasticsearch/elasticsearch-0.19.9-1.el6.x86_64.rpm',
        require     => Package['jpackage-utils']
    }

    package { 'jpackage-utils':
        ensure  => installed,
    }

    service { 'elasticsearch':
        ensure  => running,
        require => Package['elasticsearch'],
        enable  => true,
    }

    file { '/etc/elasticsearch/elasticsearch.yml':
        ensure	=> present,
        owner	=> root,
        content	=> template('elasticsearch/elasticsearch.yml.erb') ,
        require => [Package['elasticsearch'], File['/etc/elasticsearch/logging.yml']],
    }


    file { '/etc/elasticsearch/logging.yml':
        ensure	=> present,
        owner	=> root,
        content	=> template('elasticsearch/logging.yml.erb') ,
        require => [Package['elasticsearch']],
     }

}