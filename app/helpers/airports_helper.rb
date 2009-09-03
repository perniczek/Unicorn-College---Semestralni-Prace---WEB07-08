module AirportsHelper
  def gps_position(gps_object, gps_attr)
    result = ''
    
    gps_value = eval "@#{gps_object}.#{gps_attr}"
    gps_values_a = /([0-9]{1,2})°([0-9]{1,2})′([0-9]{1,2})″([NS]) ([0-9]{1,2})°([0-9]{1,2})′([0-9]{1,2})″([EW])/.match(gps_value).to_a
    
    result += select_tag "#{gps_object}[#{gps_attr}][lat_deg]", options_for_select((0..180),gps_values_a[1].to_i) 
    result += "°"
    result += select_tag "#{gps_object}[#{gps_attr}][lat_min]", options_for_select((0..60),gps_values_a[2].to_i) 
    result += "'"
    result += select_tag "#{gps_object}[#{gps_attr}][lat_sec]", options_for_select((0..60),gps_values_a[3].to_i) 
    result += '"'
    result += select_tag "#{gps_object}[#{gps_attr}][lat_dir]", options_for_select(['N','S'],gps_values_a[4])
    result += '&nbsp;&nbsp;'
    result += select_tag "#{gps_object}[#{gps_attr}][lon_deg]", options_for_select((0..90),gps_values_a[5].to_i) 
    result += "°"
    result += select_tag "#{gps_object}[#{gps_attr}][lon_min]", options_for_select((0..60),gps_values_a[6].to_i) 
    result += "'"
    result += select_tag "#{gps_object}[#{gps_attr}][lon_sec]", options_for_select((0..60),gps_values_a[7].to_i) 
    result += '"'
    result += select_tag "#{gps_object}[#{gps_attr}][lon_dir]", options_for_select(['E','W'],gps_values_a[8])
    
    return result
  end
  
  def gps_position_decode(gps_object, gps_attr)
    lat_deg = params[gps_object][gps_attr][:lat_deg]
    lat_min = params[gps_object][gps_attr][:lat_min]
    lat_sec = params[gps_object][gps_attr][:lat_sec]
    lat_dir = params[gps_object][gps_attr][:lat_dir]
    
    lon_deg = params[gps_object][gps_attr][:lon_deg]
    lon_min = params[gps_object][gps_attr][:lon_min]
    lon_sec = params[gps_object][gps_attr][:lon_sec]
    lon_dir = params[gps_object][gps_attr][:lon_dir]
    
    gps_value = "#{lat_deg}°#{lat_min}′#{lat_sec}\″#{lat_dir} #{lon_deg}°#{lon_min}′#{lon_sec}\″#{lon_dir}"
    params[gps_object][gps_attr] = gps_value
  end
  
end
