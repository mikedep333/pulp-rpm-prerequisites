Pulp 3 RPM plugin prerequisites
===============================

This role installs prerequisites for pulp-rpm plugin use, when installed by
ansible-pulp.

Requirements
------------

Each currently supported operating system has a matching file in the "vars"
directory.

Installation
------------

Install in the [ansible role search path](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-search-path)
as the foldername `pulp.pulp_rpm_prerequisites`, by either:
*. `ansible-galaxy install pulp.pulp_rpm_prerequisites -p ./roles/`
*. Cloning this repo, and symlinking it as pulp.pulp_rpm_prerequisites

Example Playbook
----------------

Here's an example playbook for using pulp_rpm_prerequisites as part of ansible-pulp.

    ---
    - hosts: all
      vars:
        pulp_default_admin_password: password
        pulp_settings:
          secret_key: secret
        pulp_install_plugins:
          pulp-rpm:
            prereq_role: "pulp.pulp_rpm_prerequisites"
      roles:
        - pulp-database
        - pulp-workers
        - pulp-resource-manager
        - pulp-webserver
        - pulp-content
      environment:
        DJANGO_SETTINGS_MODULE: pulpcore.app.settings

Shared Variables:
-----------------

* `pulp_use_system_wide_pkgs`: This role sets is to `true`. See `pulp` README.

* `prereq_pip_packages`: This role appends to it. See `pulp` README.

License
-------

GPLv3

Author Information
------------------

Pulp Team
