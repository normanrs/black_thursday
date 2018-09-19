require_relative  "test_helper"
require_relative '../lib/invoice_items_repository.rb'

class InvoiceItemsRepositoryTest <  Minitest::Test

  def test_it_exists
    ir = InvoiceItemsRepository.new('./data/items_tiny.csv', self)
    assert_instance_of InvoiceItemsRepository, ir
  end

end
