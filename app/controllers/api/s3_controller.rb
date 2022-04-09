class Api::S3Controller < Api::ApplicationController
    def presigned_url
        resource = S3_BUCKET.presigned_post(
            key: "uploads/post/#{SecureRandom.uuid}/${filename}",
            success_action_status: '201',
            acl: 'public-read',
            content_length_range: 1..(10.megabytes)
          )
          render json: { url: resource.url, fields: resource.fields }
    end
end