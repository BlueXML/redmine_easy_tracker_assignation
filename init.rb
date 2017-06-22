#Copyright (C) 2017  Alexandre BOUDINE
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'redmine'
require_dependency 'tracker_assign/hook'

Rails.configuration.to_prepare do
	require_dependency 'tracker_assign/projects_controller_patch' #Apply patch
	ProjectsController.send(:include, TrackerAssign::ProjectsControllerPatch)

	require_dependency 'tracker_assign/trackers_controller_patch' #Apply patch
	TrackersController.send(:include, TrackerAssign::TrackersControllerPatch)
end

Redmine::Plugin.register :redmine_easy_tracker_assignation do
  name 'Easy Tracker Assignation'
  author 'Alexandre BOUDINE'
  description 'Allow pre-assignment to members for specific trackers on new issues'
  version '0.1.0'

  permission :assign_trackers, {:tracker_member_association => [:create]}, :require => :member, :caption => :permission_assign_trackers
end

