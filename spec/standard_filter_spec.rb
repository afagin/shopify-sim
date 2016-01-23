require_relative './helper'

describe StandardFilters do
  include StandardFilters

  it "tests img_url" do
    expect(img_url(nil, "pico")).to eq("http://placehold.it/16x16")
    expect(img_url(nil, "compact")).to eq("http://placehold.it/160x160")
    expect(img_url(nil, "asdf")).to eq("http://placehold.it/300x300?text=invalid+size")
  end

  it "tests size" do
    expect(size([1,2,3])).to eq(3)
    expect(size([])).to eq(0)
    expect(size(nil)).to eq(0)
  end

  it "tests downcase" do
    expect(downcase("Testing")).to eq('testing')
    expect(downcase(nil)).to eq('')
  end

  it "tests upcase" do
    expect(upcase("Testing")).to eq('TESTING')
    expect(upcase(nil)).to eq('')
  end

  it "tests upcase" do
    expect(upcase("Testing")).to eq('TESTING')
    expect(upcase(nil)).to eq('')
  end

  it "tests truncate" do
    expect(truncate('1234567890', 7)).to eq('1234...')
    expect(truncate('1234567890', 20)).to eq('1234567890')
    expect(truncate('1234567890', 0)).to eq('...')
    expect(truncate('1234567890')).to eq('1234567890')
  end

  it "tests escape" do
    expect(escape('<strong>')).to eq('&lt;strong&gt;')
    expect(h('<strong>')).to eq('&lt;strong&gt;')
  end

  it "tests truncatewords" do
    expect(truncatewords('one two three', 4)).to eq('one two three')
    expect(truncatewords('one two three', 2)).to eq('one two...')
    expect(truncatewords('one two three')).to eq('one two three')
    expect(truncatewords('Two small (13&#8221; x 5.5&#8221; x 10&#8221; high) baskets fit inside one large basket (13&#8221; x 16&#8221; x 10.5&#8221; high) with cover.', 15)).to eq('Two small (13&#8221; x 5.5&#8221; x 10&#8221; high) baskets fit inside one large basket (13&#8221;...')
  end

  it "tests strip_html" do
    expect(strip_html("<div>test</div>")).to eq('test')
    expect(strip_html("<div id='test'>test</div>")).to eq('test')
    expect(strip_html(nil)).to eq('')
  end

  it "tests join" do
    expect(join([1,2,3,4])).to eq('1 2 3 4')
    expect(join([1,2,3,4], ' - ')).to eq('1 - 2 - 3 - 4')
  end

  it "tests sort" do
    expect(sort([4,3,2,1])).to eq [1,2,3,4]
  end

  it "tests date" do
    expect(date(Time.parse("2006-05-05 10:00:00"), "%B")).to eq('May')
    expect(date(Time.parse("2006-06-05 10:00:00"), "%B")).to eq('June')
    expect(date(Time.parse("2006-07-05 10:00:00"), "%B")).to eq('July')

    expect(date("2006-05-05 10:00:00", "%B")).to eq('May')
    expect(date("2006-06-05 10:00:00", "%B")).to eq('June')
    expect(date("2006-07-05 10:00:00", "%B")).to eq('July')

    expect(date("2006-07-05 10:00:00", "")).to eq('2006-07-05 10:00:00')
    expect(date("2006-07-05 10:00:00", "")).to eq('2006-07-05 10:00:00')
    expect(date("2006-07-05 10:00:00", "")).to eq('2006-07-05 10:00:00')
    expect(date("2006-07-05 10:00:00", nil)).to eq('2006-07-05 10:00:00')

    expect(date("2006-07-05 10:00:00", "%m/%d/%Y")).to eq('07/05/2006')

    expect(date("Fri Jul 16 01:00:00 PDT 2004", "%m/%d/%Y")).to eq("07/16/2004")

    expect(date(nil, "%B")).to eq(nil)
    expect(date("now", "%Y")).to match /^\d{4}$/
  end

  it "tests first_last" do
    expect(first([1,2,3])).to eq(1)
    expect(last([1,2,3])).to eq(3)
    expect(first([])).to eq(nil)
    expect(last([])).to eq(nil)
  end

  it "tests replace" do
    expect(replace("a a a a", 'a', 'b')).to eq('b b b b')
    expect(replace_first("a a a a", 'a', 'b')).to eq('b a a a')
  end

  it "tests remove" do
    expect(remove("a a a a", 'a')).to eq('   ')
    expect(remove_first("a a a a", 'a ')).to eq('a a a')
  end

  # it "tests strip_newlines" do
  #   assert_template_result 'abc', "{{ source | strip_newlines }}", 'source' => "a\nb\nc"
  # end
  #
  # it "tests newlines_to_br" do
  #   assert_template_result "a<br />\nb<br />\nc", "{{ source | newline_to_br }}", 'source' => "a\nb\nc"
  # end
  #
  # it "tests append" do
  #   assigns = {'a' => 'bc', 'b' => 'd' }
  #   assert_template_result('bcd',"{{ a | append: 'd'}}",assigns)
  #   assert_template_result('bcd',"{{ a | append: b}}",assigns)
  # end
  #
  # it "tests prepend" do
  #   assigns = {'a' => 'bc', 'b' => 'a' }
  #   assert_template_result('abc',"{{ a | prepend: 'a'}}",assigns)
  #   assert_template_result('abc',"{{ a | prepend: b}}",assigns)
  # end
  #
end
