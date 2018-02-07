class AuthenticationController < ApplicationController

  def register
    employee = Employee.new(register_params)
    begin
      employee.unique_id = get_unique_id
      employee.save!
      render json: {employee: employee.as_json(except: [:password_digest])}, status: :created
    rescue Exception => e
      render json: {error: e.message}, status: :bad_request
    end
  end

  def authenticate
    employee = Employee.find_by(email: authenticate_params[:email]).try(:authenticate, authenticate_params[:password])
    if employee
      render json: payload(employee), status: :ok
    else
      render json: {message: "invalid email or password"}
    end
  end


  private

    def authenticate_params
      params.permit(:email, :password)
    end

    def register_params
      params.permit(:email, :name, :password, :mobile_no, :admin)
    end

    def get_unique_id
      temp = SecureRandom.urlsafe_base64(4).upcase
      employee = Employee.find_by(unique_id: temp)
      return temp if employee.nil?
      get_employee_id
    end
end
