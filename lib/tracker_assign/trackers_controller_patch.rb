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

require_dependency 'trackers_controller'
module TrackerAssign
    module TrackersControllerPatch
        def self.included(base)
            base.class_eval do

                #Override tracker's destroy method to also destroy associations
            	def destroy_with_plugin_assignation
                    @tracker = Tracker.find(params[:id])
                    unless @tracker.issues.empty?
                      flash[:error] = l(:error_can_not_delete_tracker)
                    else
                      auto_assigns = TrackerMemberAssociation.all
                        if auto_assigns != nil then
                          auto_assigns = auto_assigns.select{|a| (a[:tracker_id] == @tracker[:id].to_i)}
                        end
                        auto_assigns.each do |a| 
                            a.destroy
                        end
                    end
        			destroy_without_plugin_assignation
                end

                alias_method_chain :destroy, :plugin_assignation

            end
        end
    end
end