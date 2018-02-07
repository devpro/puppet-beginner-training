# Puppet beginner training

This repository holds the steps I followed when I did a Puppet training for beginners.

It is aimed to give a practical example of a Puppet repository, along with the documentation on how to achieve this.

It has been tested on **Puppet 5.3 (Open Source)** where the puppet server (aka master) is hosted on CentOS 7 and puppet agent on Windows 7 & 10. But you don't need a Puppet server to experiment Puppet code.

Enjoyment in what we do is essential, please make sure you are using a nice IDE to edit files and review folder contents (no Notepad++ please...). I recommend to use [Visual Studio Code](https://code.visualstudio.com/), this is free, massively used by the community (and not always Microsoft fans ;)), continuously updated by new cool features (DevOps enabled!). If you do, you just have to install Puppet extension. This documentation has been created on Visual Studio Code that also helps review dynamically a markdown preview (with a live markdown lint).

## Pre-requisites

As usual, when installing components on your laptop, think about launching a new console window when PATH is updated ;)

- **git**

    A git client must be installed and accessible from the console. The installation can be found on [git-scm.com](https://git-scm.com/).

    While installing it, please select the option where git does not change automatically the line endings! This is unfortunately by default in the Windows installation UI...

    ```bash
    git
    # must display information about git client
    ```

    On Windows, your configuration can be seen and updated here: `C:\Users\username\.gitconfig`.

    Example:

    ```ini
    [core]
        autocrlf = false
        longpaths = true
    ```

- **Ruby**

    Ruby must be installed on your computer in order to be able to test your code before commit (seems obvious, right?). The installation can be found on [rubyinstaller.org](https://rubyinstaller.org/downloads/). At the moment of writing this documentation, the stable version was 2.4.X (do not select 2.5).

    ```bash
    ruby -v
    # should display the version
    gem -v
    # should display the version
    ```

- **r10k**

    r10k is a component that is used on the Puppet server to convert branches from a git repository to environments folder!

    It is also used to download Puppet modules from a Puppetfile.

    ```bash
    gem install r10k
    ```

    ```bash
    r10k version
    # should display the version
    ```

- **Puppet agent**

    For Windows, it's available from [puppet.com/docs/install_windows](https://puppet.com/docs/puppet/5.3/install_windows.html) > [downloads.puppetlabs.com/windows](https://downloads.puppetlabs.com/windows/puppet5/).

    You can use a name like `puppetmaster-dev` when you're asked to provide a name for the Puppet server.

    Right after, stop and disable the puppet agent service that is installed and started by default. On a Developer workstation it is better to have it disabled and run the command manually.

    Review and update `C:\ProgramData\PuppetLabs\puppet\etc\puppet.conf` with your environment.

    ```ini
    [main]
        server=puppetmaster-dev
        autoflush=true
        environment=production
    [agent]
        environment=mybranchname
    ```

    Make sure your host file (`C:\Windows\System32\drivers\etc\hosts`) know the Puppet server hostname if not in the DNS of your domain.

    ```bash
    puppet --version
    # should display the version (puppet help for more options)
    facter -- version
    # should display the version (facter --help for more options)
    ```

- **Puppet Development Kit (PDK)**

    It will be easier to do good with with the PDK, that can be found on [puppet.com](https://puppet.com/download-puppet-development-kit).

    Follow instructions on [Installing PDK](https://puppet.com/docs/pdk/1.3/pdk_install.html).

    Open a PowerShell command window:

    ```bash
    pdk --version
    # should display the version (pdk help for more options)
    ```

## Design

If you are serious about getting knowledge about Puppet, it's important to read the documentation on puppet website and when you write your first code take some time to read the documentation on resources you're using, for example "puppet exec" and refresh option (a simple web search will give exactly what you need).

Puppet is based on masters / agent architecture. The masters hold the repository: state + configuration + code to achieve it. The agent queries the master for it's desired configuration state and apply any needed changes.

r10k must be installed on the server and will use your git repository to populate the environments folder dynamically.

## Steps

### Create default structure

- Create `data` folder where Hiera data will be stored. Create also `hiera.yaml` file that is your Hiera configuration. Start by writting a `common.yaml` file. It's all about hierarchy!

- Create the `site.pp` in `manifest` folder that will be the entry point. Here you can defined the known nodes for your environment (= git branch).

- Create the `modules` folder that will be automatically filled by r10k thanks to the `Puppetfile` that you also have to create. Puppet community is strong, you can be sure that for most of your needs, a module will provide the functionality you're looking for. Go to [forge.puppet.com](https://forge.puppet.com/) and enjoy!

- Create and update `environment.conf` to update modulepath (include site folder)

- Create `site` folder, this is where you'll put your own modules.

### Load puppet modules

This action must be done everytime you update your Puppetfile.

```bash
r10k puppetfile install
```

### Check initial setup is ok

You don't need to load your files on the Puppet master to test it, you can and should do it before by running `puppet apply` command.

```bash
puppet apply --modulepath="modules;site" --hiera_config="hiera.yaml" .\manifests\site.pp
```

In case of puppet unknown, even in starting a new DOS window, restart your computer.

You should see something like this:

> Notice: Compiled catalog for xxxxxx in environment production in 0.15 seconds  
> Notice: Puppet Configuration Management: Default Node  
> Notice: /Stage[main]/Main/Node[default]/Notify[site default message]/message: defined 'message' as 'Puppet Configuration Management: Default Node'  
> Notice: Applied catalog in 0.07 seconds

### Define your computer as a node

Look at site.pp file and update it so your computer is a know node.

When successfull, a file call temp.txt will be created at the root folder of your D driver.
You are free to update the existing code to practice!
