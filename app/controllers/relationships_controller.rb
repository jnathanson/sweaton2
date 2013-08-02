class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @tag = Tag.find(params[:relationship][:tag_id])
    @event = Relationship.find(params[:id]).event
    @event.tagify!(@tag)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @tag = Relationship.find(params[:id]).tag
    @event = Relationship.find(params[:id]).event
    @event.untagify!(@tag)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end
end
