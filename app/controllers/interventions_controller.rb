class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
  before_action :is_employee? #method for check is the current user is a employee
     


def Intervention  
    
  Intervention.create(
      # author: Employee.where(admin_user_id: current_admin_user.id).first.id,
      author: params[:sel_customer],
      customer_id: params[:sel_customer],
      building_id: params[:sel_building],
      battery_id: params[:sel_battery],
      column_id: params[:sel_column],
      report: params[:sel_description],
      employee_id: params[:sel_employee],
      elevator_id: params[:sel_elevator])
      
      redirect_to '/', notice: "Intervention created successfully"
      
  end


  def intervention_params
      params.permit(
                      :author,
                      :customer_id,
                      :building_id,
                      :battery_id,
                      :column_id,
                      :report,
                      :employee_id,
                      :elevator_id
      )
  end

    # GET /interventions
  # GET /interventions.json
  def index
    @interventions = Intervention.all
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
  end

  def create
    @intervention = Intervention.new(intervention_params)

    # Get format name of employee connected
    employee = current_user.employee.full_name

    # Give the id of the employee connected
    @intervention.author_id = current_user.employee.id

    # Data get for zendesk ticket
    battery_id = @intervention.battery_id
    column_id = @intervention.column_id
    elevator_id = @intervention.elevator_id

    # Condition for null ids not required
    if @intervention.elevator_id
      @intervention.battery_id = nil
      @intervention.column_id = nil
    elsif @intervention.column_id
      @intervention.battery_id = nil
    end

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to '/interventions/new', notice: 'Intervention was successfully created.' }
        format.json { render :show, status: :created, location: @intervention }

        # Call method for create a zendesk ticket
        helpers.ticket_intervention(@intervention, employee, battery_id, column_id, elevator_id)
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

end
