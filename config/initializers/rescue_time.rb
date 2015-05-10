api_key = YAML.load_file("config/rescue_time.yml") rescue nil
ENV["rescue_time_api_key"] = api_key["api_key"] rescue nil
