set -x
apt-get -y install reprepro
echo "pulling encrypted gpg key from s3"
aws s3 cp s3://sp-deploy-repo/sp_sec.gpg /tmp
echo "building python package version $PYTHON_VERSION"
BUILD_VERSION=${PythonVersion} BUILD_ITERATION=${BUILD_ITERATION} BUILD_OUTPUT_DIR=${BUILD_OUTPUT_DIR:-/tmp} /opt/build_scripts/build_python
echo "Building SP apt repo locally"
curl http://apt.singleplatform.co/Release.key | gpg --import
echo use-agent >> ~/.gnupg/gpg.conf
echo pinentry-mode loopback >> ~/.gnupg/gpg.conf
echo allow-loopback-pinentry >> ~/.gnupg/gpg-agent.conf
echo allow-preset-passphrase >> ~/.gnupg/gpg-agent.conf
echo no-tty >> ~/.gnupg/gpg.conf
echo RELOADAGENT | gpg-connect-agent
echo ${gpgpassphrase} | gpg --no-tty --passphrase-fd 0 --import /tmp/sp_sec.gpg
echo "personal-digest-preferences SHA256" > ~/.gnupg/gpg.conf
gpg-connect-agent 'keyinfo --list' /bye | awk '{print $3}' > /tmp/keygrips
sed -i '/^$/d' /tmp/keygrips
while read keygrip; do echo ${gpgpassphrase} | /usr/lib/gnupg/gpg-preset-passphrase --preset $keygrip; done </tmp/keygrips
mkdir /repo
aws s3 sync --delete s3://apt.singleplatform.co/ /repo/
echo "Adding python package to apt repo"
LSB_RELEASE=`lsb_release -cs`
GNUPGHOME=~/.gnupg reprepro -b /repo/ includedeb ${LSB_RELEASE} /tmp/python-*
aws s3 sync --delete --acl public-read /repo/ s3://apt.singleplatform.co/
