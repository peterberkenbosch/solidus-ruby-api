require "test_helper"

class TaxonomyResourceTest < Minitest::Test
  def test_list
    stub = stub_request("taxonomies", response: stub_response(fixture: "taxonomies/list"))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"

    taxonomies = client.taxonomy.list
    assert_equal SolidusApi::Collection, taxonomies.class
    assert_equal SolidusApi::Taxonomy, taxonomies.data.first.class
    assert_equal 2, taxonomies.total_count
  end

  def test_create
    body = {name: "Test"}
    stub = stub_request("taxonomies", method: :post, body: body, response: stub_response(fixture: "taxonomies/create", status: 201))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"
    taxonomy = client.taxonomy.create(**body)

    assert_equal "Test", taxonomy.name
    assert_equal "test", taxonomy.root.permalink
  end

  def test_update
    body = {name: "Test 2"}
    stub = stub_request("taxonomies/3", method: :patch, body: body, response: stub_response(fixture: "taxonomies/update", status: 200))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"
    taxonomy = client.taxonomy.update(taxonomy_id: 3, **body)

    assert_equal "Test 2", taxonomy.name
    assert_equal "test", taxonomy.root.permalink
  end

  def test_retrieve
    stub = stub_request("taxonomies/3", method: :get, response: stub_response(fixture: "taxonomies/retrieve", status: 200))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"
    taxonomy = client.taxonomy.retrieve(taxonomy_id: 3)

    assert_equal "Categories", taxonomy.name
    assert_equal "categories", taxonomy.root.permalink
    assert_equal 4, taxonomy.root.taxons.count
  end

  def test_delete
    stub = stub_request("taxonomies/3", method: :delete, response: stub_response(fixture: "taxonomies/delete", status: 204))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"

    client.taxonomy.delete(taxonomy_id: 3)
  end

  def test_taxons
    stub = stub_request("taxonomies/2/taxons", method: :get, response: stub_response(fixture: "taxonomies/taxons", status: 200))
    client = SolidusApi::Client.new api_key: "key", adapter: :test, stubs: stub, api_endpoint: "https://localhost:4000/api"

    taxons = client.taxonomy.taxons(taxonomy_id: 2)
    assert_equal SolidusApi::Collection, taxons.class
    assert_equal SolidusApi::Taxon, taxons.data.first.class
    assert_equal 2, taxons.total_count
  end
end
