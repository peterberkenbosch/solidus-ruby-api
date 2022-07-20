require "test_helper"

class TaxonResourceTest < Minitest::Test
  def test_list
    stub = stub_request("taxons", response: stub_response(fixture: "taxons/list"))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"

    taxons = client.taxon.list
    assert_equal SolidusApi::Collection, taxons.class
    assert_equal SolidusApi::Taxon, taxons.data.first.class
    assert_equal 11, taxons.total_count
  end

  def test_create
    body = {name: "FooBarsz"}
    stub = stub_request("taxonomies/3/taxons", method: :post, body: body, response: stub_response(fixture: "taxons/create", status: 201))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"
    taxon = client.taxon.create(taxonomy_id: 3, **body)

    assert_equal "FooBarsz", taxon.name
    assert_equal "Test -> FooBarsz", taxon.pretty_name
    assert_equal "test/foobarsz", taxon.permalink
  end

  def test_create_with_parent
    body = {name: "BeebBup", parent_id: 13}
    stub = stub_request("taxonomies/3/taxons", method: :post, body: body, response: stub_response(fixture: "taxons/create_with_parent", status: 201))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"
    taxon = client.taxon.create(taxonomy_id: 3, **body)

    assert_equal "BeebBup", taxon.name
    assert_equal "Test -> FooBarsz -> BeebBup", taxon.pretty_name
    assert_equal "test/foobarsz/beebbup", taxon.permalink
  end

  def test_update
    body = {name: "New Name"}
    stub = stub_request("taxonomies/3/taxons/13", method: :patch, body: body, response: stub_response(fixture: "taxons/update", status: 200))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"
    taxon = client.taxon.update(taxonomy_id: 3, taxon_id: 13, **body)

    assert_equal "New Name", taxon.name
    assert_equal "Test -> New Name", taxon.pretty_name
    assert_equal "test/foobarsz", taxon.permalink
  end
end
