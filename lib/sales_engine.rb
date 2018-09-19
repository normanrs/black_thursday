require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'csv_adapter'
require_relative 'crud'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_items_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'
require 'csv'

class SalesEngine
include Crud

  attr_reader :filepath
  attr_accessor :merchants, :items, :analyst

  def initialize(filepath)
    @filepath = filepath
  end

  def self.from_csv(filepath)
    SalesEngine.new(filepath)
  end

  def create_instance_of_items(items_array)
    items_array.map do |hash|
     Item.new(hash)
   end
 end

  def merchants
    @merchants ||= MerchantRepository.new(filepath[:merchants])
  end

  def items
    @items ||= ItemRepository.new(filepath[:items])
  end

  def invoices
    @invoices ||= InvoiceRepository.new(filepath[:invoices])
  end

  def invoice_items
    @invoice_items ||= InvoiceItemsRepository.new(filepath[:invoice_items])
  end

  def customers
    @customers ||= CustomerRepository.new(filepath[:customers])
  end

  def analyst
    @sales_analyst = SalesAnalyst.new(self)
  end

  def transactions
    @transactions ||= TransactionRepository.new(filepath[:transactions])
  end

end
