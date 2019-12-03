class PrefecturesController < ApplicationController
  def show
    @prefecture = Prefecture.find(params[:id])
    if (@prefecture.parent_id == nil)
      @prefectures = Prefecture.where(parent_id: @prefecture.id)
    end
  end
end
