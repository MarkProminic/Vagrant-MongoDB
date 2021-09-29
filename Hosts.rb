class Hosts
  def Hosts.configure(config, settings)
    # Configure scripts path variable
    scriptsPath = File.dirname(__FILE__) + '/scripts'

    # Prevent TTY errors
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    config.ssh.forward_agent = true
    config.ssh.forward_x11 = true
    config.vm.boot_timeout = 900
#    config.ssh.password = 'PromVagrant21'
    config.ssh.username = 'prominic'
    config.ssh.private_key_path = 'id_rsa'
    config.ssh.insert_key = false
    # Set VirtualBox as provider	  
    config.vm.provider 'virtualbox'
	  
    #Create Hosts File for all Vms 
    #begin
 	#File.open('conf/hosts', 'r') do |f|
    ##     File.delete(f)
    #    end	 
    #    rescue Errno::ENOENT
    #end
    
 
    settings['hosts'].each_with_index do |host, index|
     	   #write to /vagrant/hosts to deploy
	   File.write("conf/hosts", "#{host['ip']} #{host['identifier']} #{host['branch']} vagrant.#{host['branch']}\n", mode: "a")  
    end  
	  
    #Main loop to configure VM
    settings['hosts'].each_with_index do |host, index|
      autostart = host.has_key?('autostart') && host['autostart']

      config.vm.define "#{host['name']}", autostart: autostart do |server|
        server.vm.box = host['box'] 
        if settings.has_key?('boxes')
          boxes = settings['boxes']
          if boxes.has_key?(server.vm.box)
            server.vm.box_url = settings['boxes'][server.vm.box]
          end
        end

        server.vm.hostname = host['identifier']
        ## Need to make check for if IP, Mac address, Netmask or Gateway not Set

        server.vm.network "public_network", ip: host['ip'], bridge: "1) Bridge", auto_config: true, :mac => host['mac'], :netmask => host['netmask'], gateway:  host['gateway']
        # VirtulBox machine configuration
        server.vm.provider :virtualbox do |vb|	  
          vb.name = host['identifier']
          vb.customize ['modifyvm', :id, '--natdnsproxy1', 'off']
          vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'off']
          vb.customize ['modifyvm', :id, '--ostype', 'RedHat_64']
          vb.customize ["modifyvm", :id, "--vrde", "on"]
          vb.customize ["modifyvm", :id, "--vrdeport", "3941"]
          vb.customize ["modifyvm", :id, "--vrdeaddress", "0.0.0.0"]
          vb.customize ["modifyvm", :id, "--accelerate3d", "off"]
          vb.customize ["modifyvm", :id, "--vram", "256"]
          vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxsvga"]
          if host.has_key?('provider')
            host['provider'].each do |param|
              vb.customize ['modifyvm', :id, "--#{param['directive']}", param['value']]
            end
          end
        end
      
        # Register shared folders
        if host.has_key?('folders')
          host['folders'].each do |folder|
            mount_opts = folder['type'] == 'nfs' ? ['actimeo=1'] : []
            server.vm.synced_folder folder['map'], folder ['to'],
              type: folder['type'],
              owner: folder['owner'] ||= 'prominic',
              group: folder['group'] ||= 'prominic',
              mount_options: mount_opts
            end
        end
		
#	# Add Branch Files to Vagrant Share on VM
#        if host.has_key?('branch')
#            server.vm.provision 'shell' do |s|
#              s.path = scriptsPath + '/add-branch.sh'
#              s.args = [host['branch'], host['git_url'] ]
#            end
#        end

        # Run custom provisioners
        if host.has_key?('provision')
            host['provision'].each do |file|
                server.vm.provision 'shell', path: file
            end
        end

	      
        ##Start Ansible Loop
        server.vm.provision :ansible do |ansible|
          ansible.playbook =  'conf/Setup.yml'
          ansible.compatibility_mode = "2.0"
#          ansible.install_mode = "pip"
          ansible.extra_vars = {ip:host['ip'],enable_jenkins_ssl:host['enable_jenkins_ssl'],gateway:host['gateway'],netmask:host['netmask'],identifier:host['identifier'],email:host['email'],git_user:host['git_user'],letsencrypt:host['letsencrypt'],letsencrypt_certbot_renewal_days:host['letsencrypt_certbot_renewal_days'],jenkins_https_port:host['jenkins_https_port'],ssl_passphrase:host['ssl_passphrase'] }
        end

      end
    end
  end
end
