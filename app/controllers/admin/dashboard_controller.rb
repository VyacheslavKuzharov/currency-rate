# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    def index
      @currency = Currency.find_by(name: 'usd')
      @currency_form = CurrencyForm.new(@currency)
    end

    def create
      @currency = Currency.find_by(id: params[:currency][:currency_id])
      @currency_form = CurrencyForm.new(@currency)

      if @currency_form.submit(currency_params)
        redirect_to admin_path, notice: 'Currency updated!'
      else
        render 'index'
      end
    end

    private

    def currency_params
      params.require(:currency).permit(:amount, :dead_line, :currency_id)
    end
  end
end