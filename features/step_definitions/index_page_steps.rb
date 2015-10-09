Given(/^I visit "([^"]*)"$/) do |arg1|
  visit "/"
end

Then(/^I should see an input field for an url$/) do
  page.body.should have_xpath("//input[@id='url']")
end

Then(/^I should see a "([^"]*)" button$/) do |button_name|
  page.body.should have_xpath("//input[@id='submit'][@value='#{button_name}']")
end

When(/^I enter a long url into the input field$/) do
  fill_in "url", :with => "http://www.thisisaverylongwebsiteurladdress.com/that-does-not-exist"
end

Then(/^I should see a link to the shortened url$/) do
  page.body.should have_xpath("//div[@class='result']/a")
end

Given(/^A "([^"]*)" short url exists and is assigned "([^"]*)"$/) do |short_url, long_url|
  Redis.new.setnx "links:#{short_url}", long_url
end

Given(/^I visit a short url with "([^"]*)"$/) do |short_url|
  visit "/a2Cy5pn"
end

Then(/^I should be redirect to "([^"]*)"$/) do |long_url|
  page.current_url.should eq("#{long_url}/")
end