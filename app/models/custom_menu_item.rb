class CustomMenuItem < Hashie::Dash
  property :body
  property :url
  property :title

  def initialize(*args)
    options = args.extract_options!
    options[:body] = args[0] if args.length > 0
    options[:url] = args[1] if args.length > 1
    options[:title] = args[2] if args.length > 2
    super(options.symbolize_keys)
  end

  def to_s
    [body, url, title].compact.join(',')
  end

  def blank?
    to_s.blank?
  end

  def valid?
    body.present? && url.present?
  end
end
