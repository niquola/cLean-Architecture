class CommunitiesController < ApplicationController
  def index
    @communities = use_case.q(:list, filter: 'all')
  end

  def create
    use_case.c(:create, params[:community])
    redirect_to(action: 'index')
  end

  def show
    @community = use_case.q(:find, id: params[:id])
  end

  private

  def use_case
    system.use_case(:community, user_identity: 'nicola')
  end
end
