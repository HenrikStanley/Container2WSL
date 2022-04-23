# Docker2WSL

Turn any Linux Container into a [WSL distribution][AboutWSL].
## About

This repository contains general instructions on how you can take any Linux container image, use it as a distribution in WSL.
The main advantages for this approach are:

* Full control of the what is in your WSL distribution.
* Utilize the build in WSL integrations with Windows.
* Easily copy, rebuild and iterate your WSL environments.
* Use custom Linux distributions not available in the Microsoft store.

The docker files provided in this repository is meant to be forked and customized to your own preferences for your own custom WSL environments.

## Exporting as a WSL distribution

These general steps are the same for all distributions.

### Build and Export the container


```sh
# Build the container image using docker
docker build -t distro-container:latest .

# Create a running container instance of the image we can export 
docker run --name distro-container distro-container:latest  

# Export the running container filesystem to a .tar file.
docker export distro-container -o distro-container.tar
```

After export the container we can stop and remove the running container instance:

```sh
docker rm -f distro-container
```

### Importing the Linux distribution in WSL

Using the exported container we can now import it into WSL.
The process of importing the file system from our container will create a `ext4.vhdx` with the virtual harddisk with your WSL distribution on it.
You must decide where on your system to store these.

I have created a folder called wsl in the root of my C: drive `C:\wsl` where I keep mine. You can do whatever path makes sense for your system.
If you run multiple distributions they need separate subfolders like:

* `C:\wsl\arch`
* `C:\wsl\ubuntu`
* `C:\wsl\debian`

You can choose whatever naming scheme makes sense for your system and setup.
After setting up your folders for the distribution, we can now import it:

```sh
# Move the .tar file with your distribution to the WSL folder.
mv .\distro-container.tar C:\wsl\distro\distro-container.tar

# Import the distribution into WSL
wsl --import DistroName C:\wsl\distro C:\wsl\distro\distro-container.tar
```

You can validate that your new distribution has been successfully imported by running:  

```sh
# Validate WSL distributions available.
wsl -l -v
```

### Post installation cleanup in Windows

Unless you want to keep the .tar file to re-install the exact same build at a later date, you can safely remove the .tar file as it is no longer needed.
```sh
# Move the .tar file with your distribution to the WSL folder.
rm C:\wsl\distro\distro-container.tar
```

### Post installation cleanup in Linux Distribution

Inside your new WSL distribution, the Docker build process has left a file called `.dockerenv`.
I recommend removing this file as some applications will detect this file and assume they are running inside a container.

Inside your WSL distribution: 

```sh
sudo rm /.dockerenv
```

## Remove or Re-Install distribution from scratch

You can always rebuild your container image and import it into WSL.
To remove the old distribution from your WSL and clean up the `ext4.vhdx` file:
```sh
# Removes the Linux Distribution from your system.
wsl --unregister DistroName
```


[AboutWSL]: https://docs.microsoft.com/en-us/windows/wsl/about