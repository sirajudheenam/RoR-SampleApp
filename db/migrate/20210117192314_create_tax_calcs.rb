class CreateTaxCalcs < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_calcs do |t|
      t.string :current_month
      t.string :current_year
      t.float :salary
      t.float :other_income
      t.float :gross
      t.float :base_tax
      t.float :other_tax
      t.float :lumpsum_tax
      t.float :lumpsum_reuni_tax
      t.float :other_reuni_tax
      t.float :pension_insurance
      t.float :unemployment_insurance
      t.float :net_pay
      t.float :own_company_contribution
      t.float :own_company_match
      t.float :er_allowance_hi
      t.float :er_allowance_ci
      t.float :addl_contrib_er_allowance
      t.float :payoff_contrib_volun_hi
      t.float :ded_contrib_volun_ci
      t.float :add_contrib_paid_by_co_hi
      t.float :bank_transfer
      t.float :user_id

      t.timestamps
    end
  end
end
