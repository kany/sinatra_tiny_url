Feature: Url Shortening App
  As an app user
  I would like to shorten long urls

Scenario: A user wants to shorten a long url
  Given I visit "/"
  Then I should see "Sinatra Tiny Url"
  And I should see an input field for an url
  And I should see a "shorten" button
  When I enter a long url into the input field
  And I press "shorten"
  Then I should see "Your shortened URL is:"
  And I should see a link to the shortened url

Scenario: A short url is used
  Given A "a2Cy5pn" short url exists and is assigned "http://www.google.com"
  And I visit a short url with "a2Cy5pn"
  Then I should be redirect to "http://www.google.com"
