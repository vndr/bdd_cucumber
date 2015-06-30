module HtmlSelectorsHelper
  def selector_for(scope)
  case scope
    when /the registration header/
      "//p[@class='register-header']"
	  
    when /the highlighted section of the register stage indicator/
	    "//ul[@id='register-stage-indicator']/li[contains(@class,'register-stage-current')]/div[@class='inner']/p"
	  
    when /the registration country control/
	    "//div[contains(@class,'pane-countryjoin-panel-pane-2')]//select"
	  
    when /the block header/
	    "//p[contains(@class,'block-header')]"
    
    when /the top panel/
      "//div[contains(@class,'panel-col-top')]"
    
    when /the right sidebar/
      "//div[contains(@class,'panel-col-last')]"
    
    when /the language dropdown/
      "//select[@name='language']"

    when /a4a branding/
      "//div[contains(@class,'a4aheader')]"

    when /article title/
      "//h2[contains(@class,'blog-title')]"

    when /article teaser/
      "//div[contains(@class, 'blog-body')][count(p)=1]"

    when /first blog post/
      "//div[contains(@class, 'blog-first')]"

    when /a distinguishing title/
      "//h2[contains(@class, 'blog-title')]"

    when /the ([0-9]+) most-recent blog posts/
      "[count(//div[contains(@class, 'blog-body')])=#{$1}]"

    when /the ([0-9]+) most-recent blog post/
      "//div[contains(@class, 'blog-body')]"
      
    when /publishing information/
      "//div[contains(@class, 'publishing-info')][div[contains(text(), 'Posted ')]][div[contains(text(), 'by ')]][div/a]"

    when /the "([^"]+)" option/
      "//option[text()='#{$1}']"
    
    when /the breadcrumb trail/
      "//div[@id='breadcrumb']//div[contains(@class, 'breadcrumb')]/ul"

    when /the left-hand menu/
      "//div[@id='ai-sidebar-first']"

    when /This article in other languages/
      "//div[contains(@class,'tactical-picker-node-title')]"      
    
    when /the profile page title/
	    "//h2[contains(@class,'pane-title')]"
	    
	  when /the civicrm profile country field/
	    "//span[contains(@class,'country-name')]"

    when /the content area/
      "//div[contains(@class, 'center-wrapper')]/div[contains(@class, 'panel-col-first')]"

    when /the civicrm areas of interest field/   
      "//table[@id='constituent_information_1']/tbody/tr[4][@class='hiddenElement']/td[2][@class='crm-custom_data']"

    when /example center featured action/
      "//div[@class='example-teaser example-teaser-campaign']/h2[@class='title feature']/a"
      
    when /the civicrm primary language/   
        "//table[@id='constituent_information_1']/tbody/tr[10][@class='hiddenElement']/td[2][@class='html-adjust crm-custom-data']"
      
    when /home page link/
      "//div[@id='logo' and @class='logo-en']/a"
      
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)