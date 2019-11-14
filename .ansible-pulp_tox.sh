#!/bin/bash
# wrapper for inserting pulp_rpm_prerequisites into the ansible-pulp CI
cd ..
if [ ! -e ansible-pulp ]; then
  git clone https://github.com/pulp/ansible-pulp
fi
cd ansible-pulp
if [ ! -e roles/pulp.pulp_rpm_prerequisites ]; then
  ln -s $TRAVIS_BUILD_DIR roles/pulp.pulp_rpm_prerequisites
fi
