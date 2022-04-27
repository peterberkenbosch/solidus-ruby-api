module SolidusApi
  class TaxonResource < Resource
    def list(**params)
      response = get_request("taxons", params: params)
      Collection.from_response(response, key: "taxons", type: Taxon)
    end

    def create(taxonomy_id:, **attributes)
      Taxon.new post_request("taxonomies/#{taxonomy_id}/taxons", body: attributes).body
    end

    def retrieve(taxonomy_id:, taxon_id:)
      Taxon.new get_request("taxonomies/#{taxonomy_id}/taxons/#{taxon_id}").body
    end

    def update(taxon_id:, **attributes)
      Taxon.new patch_request("taxons/#{taxon_id}", body: attributes).body
    end
  end
end
