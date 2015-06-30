module PathHelper
  def path_for(pageName)
    case pageName
	  when /UK registration page/
	    "/en/user/register/GB/UK"      
    when /registration page/
        "/en/join"
	  when /registration confirmation page/
	    "/en/user/confirmed"
    when /english a4a blog post/
        "/en/blog/art-for-example/making-invisible-visible"
    when /create blog page/
        "/en/node/add/blog"
	  when /Art for example landing page$/
      "/en/art-for-example"
	  when /regional section page for (.+)$/
	    self.annual_report_region($1)
	  when /example center/
	    "/en/example-center"
	  when /home page/
	    "/en"	    
    else
      raise "Can't find mapping from \"#{pageName}\" to a page.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
  
  def annual_report_country(countryName)
    case countryName
    when /Afghanistan/
      "/en/region/THISPAGEDOESNTEXIST/"
    when /Zimbabwe/
      "/en/region/THISPAGEDOESNTEXIST/"
    else
      raise "Can't find country report page for \"#{countryName}\" to a page.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end

  def annual_report_region(regionName)
    case regionName
    when /Africa/
      "/en/region/africa/"
    when /Americas/
      "/en/region/americas/"
    when /Asia-Pacific/
      "/en/region/asia-pacific/"      
    when /Europe and Central Asia/
      "/en/region/europe-and-central-asiac/"
    when /Middle East and North Arica/
      "/en/region/middle-east-and-north-africa/"  
    else
      raise "Can't find country report page for \"#{countryName}\" to a page.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end  
  
end

World(PathHelper)