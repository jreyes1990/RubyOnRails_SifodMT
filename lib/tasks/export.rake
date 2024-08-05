namespace :export do
    desc "Exporta datos para ser usados en un seeds.rb. Uso: rake export:seeds_format[NombreDelModelo]"
    
    task :seeds_format, [:model_name] => :environment do |t, args|
      model_name = args[:model_name]
      
      unless model_name
        puts "Por favor especifica un nombre de modelo. Por ejemplo, rake export:seeds_format[User]"
        exit
      end
  
      begin
        model_class = model_name.constantize
      rescue NameError
        puts "El modelo #{model_name} no existe."
        exit
      end
  
      records_array = []
      model_class.order(:id).all.each do |record|
        records_array << formatted_output(record)
      end
  
      puts "#{model_name}.create!([\n  #{records_array.join(",\n  ")}\n])"
    end
    
    def formatted_output(record)
      formatted_hash = record.attributes.transform_keys(&:to_sym).except(:id, :created_at, :updated_at, :raw_rnum_)
      "{ " + formatted_hash.map { |k, v| "#{k}: #{value_formatter(v)}" }.join(", ") + " }"
    end

    def value_formatter(value)
      case value
      when String
        "\"#{value}\""
      when Date, Time, ActiveSupport::TimeWithZone
        "\"#{value.to_s(:db)}\""
      when NilClass
        "nil"
      else
        value.to_s
      end
    end
end
  