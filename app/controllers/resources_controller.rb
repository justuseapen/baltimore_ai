class ResourcesController < ApplicationController
  def index
    @resources = Resource.published.order(:name)
    @grouped = @resources.group_by(&:resource_type)
  end

  def show
    @resource = Resource.published.find_by!(slug: params[:slug])
  end
end
