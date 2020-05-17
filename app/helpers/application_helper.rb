# frozen_string_literal: true

module ApplicationHelper
  def flash_bs_class(type)
    { success: 'success', error: 'danger', alert: 'warning', notice: 'info' }[type]
  end

  def currency_amount_regexp
    CurrencyForm::CURRENCY_AMOUNT_REGEXP
  end

  def link_to_pages
    if current_page?(admin_path)
      link_to 'Landing', root_path, class: 'navbar-brand'
    else
      link_to 'Admin', admin_path, class: 'navbar-brand'
    end
  end
end
