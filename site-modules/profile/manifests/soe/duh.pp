class profile::soe::duh {
  file_line { 'sshd_config':
    ensure            => absent,
    path              => '/etc/ssh/sshd_config',
    match             => 'AllowsUsers ?',
  }
}
