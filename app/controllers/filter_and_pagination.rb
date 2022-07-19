# frozen_string_literal: true

module FilterAndPagination
  def get_paginated_and_filtered(model)
    model.order(query_params[:order_by]).page(query_params[:page]).per(query_params[:page_size])
  end

  def query_params
    params.permit(:page, :page_size, :order_by)
  end
end
