require_relative  "test_helper"
require_relative '../lib/item_repository.rb'

class ItemRepositoryTest <  Minitest::Test

  def test_it_exists
    ir = ItemRepository.new('./data/items.csv')
    assert_instance_of ItemRepository, ir
  end

  def test_it_loads_items
    ir = ItemRepository.new('./data/items.csv')
    actual = ir.collection.length
    expected = 1367
    assert_equal expected, actual
  end

  def test_all
    ir = ItemRepository.new('./data/items.csv')
    actual = ir.all.length
    expected = 1367
    assert_equal expected, actual
  end

  def test_find_by_id
    ir = ItemRepository.new('./data/items.csv')
    found = ir.find_by_id(263396013)
    actual = found.id
    expected = 263396013
    assert_equal expected, actual
  end

  def test_find_by_name
    ir = ItemRepository.new('./data/items.csv')
    found = ir.find_by_name("FREE standing WODEN letters")
    actual = found.name
    expected = "Free standing Woden letters"
    assert_equal expected, actual
  end

  def test_find_all_with_description
    ir = ItemRepository.new('./data/items.csv')
    found = ir.find_all_with_description("free standing")
    actual = found[0].id
    expected = 263396013
    assert_equal expected, actual
  end

  def test_delete
    ir = ItemRepository.new('./data/items.csv')
    assert_equal 1367, ir.collection.length
    ir.delete(263396013)
    actual = ir.collection.length
    expected = 1366
    assert_equal expected, actual
  end

  def test_create
    ir = ItemRepository.new('./data/items.csv')
    ir.create({:id => 0, :name =>"Pencil", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4) , :created_at=> Time.now, :updated_at=> Time.now, :merchant_id => 2})
    actual = ir.collection.max_by {|element| element.id}.id
    expected = 263567475
    assert_equal expected, actual
  end

  def test_update
    ir = ItemRepository.new('./data/items.csv')
    attributes = { unit_price: BigDecimal.new(379.99, 5) }
    ir.update(263397919, attributes)
    updated_item = ir.find_by_id(263397919)
    assert_equal 379.99, updated_item.unit_price
  end

  def test_find_all_by_price
    ir = ItemRepository.new('./data/items.csv')
    found = ir.find_all_by_price(BigDecimal.new(23.90, 4))
    actual = [found[0].unit_price, found[1].unit_price]
    expected = [23.90, 23.90]
    assert_equal expected, actual
  end

  def test_find_all_by_merchant_id
    ir = ItemRepository.new('./data/items.csv')
    found = ir.find_all_by_merchant_id('12334257')
    actual = found.length
    expected = 6
    assert_equal expected, actual
  end

  def test_find_all_by_price_in_range
    ir = ItemRepository.new('./data/items.csv')
    found = ir.find_all_by_price_in_range(10.00..15.00)
    actual = found.length
    expected = 205
    assert_equal expected, actual
  end
end
