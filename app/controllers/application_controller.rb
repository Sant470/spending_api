class ApplicationController < ActionController::API

  def authenticate_request
    auth_token = request.headers['Authorization']
    if auth_token
      token = JsonWebToken.decode(auth_token)
      @employee = Employee.find_by(id: token[:employee_id])
      render json: {error: "could not validate the auth token"}, status: :unauthorized if @employee.nil?
    else
      render json: {eroor: "auth token is missing"}, status: :forbidden
    end
  end

  protected

    def payload(employee)
      return nil unless employee and employee.id
      auth_token = generate_jwt_token(employee)
      {
        auth_token: auth_token,
        employee: {
          id: employee.id,
          name: employee.name,
          email: employee.email,
          unique_id: employee.unique_id,
          created_at: employee.created_at,
          updated_at: employee.updated_at
        }
      }
    end

    def generate_jwt_token employee
      JsonWebToken.encode({employee_id: employee.id, exp: Time.now.to_i + 2592000})
    end

end
