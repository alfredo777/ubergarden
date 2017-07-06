class AdminsController < ApplicationController
  layout 'admin'
  before_filter :admin_filter, except: [:login_admin, :verify_pass]
  def admin
  	if session[:admin] == nil
  	redirect_to login_path
    else
    redirect_to products_path
    end
  end

  def login_admin
  end

  def verify_pass
  	@admin = Admin.find_by_email(params[:email])
  	pass_b =  Digest::SHA2.hexdigest(params[:password]) 
  	puts "#{@admin.password } == #{pass_b}"
  	if @admin.password == pass_b
      puts "Ingresando .../"
  		session[:admin] = @admin.token
  		flash[:notice] = "Ingreso Correcto"
  		redirect_to products_path
  	else
  		puts "¡ Error al ingresar !"
  		flash[:notice] = "Error al ingresar"
  		redirect_to :back
  	end
  end
  
  def log_out
  	session[:admin] = nil
  	redirect_to login_path
  end
  def index
  	@admins = Admin.all
  end

  def new
  end

  def create
  	password = Digest::SHA2.hexdigest(params[:password]) 
  	@admin = Admin.new
  	@admin.password = password
  	@admin.name = params[:name]
  	@admin.email = params[:email]
  	@admin.token = "tok_#{SecureRandom.hex(7)}"
  	@admin.salt = SecureRandom.hex(17)
  	@admin.save

  	if @admin.save 
  		flash[:notice] = "Adminstrador creado correctamente"
  	else
  		flash[:notice] = "El admnistrador no ha podido ser creado"
  	end

  	redirect_to admins_path
  end

  def destroy
  	admin = Admin.find(params[:id])
  	admin.destroy

  	redirect_to admins_path
  end

  def edit
  	@admin = Admin.find(params[:id])
  end

  def update_admin
  	@admin = Admin.find(params[:id])
  	if params[:password] != ''
  		password = Digest::SHA2.hexdigest(params[:password]) 
  		@admin.password = password
    end
  	@admin.name = params[:name]
  	@admin.email = params[:email]
  	@admin.save

  	redirect_to :back
  end
end
