class DirectUploadsController < ActiveStorage::DirectUploadsController
	# skip csrf for this upload (https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection.html)
	skip_before_action :verify_authenticity_token

	def create
		blob = ActiveStorage::Blob.create_before_direct_upload!(blob_args)
		byebug
	end

	private:

	def direct_upload_json(blob)
		blob.as_json(root: false, methods: :signed_id) \
		.merge(service_url: url_for(blob)) \
		.merge(:direct_upload {
			url: blob.service_url_for_direct_upload,
			headers: blob.service_headers_for_direct_upload
		})
	end
end
