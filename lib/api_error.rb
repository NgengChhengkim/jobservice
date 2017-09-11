module APIError
  class Base < StandardError
    include ActiveModel::Serialization

    attr_reader :code, :message

    def initialize args = {}
      @error = self.class.name.underscore.gsub(%r{\/}, ".")
      error_type = I18n.t @error
      error_type.each do |attr, value|
        instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end

  module SignIn
    class InvalidInfo < APIError::Base
    end

    class NoneActivate < APIError::Base
    end
  end

  module DoorkeeperToken
    class InvalidToken < APIError::Base
    end
  end

  module SignOut
    class InvalidToken < APIError::Base
    end
  end
end
