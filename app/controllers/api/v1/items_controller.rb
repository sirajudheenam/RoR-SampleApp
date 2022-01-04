#item_controller.rb

class Api::V1::ItemsController < Api::V1::BaseController
	protect_from_forgery with: :null_session, only: [:create]
	def index
		respond_with Item.all
		# curl -X GET -H "Content-Type: application/json" http://localhost:3000/api/v1/items
		# curl -G http://localhost:3000/api/v1/items
	end

	def create
		respond_with :api , :v1, Item.create(item_params)
		# curl -X POST -H "Content-Type: application/json"	-d '{"name": "ZearchEngine", "description": "A weird Zearch Engine created today"}' http://localhost:3000/api/v1/items
	end

	def destroy
		respond_with Item.destroy(params[:id])
		# curl -X DELETE -H "Content-Type: application/json" http://localhost:3000/api/v1/items/7
	end

	def update
		item = Item.find(params["id"])
		item.update_attributes(item_params)
		respond_with item, json: item
		# curl -X PUT -H "Content-Type: application/json" -d "name=Bing Engine" http://localhost:3000/api/v1/items/7
	end

	private

	def item_params
		params.require(:item).permit(:id, :name, :description)
	end

end
