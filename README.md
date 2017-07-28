# RedMine Easy Tracker Assignation
## A RedMine plugin

This plugin aims to facilitate the assignation of Issues to appropriate members of project.
To do so, it provides the possibility to auto-assign specific Trackers to specific Members.
When creating a new issue, on change of the Tracker field, the Assign field is updated.



## Features :

This plugin provides the following features :
* Association of Tracker with Member for each projects
* Auto-filling of 'Assign' field in new issues

Languages availables :
* EN
* FR

## Use :

To associate member and tracker
	Projects -> MyProject -> Settings -> Information

## Installation :

	$cd /path/to/redmine/directory/plugins
	$git clone https://github.com/BlueXML/redmine_easy_tracker_assignation.git
	$bundle exec rake redmine:plugins:migrate RAILS_ENV=production

## Compatibility :
Tested for RedMine 3.3.* (Manually)

## License :
This plugin is licensed under the GNU/GPL license v3.




