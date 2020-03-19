class BaseLink
  attr_accessor :link, :default_link, :desktop_url

  def initialize(link)
    @default_link = 'https://somelink'
    @desktop_url = 'for-desktop/item'
    @link = link
  end

  def build
    @link.build(self)
  end
end

class ReviewsLink
  def build(context)
    context.default_link + '?' + "$desktop_url=#{context.desktop_url}" + '&' + "data_key=#{data_key}"
  end

  def data_key
    'reviews'
  end
end

class RestaurantsLink
  def build(context)
    context.default_link + '?' + "$desktop_url=#{context.desktop_url}" + '&' + "data_key=#{data_key}"
  end

  def data_key
    'restaurants'
  end
end

reviews_link = BaseLink.new(ReviewsLink.new)
puts reviews_link.build

restaurants_link = BaseLink.new(RestaurantsLink.new)
puts restaurants_link.build
