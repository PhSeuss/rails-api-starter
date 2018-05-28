class V1::ResourcesController < V1::ApiController
  before_action :require_login
  def index
    render json: {data: 'here your data'}
  end
end
