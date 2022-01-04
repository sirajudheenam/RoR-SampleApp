json.extract! tax_calc, :id, :current_month, :current_year, :salary, :other_income, :gross, :base_tax, :other_tax, :lumpsum_tax, :lumpsum_reuni_tax, :other_reuni_tax, :pension_insurance, :unemployment_insurance, :net_pay, :own_company_contribution, :own_company_match, :er_allowance_hi, :er_allowance_ci, :addl_contrib_er_allowance, :payoff_contrib_volun_hi, :ded_contrib_volun_ci, :add_contrib_paid_by_co_hi, :bank_transfer, :user_id, :created_at, :updated_at
json.url tax_calc_url(tax_calc, format: :json)
