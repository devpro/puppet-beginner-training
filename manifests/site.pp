node default {
  notify { 'site default message':
    message => 'Puppet Configuration Management: Default Node'
  }
}

# TODO: add your laptop computer name
node 'xxxx.domain.com' {
  file { "D:\\temp.txt":
    ensure => file,
  }
  -> file_line { 'file_content':
    line => 'File created and maintained by Puppet!',
    path => "D:\\temp.txt"
  }
}
