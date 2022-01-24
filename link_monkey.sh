rm data/$1_FINAL*
#RUN AMASS
docker run -v ${PWD}:/.config/amass/ caffix/amass enum -d $1 > data/"$1_domainsfound.txt"
# RUN NMAP FOR 443 and 80
nmap -iL data/"$1_domainsfound.txt" -p80,443 --open > data/"$1_nmap_result.txt"
#GREP NMAP DATA for domains that have those ports open
cat data/"$1_nmap_result.txt" | grep "Nmap scan" | awk -F " " '{ print $5 }' > data/"$1_possible_websites.txt"
#RUN CURL ON EACH FOUND DOMAIN AND FIND THE STATUS CODE FOR PORT 443
cat data/"$1_possible_websites.txt" | xargs  sh -c 'for arg do echo -n "$arg Status Code(443):" >>  data/"FINAL.txt";  curl -s -o /dev/null -w "%{http_code}" https://"$arg" | xargs -I + echo + >>  data/"FINAL.txt"; done'
mv data/FINAL.txt data/$1_FINAL_PORT_443.txt
#RUN CURL ON EACH FOUND DOMAIN AND FIND THE STATUS CODE FOR PORT 80
cat data/"$1_possible_websites.txt" | xargs  sh -c 'for arg do echo -n "$arg Status Code(80):" >>  data/"FINAL.txt";  curl -s -o /dev/null -w "%{http_code}" http://"$arg" | xargs -I + echo + >>  data/"FINAL.txt"; done'
mv data/FINAL.txt data/$1_FINAL_PORT_80.txt
#CONVIENCE PRINT
cat data/$1_FINAL_PORT_80.txt
cat data/$1_FINAL_PORT_443.txt

