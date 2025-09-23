// Refactored for better maintainability
// Refactored for better maintainability
// Refactored for better maintainability
// Refactored for better maintainability
class Api::V1::PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, only: [:show, :update, :destroy]
  
  # GET /api/v1/resource
  def index
    @resources = current_user.resources.page(params[:page]).per(params[:per_page] || 25)
    
    render json: {
      data: @resources,
      meta: pagination_meta(@resources),
      message: 'Data retrieved successfully'
    }
  end
  
  # GET /api/v1/resource/:id
  def show
    render json: {
      data: @resource,
      message: 'Data retrieved successfully'
    }
  end
  
  # POST /api/v1/resource
  def create
    @resource = current_user.resources.build(resource_params)
    
    if @resource.save
      render json: {
        data: @resource,
        message: 'Data created successfully'
      }, status: :created
    else
      render json: {
        errors: @resource.errors,
        message: 'Validation failed'
      }, status: :unprocessable_entity
    end
  end
  
  # PUT /api/v1/resource/:id
  def update
    if @resource.update(resource_params)
      render json: {
        data: @resource,
        message: 'Data updated successfully'
      }
    else
      render json: {
        errors: @resource.errors,
        message: 'Validation failed'
      }, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/v1/resource/:id
  def destroy
    @resource.destroy
    
    render json: {
      message: 'Data deleted successfully'
    }
  end
  
  private
  
  def set_resource
    @resource = current_user.resources.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      error: 'Resource not found',
      message: 'The requested resource does not exist'
    }, status: :not_found
  end
  
  def resource_params
    # TODO: Define permitted parameters
    params.require(:resource).permit(:name, :description)
  end
  
  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
