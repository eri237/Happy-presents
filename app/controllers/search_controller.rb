class SearchController < ApplicationController

	def search
	  @records = Item.search_for(@content)
	end

end
