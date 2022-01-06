class profile::app::webserver::iis {
  $iis_features = ['Web-WebServer','Web-Scripting-Tools']

  iis_feature { $iis_features:
    ensure => 'present',
  }

  iis_site { 'Default Web Site':
    ensure  => absent,
    #require => iis_feature['Web-WebServer'],
  }

  $website_hash = lookup('iis_website::settings')

  $website_hash.each | $website | {
    $website_name = $website[1][website_name]
    $application_pool = $website[1][application_pool]
    $physical_path = $website[1][physical_path]
    iis_site { $website_name:
      ensure          => 'started',
      physicalpath    => $physical_path,
      applicationpool => $application_pool,
    }

    file { $website_name:
      ensure => 'directory',
      path   => $physical_path,
    }
  }

  #iis_site { 'minimal':
  #  ensure          => 'started',
  #  physicalpath    => 'c:\\inetpub\\minimal',
  #  applicationpool => 'DefaultAppPool',
    #require         => [
    #  File['minimal'],
    #  iis_site['Default Web Site']
    #],
  #}

}
