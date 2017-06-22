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

class TrackerMemberAssociationController < ApplicationController
	before_filter :check_permissions, :only => [:create]
	before_filter :check_if_member, :only => [:create]

	#Create a Tracker-Member association
	#if an association already exist, modify it, or destroy it if member == -1
	#else create new association
	def create
		@auto_assign = TrackerMemberAssociation.all
		if @auto_assign != nil then
			@auto_assign = @auto_assign.select{|a| (a[:project_id] == params[:project_id].to_i)}
			if @auto_assign != nil then
				@auto_assign = @auto_assign.select{|a| (a[:tracker_id] == params[:tracker_id].to_i)}
				@auto_assign = @auto_assign.first
			end
		end
		if @auto_assign == nil && params[:user_id] != "-1" then
			@auto_assign = TrackerMemberAssociation.new
			@auto_assign[:user_id] = params[:user_id]
			@auto_assign[:project_id] = params[:project_id]
			@auto_assign[:tracker_id] = params[:tracker_id]
			@auto_assign.save
		else
			if params[:user_id] != '-1' then
				@auto_assign[:user_id] = params[:user_id]
				@auto_assign.save
			else
				@auto_assign.destroy
			end
		end
	    render :nothing => true
	end

	private

	def check_permissions
		render_403 unless User.current.allowed_to?(:assign_trackers, Project.find(params[:project_id]))		
	end

	#Check if the member in params is in the current project
	def check_if_member
		if params[:user_id] != '-1' then
			@member = Member.all
			if @member != nil then
				@member = @member.select{|m| (m[:user_id] == params[:user_id].to_i)}
				@member = @member.select{|m| (m[:project_id] == params[:project_id].to_i)}
				@member = @member.first
			end
		    render_403 unless @member != nil
		end
	end
end