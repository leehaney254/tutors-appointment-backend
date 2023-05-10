class Api::V1::TutorsController < ApplicationController
  before_action :authorized
  before_action :set_tutor, only: %i[show update destroy]

  # GET /tutors
  def index
    @tutors = Tutor.all

    if @tutors.empty?
      render json: { message: 'There are no tutors!' }, status: :not_found
    else
      render json: @tutors
    end
  end

  # GET /tutors/1
  def show
    if @tutor
      render json: @tutor
    else
      render json: 'The user you are trying to find does not exist'
    end
  end

  # POST /tutors
  def create
    @tutor = Tutor.new(tutor_params)

    if @tutor.save
      render json: { message: 'Created successfully' }, status: :created
    else
      render json: @tutor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tutors/1
  def update
    if @tutor.update(tutor_params)
      render json: { message: 'Updated successfully' }
    else
      render json: @tutor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tutors/1
  def destroy
    @tutor.destroy
    return unless @tutor

    @tutor.destroy
    render json: { message: 'Deleted successfully' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tutor
    @tutor = Tutor.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @tutor = nil
  end

  # Only allow a list of trusted parameters through.
  def tutor_params
    params.require(:tutor).permit(:name, :image, :speciality, :bio, :price)
  end
end
