module SolidusApi
  class ProductResource < Resource
    def list(**params)
      response = get_request("products", params: params)
      Collection.from_response(response, key: "products", type: Product)
    end

    def create(**attributes)
      Product.new post_request("products", body: attributes).body
    end

    def retrieve(product_id:)
      Product.new get_request("products/#{product_id}").body
    end

    def update(product_id:, **attributes)
      Product.new patch_request("products/#{product_id}", body: attributes).body
    end
  end
end
