import yaml

with open('services.yaml', 'r') as file:
    services = yaml.safe_load(file)

print(services)

# python load.py 
# {'defaultService': {'replicas': 3, 'selector': {'matchLabels': {'app': 'MyApp'}}}, 'serviceA': {'replicas': 3, 'selector': {'matchLabels': {'app': 'MyApp'}}, 'name': 'ServiceA'}, 'serviceB': {'replicas': 5, 'selector': {'matchLabels': {'app': 'MyApp'}}, 'name': 'ServiceB'}}
