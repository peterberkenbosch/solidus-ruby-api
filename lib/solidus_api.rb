require "faraday"
require "faraday_middleware"
require "solidus_api/version"

module SolidusApi
  autoload :Client, "solidus_api/client"
  autoload :Error, "solidus_api/error"
  autoload :Object, "solidus_api/object"
  autoload :Resource, "solidus_api/resource"
  autoload :Collection, "solidus_api/collection"

  autoload :TaxonomyResource, "solidus_api/resources/taxonomy"
  autoload :Taxonomy, "solidus_api/objects/taxonomy"

  autoload :TaxonResource, "solidus_api/resources/taxon"
  autoload :Taxon, "solidus_api/objects/taxon"

  autoload :ProductResource, "solidus_api/resources/product"
  autoload :Product, "solidus_api/objects/product"
end
