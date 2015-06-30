module Net
  class BufferedIO   #:nodoc: internal use only
    def initialize(io)
      @io = io
      @read_timeout = 120
      @debug_output = nil
      @rbuf = ''
    end
  end
end


module BrowserHelper
  def get_browser

    self::close_browser()

    browsers = {
      "chrome" => :chrome,
      "firefox" => :firefox
    }
    
  
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds – default is 60

    driver = Selenium::WebDriver.for(browsers[$BROWSER], {:http_client => client})

    @browser = Watir::Browser.new(driver)
    
  end
  
  def close_browser
    @browser.close() if @browser.respond_to?(:close)
  end
  
  def wait_until(browser, text, times = 10)
    until browser.html.include?text or time == 0 do
      sleep 0.5
      times -=1
      puts "Retrying... #{times} times left" if $DEBUG
    end
  end
  
  def page_ok? url 
    url = URI.parse(url) 
    http = Net::HTTP.new(url.host, url.port)  
    print "Checking #{url} ... "
    begin 
      http.start do 
        http.request_get(url.path.empty? ? "/" : url.path) do |res| 
          return false unless res.kind_of?(Net::HTTPSuccess) 
        end 
      end 
    rescue => e 
      puts "Got error: #{e.inspect}" 
      return false 
    end 
    puts "OK !"
    true 
  end 
end





















World(BrowserHelper)

module DBHelper

  def get_DB_connection(type)
    
    begin 
      @DB = Mysql.init
      @DB.options(Mysql::OPT_READ_TIMEOUT, 100)
      @DB.options(Mysql::OPT_WRITE_TIMEOUT, 100)
      if type == "drupal"
        @DB.real_connect($DRUPALDBSERVER, $DRUPALDBUSER, $DRUPALDBPASS, $DRUPALDB)
      else
        @DB.real_connect($CCDBSERVER, $CCDBUSER, $CCDBPASS, $CCDB)
      end
      
    
  
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    end
    
    return @DB
  end  
  
  def DB_query(sql,db)
    
    self::get_DB_connection(db)
    @result = @DB.query(sql)
    @DB.close
    return @result
    
  end
  
end

World(DBHelper)

module exampleHelper
  
  def groupid_to_language(group_id)
    language = { 
      "5" => "English", 
      "10" => "French" ,
      "12" => "Spanish",
      "14" => "Arabic"
    };
    if language["#{group_id}"]
      return language["#{group_id}"]
    else 
  	  return false
    end
  end
  
  def get_terms_for_email(email)
    db = "drupal"
    areas_of_interest = Array.new
    sql = "select distinct * from example_signups where mail = '#{email}'"
    row = DB_query(sql,db) #get the example results for the user as a node id
    row.each do |result|
      node = result[0]
      sql = "select distinct term.name from term_node as nterm LEFT JOIN term_data as term ON nterm.tid = term.tid where nterm.nid = #{node} and term.vid IN (7,8)"
      row1 = DB_query(sql,db) #get the terms for that node
      row1.each do |result1|     
  #      debugger
        
        result1 = result1.pop

        next if result1 == "Current Campaigns" || result1 == ""
        result1 = clean_tag_names(result1)
        if get_region_for_country(result1) != false
          areas_of_interest.push(get_region_for_country(result1))
        else 
          areas_of_interest.push(result1)
        end
      end    
    end
    return areas_of_interest
  end
  
  def get_country_of_residence(email)
    db = "drupal"
    sql = "select country from example_signups where mail = '#{email}'"
    
    row = DB_query(sql,db)
  
    @cor = []
    while current_row = row.fetch do
      @cor.push(current_row) 
    end
    if @cor.count() > 1 || get_country_from_iso(@cor.to_s) == false
      return false
    else
      cor = get_country_from_iso(@cor.to_s)
      return cor
    end
  end
  
  def get_random_example_emails(count)
    db = "drupal"
    sql = "select mail from example_signups where mail <> '' LIMIT " + rand(200000).to_s + ", #{count}"
   
    row = DB_query(sql,db)
  
    @emails = []
    while current_row = row.fetch do
      @emails.push(current_row) 
    end
    return @emails
  end

  def get_x_example_emails(count, start, finish)
    
    db = "drupal"
    sql = "select mail from example_signups where mail <> '' LIMIT #{start}, #{finish}"
   
    row = DB_query(sql,db)
  #push all email adrresses from sql query into an array
    @emails = []
    while current_row = row.fetch do
      @emails.push(current_row) 
    end
    #the pull out 10 random email 
    @random_emails = []
    for i in (1..count)
      @random_emails.push(@emails[rand(finish)]) 
    end
    return @random_emails
  end
  
  def get_country_from_iso(iso)
  
    country = {
      'AF' => 'AFGHANISTAN',
      'AX' => 'ALAND ISLANDS',
      'AL' => 'ALBANIA',
      'DZ' => 'ALGERIA',
      'AS' => 'AMERICAN SAMOA',
      'AD' => 'ANDORRA',
      'AO' => 'ANGOLA',
      'AI' => 'ANGUILLA',
      'AQ' => 'ANTARCTICA',
      'AG' => 'ANTIGUA AND BARBUDA',
      'AR' => 'ARGENTINA',
      'AM' => 'ARMENIA',
      'AW' => 'ARUBA',
      'AU' => 'AUSTRALIA',
      'AT' => 'AUSTRIA',
      'AZ' => 'AZERBAIJAN',
      'BS' => 'BAHAMAS',
      'BH' => 'BAHRAIN',
      'BD' => 'BANGLADESH',
      'BB' => 'BARBADOS',
      'BY' => 'BELARUS',
      'BE' => 'BELGIUM',
      'BZ' => 'BELIZE',
      'BJ' => 'BENIN',
      'BM' => 'BERMUDA',
      'BT' => 'BHUTAN',
      'BO' => 'BOLIVIA, PLURINATIONAL STATE OF',
      'BQ' => 'BONAIRE, SINT EUSTATIUS AND SABA',
      'BA' => 'BOSNIA AND HERZEGOVINA',
      'BW' => 'BOTSWANA',
      'BV' => 'BOUVET ISLAND',
      'BR' => 'BRAZIL',
      'IO' => 'BRITISH INDIAN OCEAN TERRITORY',
      'BN' => 'BRUNEI DARUSSALAM',
      'BG' => 'BULGARIA',
      'BF' => 'BURKINA FASO',
      'BI' => 'BURUNDI',
      'KH' => 'CAMBODIA',
      'CM' => 'CAMEROON',
      'CA' => 'CANADA',
      'CV' => 'CAPE VERDE',
      'KY' => 'CAYMAN ISLANDS',
      'CF' => 'CENTRAL AFRICAN REPUBLIC',
      'TD' => 'CHAD',
      'CL' => 'CHILE',
      'CN' => 'CHINA',
      'CX' => 'CHRISTMAS ISLAND',
      'CC' => 'COCOS (KEELING) ISLANDS',
      'CO' => 'COLOMBIA',
      'KM' => 'COMOROS',
      'CG' => 'CONGO',
      'CD' => 'CONGO, THE DEMOCRATIC REPUBLIC OF THE',
      'CK' => 'COOK ISLANDS',
      'CR' => 'COSTA RICA',
      'CI' => 'COTE D\'IVOIRE',
      'HR' => 'CROATIA',
      'CU' => 'CUBA',
      'CW' => 'CURACAO',
      'CY' => 'CYPRUS',
      'CZ' => 'CZECH REPUBLIC',
      'DK' => 'DENMARK',
      'DJ' => 'DJIBOUTI',
      'DM' => 'DOMINICA',
      'DO' => 'DOMINICAN REPUBLIC',
      'EC' => 'ECUADOR',
      'EG' => 'EGYPT',
      'SV' => 'EL SALVADOR',
      'GQ' => 'EQUATORIAL GUINEA',
      'ER' => 'ERITREA',
      'EE' => 'ESTONIA',
      'ET' => 'ETHIOPIA',
      'FK' => 'FALKLAND ISLANDS (MALVINAS)',
      'FO' => 'FAROE ISLANDS',
      'FJ' => 'FIJI',
      'FI' => 'FINLAND',
      'FR' => 'FRANCE',
      'GF' => 'FRENCH GUIANA',
      'PF' => 'FRENCH POLYNESIA',
      'TF' => 'FRENCH SOUTHERN TERRITORIES',
      'GA' => 'GABON',
      'GM' => 'GAMBIA',
      'GE' => 'GEORGIA',
      'DE' => 'GERMANY',
      'GH' => 'GHANA',
      'GI' => 'GIBRALTAR',
      'GR' => 'GREECE',
      'GL' => 'GREENLAND',
      'GD' => 'GRENADA',
      'GP' => 'GUADELOUPE',
      'GU' => 'GUAM',
      'GT' => 'GUATEMALA',
      'GG' => 'GUERNSEY',
      'GN' => 'GUINEA',
      'GW' => 'GUINEA-BISSAU',
      'GY' => 'GUYANA',
      'HT' => 'HAITI',
      'HM' => 'HEARD ISLAND AND MCDONALD ISLANDS',
      'VA' => 'HOLY SEE (VATICAN CITY STATE)',
      'HN' => 'HONDURAS',
      'HK' => 'HONG KONG',
      'HU' => 'HUNGARY',
      'IS' => 'ICELAND',
      'IN' => 'INDIA',
      'ID' => 'INDONESIA',
      'IR' => 'IRAN, ISLAMIC REPUBLIC OF',
      'IQ' => 'IRAQ',
      'IE' => 'IRELAND',
      'IM' => 'ISLE OF MAN',
      'IL' => 'ISRAEL',
      'IT' => 'ITALY',
      'JM' => 'JAMAICA',
      'JP' => 'JAPAN',
      'JE' => 'JERSEY',
      'JO' => 'JORDAN',
      'KZ' => 'KAZAKHSTAN',
      'KE' => 'KENYA',
      'KI' => 'KIRIBATI',
      'KP' => 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF',
      'KR' => 'KOREA, REPUBLIC OF',
      'KW' => 'KUWAIT',
      'KG' => 'KYRGYZSTAN',
      'LA' => 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC',
      'LV' => 'LATVIA',
      'LB' => 'LEBANON',
      'LS' => 'LESOTHO',
      'LR' => 'LIBERIA',
      'LY' => 'LIBYAN ARAB JAMAHIRIYA',
      'LI' => 'LIECHTENSTEIN',
      'LT' => 'LITHUANIA',
      'LU' => 'LUXEMBOURG',
      'MO' => 'MACAO',
      'MK' => 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF',
      'MG' => 'MADAGASCAR',
      'MW' => 'MALAWI',
      'MY' => 'MALAYSIA',
      'MV' => 'MALDIVES',
      'ML' => 'MALI',
      'MT' => 'MALTA',
      'MH' => 'MARSHALL ISLANDS',
      'MQ' => 'MARTINIQUE',
      'MR' => 'MAURITANIA',
      'MU' => 'MAURITIUS',
      'YT' => 'MAYOTTE',
      'MX' => 'MEXICO',
      'FM' => 'MICRONESIA, FEDERATED STATES OF',
      'MD' => 'MOLDOVA, REPUBLIC OF',
      'MC' => 'MONACO',
      'MN' => 'MONGOLIA',
      'ME' => 'MONTENEGRO',
      'MS' => 'MONTSERRAT',
      'MA' => 'MOROCCO',
      'MZ' => 'MOZAMBIQUE',
      'MM' => 'MYANMAR',
      'NA' => 'NAMIBIA',
      'NR' => 'NAURU',
      'NP' => 'NEPAL',
      'NL' => 'NETHERLANDS',
      'NC' => 'NEW CALEDONIA',
      'NZ' => 'NEW ZEALAND',
      'NI' => 'NICARAGUA',
      'NE' => 'NIGER',
      'NG' => 'NIGERIA',
      'NU' => 'NIUE',
      'NF' => 'NORFOLK ISLAND',
      'MP' => 'NORTHERN MARIANA ISLANDS',
      'NO' => 'NORWAY',
      'OM' => 'OMAN',
      'PK' => 'PAKISTAN',
      'PW' => 'PALAU',
      'PS' => 'PALESTINIAN TERRITORY, OCCUPIED',
      'PA' => 'PANAMA',
      'PG' => 'PAPUA NEW GUINEA',
      'PY' => 'PARAGUAY',
      'PE' => 'PERU',
      'PH' => 'PHILIPPINES',
      'PN' => 'PITCAIRN',
      'PL' => 'POLAND',
      'PT' => 'PORTUGAL',
      'PR' => 'PUERTO RICO',
      'QA' => 'QATAR',
      'RE' => 'REUNION',
      'RO' => 'ROMANIA',
      'RU' => 'RUSSIAN FEDERATION',
      'RW' => 'RWANDA',
      'BL' => 'SAINT BARTHELEMY',
      'SH' => 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA',
      'KN' => 'SAINT KITTS AND NEVIS',
      'LC' => 'SAINT LUCIA',
      'MF' => 'SAINT MARTIN (FRENCH PART)',
      'PM' => 'SAINT PIERRE AND MIQUELON',
      'VC' => 'SAINT VINCENT AND THE GRENADINES',
      'WS' => 'SAMOA',
      'SM' => 'SAN MARINO',
      'ST' => 'SAO TOME AND PRINCIPE',
      'SA' => 'SAUDI ARABIA',
      'SN' => 'SENEGAL',
      'RS' => 'SERBIA',
      'SC' => 'SEYCHELLES',
      'SL' => 'SIERRA LEONE',
      'SG' => 'SINGAPORE',
      'SX' => 'SINT MAARTEN (DUTCH PART)',
      'SK' => 'SLOVAKIA',
      'SI' => 'SLOVENIA',
      'SB' => 'SOLOMON ISLANDS',
      'SO' => 'SOMALIA',
      'ZA' => 'SOUTH AFRICA',
      'GS' => 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
      'ES' => 'SPAIN',
      'LK' => 'SRI LANKA',
      'SD' => 'SUDAN',
      'SR' => 'SURINAME',
      'SJ' => 'SVALBARD AND JAN MAYEN',
      'SZ' => 'SWAZILAND',
      'SE' => 'SWEDEN',
      'CH' => 'SWITZERLAND',
      'SY' => 'SYRIAN ARAB REPUBLIC',
      'TW' => 'TAIWAN, PROVINCE OF CHINA',
      'TJ' => 'TAJIKISTAN',
      'TZ' => 'TANZANIA, UNITED REPUBLIC OF',
      'TH' => 'THAILAND',
      'TL' => 'TIMOR-LESTE',
      'TG' => 'TOGO',
      'TK' => 'TOKELAU',
      'TO' => 'TONGA',
      'TT' => 'TRINIDAD AND TOBAGO',
      'TN' => 'TUNISIA',
      'TR' => 'TURKEY',
      'TM' => 'TURKMENISTAN',
      'TC' => 'TURKS AND CAICOS ISLANDS',
      'TV' => 'TUVALU',
      'UG' => 'UGANDA',
      'UA' => 'UKRAINE',
      'AE' => 'UNITED ARAB EMIRATES',
      'GB' => 'UNITED KINGDOM',
      'US' => 'UNITED STATES',
      'UM' => 'UNITED STATES MINOR OUTLYING ISLANDS',
      'UY' => 'URUGUAY',
      'UZ' => 'UZBEKISTAN',
      'VU' => 'VANUATU',
      'VE' => 'VENEZUELA, BOLIVARIAN REPUBLIC OF',
      'VN' => 'VIET NAM',
      'VG' => 'VIRGIN ISLANDS, BRITISH',
      'VI' => 'VIRGIN ISLANDS, U.S.',
      'WF' => 'WALLIS AND FUTUNA',
      'EH' => 'WESTERN SAHARA',
      'YE' => 'YEMEN',
      'ZM' => 'ZAMBIA',
      'ZW' => 'ZIMBABWE'
    }
    if country["#{iso}"]
      return country["#{iso}"].capitalize
    else 
  	  return false
    end
  end
  
  def  get_region_for_country(country) 
     regions = {
          'Afghanistan' => 'Asia',
          'Albania' => 'Europe & Central Asia',
          'Algeria' => 'Middle East & North Africa',
          'American Samoa' => 'Asia',                
          'Andorra' => 'Europe & Central Asia',
          'Angola' => 'Africa',
          'Anguilla' => 'Americas',
          'Antigua & Barbuda  ' => 'Americas',
          'Antilles' => 'Americas',
          'Argentina' => 'Americas',
          'Armenia' => 'Europe & Central Asia',
          'Australia' => 'Asia',
          'Austria' => 'Europe & Central Asia',
          'Azerbaijan' => 'Europe & Central Asia',
          'Bahamas' => 'Americas',
          'Bahrain' => 'Middle East & North Africa',
          'Bangladesh' => 'Asia',
          'Barbados' => 'Americas',
          'Belarus' => 'Europe & Central Asia',
          'Belgium' => 'Europe & Central Asia',
          'Belize' => 'Americas',
          'Benin' => 'Africa',
          'Bermuda' => 'Americas',
          'Bhutan' => 'Asia',
          'Bolivia' => 'Americas',
          'Bosnia-Herzegovina' => 'Europe & Central Asia',
          'Botswana' => 'Africa',
          'Brazil' => 'Americas',
          'Brunei Darussalam' => 'Asia',
          'Bulgaria' => 'Europe & Central Asia',
          'Burkina Faso' => 'Africa',
          'Burundi' => 'Africa',
          'Cambodia' => 'Asia',
          'Cameroon' => 'Africa',
          'Canada' => 'Americas',
          'Cape Verde' => 'Africa',
          'Cayman Islands' => 'Americas',
          'Central African Republic' => 'Africa',
          'Chad' => 'Africa',
          'Chile' => 'Americas',
          'China' => 'Asia',
          'Colombia' => 'Americas',
          'Comoros' => 'Africa',
          'Congo' => 'Africa',
          'Cook Islands' => 'Asia',
          'Costa Rica' => 'Americas',
          'Cote D\'ivoire' => 'Africa',
          'Croatia' => 'Europe & Central Asia',
          'Cuba' => 'Americas',
          'Cyprus' => 'Europe & Central Asia',
          'Czech Republic' => 'Europe & Central Asia',
          'Democratic Republic Of Congo' => 'Africa',
          'Denmark' => 'Europe & Central Asia',
          'Djibouti' => 'Africa',
          'Dominica' => 'Americas',
          'Dominican Republic ' => 'Americas',
          'Ecuador' => 'Americas',
          'Egypt' => 'Middle East & North Africa',
          'El Salvador' => 'Americas',
          'Equatorial Guinea' => 'Africa',
          'Eritrea' => 'Africa',
          'Estonia' => 'Europe & Central Asia',
          'Ethiopia' => 'Africa',
          'Falkland Islands' => 'Americas',
          'Faroe Islands' => 'Europe & Central Asia',
          'Fiji' => 'Asia',
          'Finland' => 'Europe & Central Asia',
          'France' => 'Europe & Central Asia',
          'French Guiana' => 'Americas',
          'French Polynesia' => 'Asia',
          'Gabon' => 'Africa',
          'Gambia' => 'Africa',
          'Georgia' => 'Europe & Central Asia',
          'Germany' => 'Europe & Central Asia',
          'Ghana' => 'Africa',
          'Gibraltar' => 'Europe & Central Asia',
          'Greece' => 'Europe & Central Asia',
          'Greenland' => 'Europe & Central Asia',
          'Grenada' => 'Americas',
          'Guadeloupe' => 'Americas',
          'Guam' => 'Asia',
          'Guatemala' => 'Americas',
          'Guinea' => 'Africa',
          'Guinea-bissau' => 'Africa',
          'Guyana' => 'Americas',
          'Haiti' => 'Americas',
          'Honduras' => 'Americas',
          'Hong Kong' => 'Asia',
          'Hungary' => 'Europe & Central Asia',
          'Iceland' => 'Europe & Central Asia',
          'India' => 'Asia',
          'Indonesia' => 'Asia',
          'Iran' => 'Middle East & North Africa',
          'Iraq' => 'Middle East & North Africa',
          'Ireland' => 'Europe & Central Asia',
          'Israel and Occupied Palestinian Territories' => '',
          'Italy' => 'Europe & Central Asia',
          'Jamaica' => 'Americas',
          'Japan' => 'Asia',
          'Jordan' => 'Middle East & North Africa',
          'Kazakhstan' => 'Europe & Central Asia',
          'Kenya' => 'Africa',
          'Kiribati' => 'Asia',
          'Kuwait' => 'Middle East & North Africa',
          'Kyrgyzstan' => 'Europe & Central Asia',
          'Laos' => 'Asia',
          'Latvia' => 'Europe & Central Asia',
          'Lebanon' => 'Middle East & North Africa',
          'Lesotho' => 'Africa',
          'Liberia' => 'Africa',
          'Libya' => 'Middle East & North Africa',
          'Liechtenstein' => 'Europe & Central Asia',
          'Lithuania' => 'Europe & Central Asia',
          'Luxembourg' => 'Europe & Central Asia',
          'Macao' => 'Asia',
          'Macedonia' => 'Europe & Central Asia',
          'Madagascar' => 'Africa',
          'Malawi' => 'Africa',
          'Malaysia' => 'Asia',
          'Maldives' => 'Asia',
          'Mali' => 'Africa',
          'Malta' => 'Europe & Central Asia',
          'Marshall Islands' => 'Asia',
          'Martinique' => 'Americas',
          'Mauritania' => 'Africa',
          'Mauritius' => 'Africa',
          'Mexico' => 'Americas',
          'Micronesia' => 'Asia',
          'Middle East & North Africa' => '',
          'Moldova' => 'Europe & Central Asia',
          'Monaco' => 'Europe & Central Asia',
          'Mongolia' => 'Asia',
          'Montenegro' => 'Europe & Central Asia',
          'Montserrat' => 'Americas',
          'Morocco' => 'Middle East & North Africa',
          'Mozambique' => 'Africa',
          'Myanmar' => 'Asia',
          'Namibia' => 'Africa',
          'Nauru' => 'Asia',
          'Nepal' => 'Asia',
          'Netherlands' => 'Europe & Central Asia',
          'New Caledonia' => 'Asia',
          'New Zealand' => 'Asia',
          'Nicaragua' => 'Americas',
          'Niger' => 'Africa',
          'Nigeria' => 'Africa',
          'Niue' => 'Asia',
          'North Korea' => 'Asia',
          'Norway' => 'Europe & Central Asia',
          'Oman' => 'Middle East & North Africa',
          'Pakistan' => 'Asia',
          'Palau' => 'Asia',
          'Palestinian Authority' => 'Middle East & North Africa',
          'Panama' => 'Americas',
          'Papua New Guinea' => 'Asia',
          'Paraguay' => 'Americas',
          'Peru' => 'Americas',
          'Philippines' => 'Asia',
          'Pitcairn Islands' => 'Asia',
          'Poland' => 'Europe & Central Asia',
          'Portugal' => 'Europe & Central Asia',
          'Puerto Rico' => 'Americas',
          'Qatar' => 'Middle East & North Africa',
          'Reunion' => 'Africa',
          'Romania' => 'Europe & Central Asia',
          'Russian Federation' => 'Europe & Central Asia',
          'Rwanda' => 'Africa',
          'San Marino' => 'Europe & Central Asia',
          'Sao Tome And Principe' => 'Africa',
          'Saudi Arabia' => 'Middle East & North Africa',
          'Senegal' => 'Africa',
          'Serbia' => 'Europe & Central Asia',
          'Seychelles' => 'Africa',
          'Sierra Leone' => 'Africa',
          'Singapore' => 'Asia',
          'Slovak Republic' => 'Europe & Central Asia',
          'Slovenia' => 'Europe & Central Asia',
          'Solomon Islands' => 'Asia',
          'Somalia' => 'Africa',
          'South Africa' => 'Africa',
          'South Korea' => 'Asia',
          'Spain' => 'Europe & Central Asia',
          'Sri Lanka' => 'Asia',
          'St Kitts-nevis' => 'Americas',
          'St Lucia' => 'Americas',
          'St Vincent' => 'Americas',
          'Sudan' => 'Africa',
          'Suriname' => 'Americas',
          'Swaziland' => 'Africa',
          'Sweden' => 'Europe & Central Asia',
          'Switzerland' => 'Europe & Central Asia',
          'Syria' => 'Middle East & North Africa',
          'Taiwan' => 'Asia',
          'Tajikistan' => 'Europe & Central Asia',
          'Tanzania' => 'Africa',
          'Thailand' => 'Asia',
          'Timor Leste' => 'Asia',
          'Togo' => 'Africa',
          'Tonga' => 'Asia',
          'Trinidad & Tobago' => 'Americas',
          'Tunisia' => 'Middle East & North Africa',
          'Turkey' => 'Europe & Central Asia',
          'Turkmenistan' => 'Europe & Central Asia',
          'Turks & Caicos Islands' => 'Americas',
          'Tuvalu' => 'Asia',
          'UAE' => 'Middle East & North Africa',
          'Uganda' => 'Africa',
          'UK' => 'Europe & Central Asia',
          'Ukraine' => 'Europe & Central Asia',
          'Uruguay' => 'Americas',
          'USA' => 'Americas',
          'Uzbekistan' => 'Europe & Central Asia',
          'Vanuatu' => 'Asia',
          'Vatican' => 'Europe & Central Asia',
          'Venezuela' => 'Americas',
          'Viet Nam' => 'Asia',
          'Virgin Islands (UK)' => 'Americas',
          'Virgin Islands (US)' => 'Americas',
          'Western Samoa' => 'Asia',
          'Yemen' => 'Middle East & North Africa',
          'Zambia' => 'Africa',
          'Zimbabwe' => 'Africa'}
    if regions["#{country}"]
      return regions["#{country}"]
    else 
  	  return false
    end
  end
  
  def clean_tag_names(tag)
    
    case tag
    when "Security with Human Rights"
        tag = "Security and Human Rights"
    
    when "International Justice"
        tag = "International justice"
    when "Stop Violence Against Women"
        tag = "Violence Against Women"
    end
    return tag
  end

end

World(exampleHelper)


  class User
  	def initialize(email = '', firstname = '' , lastname = '', areas_of_interest = '', country_of_residence = '', language = '', contact_id = '')
  	  @email = email
  	  @firstname = firstname
  	  @lastname = lastname
  	  @areas_of_interest = areas_of_interest 
  	  @country_of_residence = country_of_residence
  	  @language = language
  	  @contact_id = contact_id
  	end
  	attr_accessor :email, :firstname, :lastname, :areas_of_interest, :country_of_residence, :language, :contact_id
  end

  

class Storage
	def initialize(data = 'data')
	  @data = data
	end
	attr_accessor :data
end

