class MembershipsController < ApplicationController

  def create
    @membership = Membership.new(params[:membership])
    if @membership.save
      redirect_to @membership.hop
    else
      redirect_to @membership.hop, :alert => @membership.errors.full_messages.join("<br/>")
    end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    @hop = @memberhsip.hop
    @membership.destroy
    redirect_to @hop
  end
  
end
