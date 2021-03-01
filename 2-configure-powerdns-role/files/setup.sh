#!/bin/bash

#creating a zone
curl -X POST --data '{"name":"{{ zone_name }}.", "kind": "Native", "masters": [], "nameservers": ["ns1.example.org.", "ns2.example.org."]}' -v -H 'X-API-Key: {{ pdns_api_key }}' http://127.0.0.1:8081/api/v1/servers/localhost/zones | jq .

#creating A record
curl -X PATCH --data '{"rrsets": [ {"name": "{{ zone_name }}.", "type": "A", "ttl": 86400, "changetype": "REPLACE", "records": [ {"content": "192.0.5.4", "disabled": false } ] } ] }' -H 'X-API-Key: {{ pdns_api_key }}' http://127.0.0.1:8081/api/v1/servers/localhost/zones/{{ zone_name }}. | jq .

#creating CNAME record
curl -X PATCH --data '{"rrsets": [ {"name": "alias.{{ zone_name }}.", "type": "CNAME", "ttl": 86400, "changetype": "REPLACE", "records": [ {"content": "dainius.lt", "set_ptr":false, "disabled": false } ] } ] }' -H 'X-API-Key: {{ pdns_api_key }}' http://127.0.0.1:8081/api/v1/servers/localhost/zones/{{ zone_name }}. | jq .

#creating MX record
#curl -X PATCH --data '{"rrsets": [ {"name": "mail.ruptela.org.", "type": "MX", "ttl": 86400, "changetype": "REPLACE", "records": [ {"content": "dainius.mail.lt", "disabled": false } ] } ] }' -H 'X-API-Key: changeme' http://127.0.0.1:8081/api/v1/servers/localhost/zones/ruptela.org. | jq .
