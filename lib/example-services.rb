require 'net/http'
require 'net/https'

require 'rubygems'
require 'openssl'
require 'json'


class exampleServices
  @boundary
  @http
  @path
  @domain
  @apikey
  @headers
  @@sessid = nil;
  
  def sessid
    @@sessid
  end
  
  def initialize(domain)
    @boundary = '3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f'
    #@http = Net::HTTP.new("www-app1-dev.example.org", 80)
    @http = Net::HTTP.new($SERVICESSERVER, $SERVICESPORT)
    @path = '/services/json'
    @headers = {
    	'Content-Type' => 'multipart/form-data; boundary=3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f',
    	'User-Agent' => 'com.exampleinternational.icandle/2.0 CFNetwork/485.12.7 Darwin/10.6.0'
    }    
    
    case domain
      when 'iPhone'
        @apikey = 'b42fa4a5f68b5217582ddcb16f4a97a0'
        @domain = 'iPhone'
      when 'earthCandle'
        @apikey = '9cc98c87b0795bce8c613b7d4bac6183'
        @domain = 'earthCandle'
      else 
        @apikey = 'b42fa4a5f68b5217582ddcb16f4a97a0'
        @domain = 'iPhone'
    end
  end

  def createRequest(requestHash)
    requestString = "--" + @boundary + "\n\n"
    requestHash.each  do |key, value| 
                        requestString += "--" + @boundary + "\n"
                        requestString += 'Content-Disposition: form-data; name="' + key + '"' + "\n\n"
                        requestString += value.to_s + "\n"
                      end
    requestString += "--" + @boundary + "--"
  end

  def getSessionId()
    if(@@sessid != nil)
      return @@sessid
    else
      loginHash = Hash["method", "system.connect"]
      loginRequest = self.createRequest(loginHash)
      @@sessid = self.requestAndParse(loginRequest)  
    end
  end

  def requestAndParse(request)
    resp, data = @http.post(@path, request, @headers) 
    result = JSON.parse(data)
  end

  def generateAuthHash(nonce,nixtime,requestName)
    to_hash = nixtime.to_s + ';' + @domain + ';' + nonce.to_s + ';' + requestName
    hash    = OpenSSL::HMAC.hexdigest('sha256', @apikey,to_hash)
  end

  def makeAuthedRequest(request)
    # so request hashs only have the extra fields not mandated by the auth request
    nixtime = Time.now.to_i
    nonce   = rand(1339078783)
    sessid = getSessionId()
    
    hash = self.generateAuthHash(nonce,nixtime,request["method"])    
    
    authHash = Hash[  "domain_time_stamp", nixtime,
                      "sessid", sessid,
                      "domain_name",@domain,                  
                      "nonce",nonce,
                      "hash",hash]
                      
    authHash.merge!(request)

    authedRequest = self.createRequest(authHash) 
    requestResult = self.requestAndParse(authedRequest)   
  end

  def getNews(limit)  
    requestHash = Hash[  "method", 'example.getNews',
                      "limit", limit]
    requestResult = self.makeAuthedRequest(requestHash)
  end
  
  def getCTACount(nids)
      requestHash = Hash[  "method", 'example.getCTACount',
                        "nids", nids]
      requestResult = self.makeAuthedRequest(requestHash)
  end    
  
  def getCTACampaignCount(campaign)
      requestHash = Hash[ "method", 'example.getCTACampaignCount',
                          "tag", campaign]
      requestResult = self.makeAuthedRequest(requestHash)
  end  
  
  def getCTA(limit)
    requestHash = Hash[ "method", 'example.getCTA',
                        "limit", limit]
    requestResult = self.makeAuthedRequest(requestHash)
  end    
  
  def getUserCTA(limit)
    requestHash = Hash[ "method", 'example.getUserCTA',
                        "uid", uid]
    requestResult = self.makeAuthedRequest(requestHash)
  end
  
  def getCTAUserData(limit)
    requestHash = Hash[ "method", 'example.getCTAUserData',
                        "limit", limit]
    requestResult = self.makeAuthedRequest(requestHash)
  end
  
  def getRegistrationFields()
    requestHash = Hash["method", 'example.getRegistrationFields']
    requestResult = self.makeAuthedRequest(requestHash)
  end
  
  def moreInformation()
    requestHash = Hash["method", 'example.moreInformation']
    requestResult = self.makeAuthedRequest(requestHash)
  end  

  def forgottenPassword(email)
    requestHash = Hash[ "method", 'example.forgottenPassword',
                        "email",email]
    requestResult = self.makeAuthedRequest(requestHash)
  end  
  
  def user_get(uid)
    requestHash = Hash[ "method", 'user.get',
                        "uid", uid]
    requestResult = self.makeAuthedRequest(requestHash)
  end
  
  # does a full login, sets an anon sessid if you don't have one first
  def loginAuto(username,password)
    self.getSessionId()
    login = login(username,password)
  end
  
  def login(username,password)
    # here we need re-set the sessid 
    # this method requires that you have a valid session id already
    loginHash = Hash[ "method", 'user.login',
                      "username",username,
                      "password",password]
    login = self.makeAuthedRequest(loginHash)
    @@sessid = login['#data']['sessid']
    return login
  end
  
  def logout()
    requestHash = Hash[ "method", 'user.logout']
    requestResult = self.makeAuthedRequest(requestHash)    
  end
  
end
