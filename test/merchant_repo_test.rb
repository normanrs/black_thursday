require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_loads_merchants
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.collection.count
    expected = 475
    assert_equal expected, actual
  end

  def test_all
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.all.count
    expected = 475
    assert_equal expected, actual
  end

  def test_find_by_id
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_by_id(12334123).id
    expected = 12334123
    assert_equal expected, actual
  end

  def test_find_by_name
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_by_name("Keckenbauer").name
    expected = "Keckenbauer"
    assert_equal expected, actual
  end

  def test_find_all_by_name
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    actual = mr.find_all_by_name("bauer")[0].name
    expected = "Keckenbauer"
    assert_equal expected, actual
  end

  def test_delete
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    assert_equal 475, mr.collection.length
    mr.delete(12334123)
    actual = mr.collection.length
    expected = 474
    assert_equal expected, actual
  end

  def test_create
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    mr.create({:name=>"Melvin"})
    newdude = mr.collection.max_by {|element| element.id}
    actual = newdude.id
    expected = 12337412
    assert_equal expected, actual
  end

  def test_update
    mr = MerchantRepository.new('./data/merchants_tiny.csv')
    mr.update(12334123, {:name => "Keckenbooty"})
    updated_item = mr.find_by_id(12334123)
    assert_equal "Keckenbooty", updated_item.name
  end

end
