module ShopifyFilter
  def img_url(product, size)
    "http://placehold.it/600x600"
  end

  def handle(string)
    string.to_handle
  end

  def link_to(link, url, title="")
    %|<a href="#{url}" title="#{title}">#{link}</a>|
  end

  def money_with_currency(money)
    return '' if money.nil?
    sprintf("$ %.2f USD", money/100.0)
  end

  def money(money)
    return '' if money.nil?
    sprintf("$ %.2f", money/100.0)
  end

  def json(object)
    object.to_json
  end

  def url_for_vendor(vendor_title)
    "/collections/#{vendor_title.to_handle}"
  end

  def money_without_currency(money)
    sprintf("%.2f", money.to_i/100.0)
  end

  def asset_url(file)
    "/assets/#{file}"
  end

  def global_asset_url(file)
    "//cdn.shopify.com/s/global/#{file}"
  end

  def shopify_asset_url(file)
    "//cdn.shopify.com/s/shopify/#{file}"
  end

  def pluralize(input, singular, plural)
    input == 1 ? singular : plural
  end

  def stylesheet_tag(input)
    "<link href='#{input}' rel='stylesheet' type='text/css' media='all' />"
  end

  def script_tag(input)
    "<script src='#{input}' type='text/javascript'></script>"
  end

  def img_tag(input, alt = nil)
    "<img src='#{input}' alt='#{alt}' />"
  end

  def payment_type_img_url(payment_type)
    hash = {
        "american_express" => "6a053454b9faf749b3b6cc9c1a142f8c",
        "diners_club" => "2f76e5b1d65e014724327a889e368245",
        "discover" => "f5acbcb01ca0a55387e9c8ba5779fdea",
        "jcb" => "35d65973d2227ad8080ef34924532e65",
        "master" => "6012bd85b8bb09d151918c32cab7dced",
        "visa" => "2ee15ada9959741752262f905db4d82a"
    }[payment_type]

    "//cdn.shopify.com/s/assets/global/payment_types/creditcards_#{payment_type}-#{hash}.svg"
  end
end
