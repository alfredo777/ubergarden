    fixed_cost = {
      salary: 10000,
      secure: 2000
    }

    variable_cost = {
      gasoline: 16.28*.30+16.28,
      mantemince: 5000,
      neumatics: 2500 * 4,
      oil: 1800
    }

    day_route_kilometers = 350
    day_salary = fixed_cost[:salary]/30
    day_secure = fixed_cost[:secure]/30
    gasoline_day = variable_cost[:gasoline] * day_route_kilometers / 8
    distance_to_mantamance = 10000/day_route_kilometers
    mantamance_daily_cost = variable_cost[:mantemince] * distance_to_mantamance 
    oil_daily = variable_cost[:oil] * distance_to_mantamance
    neumatic_devast_cost = 25000/day_route_kilometers
    neumatic_devast_cost = variable_cost[:neumatics] * neumatic_devast_cost
    broute_variable_cost = gasoline_day + mantamance_daily_cost + oil_daily + neumatic_devast_cost + neumatic_devast_cost
    broute_fixed_cost = day_salary + day_secure
    value_of_vehicle = 250000
    util_live =  5
    value_rescue = 250000 / util_live
    factor_rescue = 100/util_live
    deprecate_mont = factor_rescue * 2
    active_deprecate_per_year = value_of_vehicle * deprecate_mont
    dayli_active_deprecate_per_year = active_deprecate_per_year / 365
    variable_cost = broute_variable_cost + dayli_active_deprecate_per_year
    total_cost = broute_fixed_cost + variable_cost
    tg = .30
    price_transport = (total_cost * Tg) + total_cost
    transport_taxes = .25 
    price_transport_whit_taxes = (price_transport * transport_taxes) + price_transport