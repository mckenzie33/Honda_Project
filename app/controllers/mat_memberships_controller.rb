class MatMembershipsController < ApplicationController
  before_action :set_mat_membership, only: [:show, :edit, :update, :destroy]
  before_action :check_access, only: [:edit, :update, :create, :new, :destroy, :index, :show]

  # GET /mat_memberships
  # GET /mat_memberships.json
  def index
    @mat_memberships = MatMembership.all
  end

  # GET /mat_memberships/1
  # GET /mat_memberships/1.json
  def show
  end

  # GET /mat_memberships/new
  def new
    @mat_membership = MatMembership.new
  end

  # GET /mat_memberships/1/edit
  def edit
  end

  # POST /mat_memberships
  # POST /mat_memberships.json
  def create
    @mat_membership = MatMembership.new(mat_membership_params)

    respond_to do |format|
      if @mat_membership.save
        format.html { redirect_to @mat_membership, notice: 'Mat membership was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mat_membership }
      else
        format.html { render action: 'new' }
        format.json { render json: @mat_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mat_memberships/1
  # PATCH/PUT /mat_memberships/1.json
  def update
    respond_to do |format|
      if @mat_membership.update(mat_membership_params)
        format.html { redirect_to @mat_membership, notice: 'Mat membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mat_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mat_memberships/1
  # DELETE /mat_memberships/1.json
  def destroy
    @mat_membership.destroy
    respond_to do |format|
      format.html { redirect_to mat_memberships_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mat_membership
      @mat_membership = MatMembership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mat_membership_params
      params.require(:mat_membership).permit(:material_id, :group_id, :is_confirmed, :requested_by, :comments)
    end

    def check_access
	if not (is_admin? or is_group_admin?)
		if signed_in?
			redirect_to(current_user, :notice => "You tried to access a wrong link, please try again!")
		else
			redirect_to(root, :notice => "You tried to access a wrong link, please try again!")
		end
	end
    end
end
