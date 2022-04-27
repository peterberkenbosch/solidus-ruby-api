module SolidusApi
  class TaxonomyResource < Resource
    def list(**params)
      response = get_request("taxonomies", params: params)
      Collection.from_response(response, key: "taxonomies", type: Taxonomy)
    end

    def retrieve(taxonomy_id:)
      Taxonomy.new get_request("taxonomies/#{taxonomy_id}").body
    end

    def create(**attributes)
      Taxonomy.new post_request("taxonomies", body: attributes).body
    end
  end
end
