require 'rubygems'
require 'date'
#require 'mysql'
require 'watir-webdriver'
require 'xml'
#require 'ruby-debug'
require 'cgi'
require 'date'
require "fileutils"
require 'backports'
require 'capybara'
require 'show_me_the_cookies'
require 'domainatrix'
require 'page-object'

require 'page-object/page_factory'
World(PageObject::PageFactory)



#World(ShowMeTheCookies)

$LOAD_PATH << File.join(File.dirname(__FILE__), '..','..','lib')

$ADMINUSERNAME = "cucumber_user"
$ADMINPASSWORD = "changeme"

$GSAUSERNAME = "cucumber_user"
$GSAPASSWORD = "changeme"


$SITEROOT = ENV['SITEROOT']
$OLDSITEROOT = ENV['OLDSITEROOT']
$BROWSER = ENV['BROWSER']
$SITE_LANGUAGE = ENV['SITE_LANGUAGE']

$JENKINS_JOB_URL  = ENV['JENKINS_JOB_URL']
$JENKINS_BUILD_ID = ENV['JENKINS_BUILD_ID']


$PORT = "4443"

$HEADLESS = ENV['HEADLESS']

if ENV['HEADLESS'] == 'true'
  puts "I'm headless "
  require 'headless'

  headless = Headless.new
  headless.start

  Before do
   # headless.video.start_capture
  end

  at_exit do
    headless.destroy
  end
end
  
After do |scenario|

  if scenario.failed?
    Dir::mkdir('screenshots') if not File.directory?('screenshots')
    r = Random.new
    rand_number = r.rand(10..9999999999)
    screenshot = "./screenshots/#{$JENKINS_BUILD_ID}-#{rand_number}.png"
    @browser.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
    FileUtils.cp(screenshot, "#{$JENKINS_JOB_URL}")
  #  headless.video.stop_and_save("/var/lib/jenkins/reports/videos/video.mov")
  else
  
   #   headless.video.stop_and_discard
  
  end
  close_browser
end

