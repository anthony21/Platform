class CreateInvoiceStatusLog < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_status_logs do |t|

      t.timestamps
    end
  end
end
