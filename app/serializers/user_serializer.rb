class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :created_at, :first_name, :last_name, :admin
end
