# author Tim Kang
# date 10-20-13

# could possibly add in threading and the ability to send actual data

import sys, getopt, httplib, urlparse #, urllib
#from threading import Thread as T
#from Queue import Queue as Q

def usage():
    print "Usage: python testclient.py [--help] [--number number_of_terations] http://www.example.com"

def send_a_request(my_url, num_value):
#    uncomment these lines if we want to be able to add a body to the request
#    params = urllib.urlencode({'@num': num_value })
#    headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}

    try:
        url = urlparse.urlparse(my_url)
        con = httplib.HTTPConnection(url.netloc)
#        con.request("HEAD", url.path, params, headers)
        con.request("HEAD", url.path)
        res = con.getresponse()
        return res.status, my_url
    except:
        return "error", my_url

def main(argv):
    
    # handle input options
    try:
        opts, args = getopt.getopt(argv, "hs:n:", ["help", "start=", "number="])
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    
    #keep track of requests, maybe for debugging
    curr_num = 0 #where they start 
    iterations = 5    

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-s", "--start"):
            curr_num = int(arg)
            print 'Starting at... ' + arg
        elif opt in ("-n", "--number"):
            iterations = int(arg)
            print 'Running ' + arg + ' iterations'

    for i in range(iterations):
        print send_a_request(args[0], i)

if __name__ == "__main__":
    main(sys.argv[1:])
