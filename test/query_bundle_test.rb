require 'test_helper'

class QueryBundleTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::QueryBundle::VERSION
  end

  def test_initialize
    bundle = QueryBundle.new(
      old_apples: old_apples_relation,
      young_apples: young_apples_relation,
      old_bananas: old_bananas_relation,
      young_bananas: young_bananas_relation
    )

    bundle.execute
    assert bundle.executed?
    run_data_assertions(bundle)
  end

  def test_fetch
    bundle = QueryBundle.fetch(
      old_apples: old_apples_relation,
      young_apples: young_apples_relation,
      old_bananas: old_bananas_relation,
      young_bananas: young_bananas_relation
    )
    run_data_assertions(bundle)
  end

  private


  def run_data_assertions(bundle)
    assert bundle.young_apples.size > 0
    assert bundle.old_apples.size > 0

    assert_equal young_apples_relation.all, bundle.young_apples
    assert_equal old_apples_relation.all, bundle.old_apples

    assert bundle.young_bananas.size > 0
    assert bundle.old_bananas.size > 0

    assert_equal young_bananas_relation.all, bundle.young_bananas
    assert_equal old_bananas_relation.all, bundle.old_bananas
  end


  def old_apples_relation
    Apple.where(age: 100)
  end

  def young_apples_relation
    Apple.where(age: 10)
  end

  def old_bananas_relation
    Banana.where(age: 100)
  end

  def young_bananas_relation
    Banana.where(age: 10)
  end

end
