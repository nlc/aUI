require 'nokogiri'
require 'net/http'
require 'uri'
require 'pp'
require 'byebug'
require 'yaml'

def fetch(target_url, limit = 10)
  raise 'HTTP redirect stack depth exceeded!' if limit == 0

  begin
    uri = URI.parse(target_url)
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = 'aUIGetter'
    req_options = {
      use_ssl: uri.scheme == "https"
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    case response.code
    when /2\d\d/
      response
    when '301'
      fetch(response['location'], limit - 1)
    else
      raise response.body
      # response.error!
    end
  rescue Errno::ECONNREFUSED
    raise "\033[31mConnection refused while trying to get #{target_url}.\033[0m"
  end
end

def extract_reversalindex(doc)
  doc.xpath('//div[@id="searchresults"]/div[contains(@class, "post")]/div[contains(@class, "reversalindexentry")]').map do |post_element|
    english = post_element.at_xpath('./span[contains(@class, "reversalform")]/span').text.chomp
    foreigns =
      post_element.xpath('./span[contains(@class, "referringsenses")]/span[contains(@class, "sensecontent")]/span[contains(@class, "referringsense")]').map do |referringsense_element|
        headword = referringsense_element.at_xpath('./span[contains(@class, "headword")]/span[1]')&.text&.chomp
        part_of_speech = referringsense_element.at_xpath('./span[contains(@class, "morphosyntaxanalysis")]')&.text&.chomp
        definition = referringsense_element.at_xpath('./span[contains(@class, "definition")]')&.text&.chomp

        {headword => {'part_of_speech' => part_of_speech, 'definition' => definition}}
      end

    [english, foreigns]
  end.to_h
end

main_url = 'https://www.webonary.work/aui/browse/browse-english/'
target_url = main_url

# Get list of starting letters
response = fetch(target_url)
html = response.body
doc = Nokogiri::HTML(html)
doc.remove_namespaces!
starting_letters = doc.xpath('//div[contains(@class, "lpTitleLetterCell")]').map do |starting_letter_div|
  starting_letter_div.text.gsub(/[[:space:]]/, '')
end

starting_letters.each do |starting_letter|
  response = fetch("#{main_url}?letter=#{starting_letter}&key=en")
  html = response.body
  letter_doc = Nokogiri::HTML(html)
  letter_doc.remove_namespaces!

  puts extract_reversalindex(letter_doc).to_yaml
  next_page_url = letter_doc.at_xpath('//div[@id="wp_page_numbers"]/ul/li[last()]/a')&.attr('href')
  until next_page_url.nil?
    response = fetch("#{main_url}#{next_page_url}")
    html = response.body
    letter_doc = Nokogiri::HTML(html)
    letter_doc.remove_namespaces!
    puts extract_reversalindex(letter_doc).to_yaml

    last_page_link_element = letter_doc.at_xpath('//div[@id="wp_page_numbers"]/ul/li[last()]')
    if (!last_page_link_element.nil?) && last_page_link_element['class'] =~ /active_page/
      next_page_url = nil
    else
      next_page_url = last_page_link_element.at_xpath('./a').attr('href')
    end

    sleep 1
  end
end
