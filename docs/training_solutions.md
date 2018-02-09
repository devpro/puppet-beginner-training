# Puppet training solutions

## Exercise 1: hello world

* Update `manifests/site.pp` file to have the following

```ruby
# replace xxxx.domain.com by your fqdn and XXX by your name
node 'xxxx.domain.com' {
  notify { 'hey':
    message => 'Welcome on XXX awesome computer'
  }
}
```

* Then run from the root folder of this project `puppet apply --modulepath="modules;site" --hiera_config="hiera.yaml" .\manifests\site.pp`. You should have the hello world message displayed.

## Exercise 2: Ensure file content

* Update `manifests/site.pp` file to have the following

```ruby
# replace xxxx.domain.com by your fqdn and XXX by your name
node 'xxxx.domain.com' {
  file { "D:\\temp.txt":
    ensure  => file,
    content => 'Puppet is awesome!'
  }
}
```

* Then run from the root folder of this project `puppet apply --modulepath="modules;site" --hiera_config="hiera.yaml" .\manifests\site.pp`. From now one, the file content will always be the same after running puppet apply!
