require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
Capybara.configure do |c|
  c.javascript_driver = :poltergeist
  c.default_driver = :poltergeist
end

module MyCapybaraTest
  class Test
    include Capybara::DSL

    def initialize()
      @links_main_page =[]
      @data = Hash.new
      @id =0
    end

    def getMainPageLinks
      visit('http://stuerzer.de/index.php/home-en.html')
      @links_main_page = all('tbody a').map { |v| v[:href] }
    end

    def visitEachLinksAndGetData
      @links_main_page.each do |link|
        visit(link)

        begin
          @category = find('section.ce_text.block:nth-child(3) h1', match: :prefer_exact).text
        rescue
          @category = 'Page is empty'
        end
        @data[@category] = Hash.new
        all = all('div.shortDescription')
        all.each do |desc|
          key = desc.all('strong')
          keys =key.map { |k|  k.text }
          @data[@category][@id] = Hash.new
          hashbuilder(keys, desc)
          @id+=1
        end

      end
    end


    def showData
      p @data
    end

    private
    def hashbuilder(keys, value)

      keys.each_with_index do |key, index|
        if index+1 < keys.size
          x = value.text.index(keys[index])+keys[index].length
          y = value.text.index(keys[index+1])
          val = value.text[x..y-1]
          @data[@category][@id][key.strip] = val.strip
        else
          x = value.text.index(keys[index])+keys[index].length
          y = value.text.length
          val = value.text[x..y-1]
          @data[@category][@id][key] = val
        end
      end
    end
  end
end

t = MyCapybaraTest::Test.new
t.getMainPageLinks
t.visitEachLinksAndGetData
t.showData