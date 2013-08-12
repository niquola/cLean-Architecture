class CommunitiesController < ApplicationController
  def index
    @communities = use_case.q(:list, filter: 'all')
  end

  def create
    @community = use_case.c(:create, params[:community])

    if @community.valid?
      redirect_to(action: 'index')
    else
      render action: 'new'
    end
  end

  def show
    @community = use_case.q(:find, id: params[:id])
  end

  private

  def use_case
    system.use_case(:community, user_identity: 'nicola')
  end
end
