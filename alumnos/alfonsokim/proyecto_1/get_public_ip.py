import sys, json

for ip in [i['PublicIpAddress'] for i in json.load(sys.stdin)['Reservations'][0]['Instances']]:
    print 'ssh ubuntu@%s -i ~/aws/iam_alfonsokim/aws-akim.pem' % ip