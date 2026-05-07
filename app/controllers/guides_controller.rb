class GuidesController < ApplicationController
  def index
    @guides = Guide.published.order(published_at: :desc)
  end

  def show
    @guide = Guide.published.find_by!(slug: params[:slug])
    @related = Guide.published.where.not(id: @guide.id).order(published_at: :desc).limit(3)
  end
end
