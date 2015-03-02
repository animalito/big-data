import sys, json
print ' '.join([i['InstanceId'] for i in json.load(sys.stdin)['Instances']])