git add .
git commit -m "1sf-x"
git push
sudo gem uninstall smsru
gem build smsru.gemspec
sudo gem install smsru-0.0.4.gem
