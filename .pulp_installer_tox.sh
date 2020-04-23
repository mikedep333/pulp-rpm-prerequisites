#!/bin/bash
# wrapper for inserting pulp_rpm_prerequisites into the pulp_installer CI
#
# Should be usable on local developer systems as well
cd ..

# On CI, created by before_install.sh, with PR support.
if [ ! -e pulp_installer ]; then
  git clone https://github.com/pulp/pulp_installer
fi

cd pulp_installer
if [ ! -e roles/pulp.pulp_rpm_prerequisites ]; then
  ln -s ${GITHUB_WORKSPACE:-../../pulp_rpm_prerequisites} roles/pulp.pulp_rpm_prerequisites
fi

for scenario in {release,source}-{static,dynamic,upgrade}
do
  rm molecule/${scenario}/group_vars/all
  cp -T roles/pulp.pulp_rpm_prerequisites/.pulp_installer_molecule/${scenario}/group_vars/all\
        molecule/${scenario}/group_vars/all
done

find ./molecule/*/group_vars/all -exec sh -c "echo; echo {}; cat {}" \;

find ./molecule/*upgrade*/molecule.yml -exec sed -i '/quay.io\/pulp\/pulp-ci-dbuster:3.0.0/,+3 d' {} \;
find ./molecule/*upgrade*/molecule.yml -exec sed -i '/debian-10/d' {} \;
find ./molecule/*/molecule.yml -exec sed -i '/debian-10/,+3 d' {} \;
find ./molecule/*upgrade*/molecule.yml -exec sed -i 's/pulp-ci-c7:3.0.0/pulp_rpm-ci-c7:3.1.0/g' {} \;
find ./molecule/*upgrade*/molecule.yml -exec sed -i 's/pulp-ci-f31:3.0.0/pulp_rpm-ci-f31:3.1.0/g' {} \;

tox && exit 0 || true
sleep 45
tox
