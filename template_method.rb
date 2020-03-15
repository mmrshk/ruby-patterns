# Do not mix things that changes with things that not changes
# General idea of the Template Method is to build an abstract base class with a skeletal method.
# This skeletal method (template method) drives the bit of the processing that needs to vary, but it does so by making
# calls to abstract methods, which are then supplied by the concrete subclasses.


class BaseLink
  def initialize(**options)
    @options = options
  end

  def call
    default_link + '?' + "$desktop_url=#{desktop_url}" + '&' + "data_key=#{data_key}" + '&'+ additional_options.to_query
  end

  def default_link
    raise NotImplementedError
  end

  def desktop_url
    raise NotImplementedError
  end

  def data_key
    raise NotImplementedError
  end

  def additional_options
    {}
  end
end

class ReviewsLink < BaseLink
  def default_link
    'https://somelink'
  end

  def desktop_url
    "for-desktop/item"
  end

  def data_key
    'reviews'
  end

  def additional_options
    {
      review_id: @options[:review_id]
    }
  end
end

puts ReviewsLink.new({ review_id: '1' }).call
