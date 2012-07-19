module ArrayMaker
  extend ActiveSupport::Concern

  module ClassMethods
    def ids_from(collection_or_member)
      map_field_from_collection_or_member(:id, collection_or_member)
    end

    def map_field_from_collection_or_member(field, collection_or_member)
      collection_or_member.kind_of?(Array) ? collection_or_member.map(&field) : [collection_or_member.send(field)]
    end

    def array_from(array_or_single)
      array_or_single.kind_of?(Array) ? array_or_single : [array_or_single]
    end
  end

  # Instace method alias for class method
  def ids_from(collection_or_member)
    self.class.ids_from(collection_or_member)
  end
end