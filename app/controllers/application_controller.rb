class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :mobile_device?
  helper_method :admin_filter
  helper_method :transport_cost
  helper_method :random_offer_products
  helper_method :transport_cost_by_cuanty


  def mobile_device?
    result  = request.env['HTTP_USER_AGENT']
    puts result
      if result =~ /iPhone|Android|iPad/
        @browser = "Mobile"
        @mobile = true
      else
      case 
      when result =~ /Chrome/
        @browser = "Google Chrome"
        @mobile = false
      when result =~ /Firefox/
        @browser = "Firefox"
        @mobile = false
      when result =~ /Safari/
        @browser = "Safari"
        @mobile = false
      when result =~ /MSIE/
        @browser = "Internet Explorer"
        @mobile = false        
      end 
      end
    puts "********************** #{@browser} / Mobile: #{@mobile} ************************" 
       @mobile
  end

  def random_offer_products
    @products_offer = Product.where("oferta > 0").where(publicado: true).order("RANDOM()").limit(2)
  end

  def admin_filter
    if session[:admin] == nil
      redirect_to login_path
    end
  end 

  def transport_cost_by_cuanty(qdep)
   factor_inicial = 60
   transport = qdep.to_f * 0.33
   transport = factor_inicial + transport #- (transport * 0.25)
   transport = transport.round(2)
  end

  def transport_cost(qdep)
   fixed_cost = {
      salary: 10000,
      secure: 5000
    }

    variable_cost = {
      gasoline: (17.28*0.30)+17.28,
      mantemince: 5000,
      neumatics: 2500 * 4,
      oil: 1800
    }

    day_route_kilometers = 360
    day_salary = fixed_cost[:salary]/30
    day_secure = fixed_cost[:secure]/30
    gasoline_day = variable_cost[:gasoline] * (day_route_kilometers/8)
    puts "Day Gasoline #{gasoline_day}"
    distance_to_mantamance = day_route_kilometers.to_f/25000.to_f
    puts "Porcent to mantemince #{distance_to_mantamance.to_f}"
    mantamance_daily_cost = variable_cost[:mantemince] * distance_to_mantamance 
    puts "mantemince daily cost #{mantamance_daily_cost}"
    oil_daily = variable_cost[:oil] * distance_to_mantamance.to_f
    neumatic_devast_cost = day_route_kilometers.to_f/100000.to_f
    puts "Neumatic devast #{neumatic_devast_cost.to_f}"
    neumatic_devast_cost = variable_cost[:neumatics] * neumatic_devast_cost
    puts "Neumatic devast #{neumatic_devast_cost}"
    broute_variable_cost = gasoline_day + mantamance_daily_cost + oil_daily + neumatic_devast_cost + neumatic_devast_cost
    broute_fixed_cost = day_salary + day_secure
    puts "Varaible Cost in broute #{broute_variable_cost}"
    puts "Fixed cost in broute #{broute_fixed_cost}"
    value_of_vehicle = 250000
    util_live =  5
    value_rescue = value_of_vehicle / util_live
    factor_rescue = 100/util_live
    puts "Rescue factor #{factor_rescue}"
    deprecate_mont = (factor_rescue * 4)/100.to_f
    active_deprecate_per_year = value_of_vehicle * deprecate_mont
    dayli_active_deprecate_per_year = active_deprecate_per_year / 365
    variable_cost = broute_variable_cost + dayli_active_deprecate_per_year
    puts "Variable cost #{variable_cost}"
    total_cost = broute_fixed_cost + variable_cost
    puts "Total cost #{total_cost}"
    tg = 0.30
    price_transport = (total_cost * tg) + total_cost
    transport_taxes = 0.25 
    price_transport_whit_taxes = (price_transport * transport_taxes) + price_transport
    puts "Price transport $ #{price_transport} MXN"
    puts "Price transport + taxes $ #{price_transport_whit_taxes} MXN"
    min_clients_route = price_transport_whit_taxes / 20
    puts "Quanty clientes or products required to send charge #{min_clients_route.round()}"
    cost_by_client = price_transport_whit_taxes / min_clients_route.round()
    cost_by_client = cost_by_client.to_f/5
    puts "Price for transport $ #{cost_by_client.round(2)} MXN"
    unit_cost =  cost_by_client.to_f * qdep
    unit_cost = unit_cost.round(2)
  end
end
