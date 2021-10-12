#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import requests
import shutil
import json
import sys
import difflib


# In[ ]:


# Copy Hosts File
def copy_host_file(file1, file2):
    f1 = open(file1, 'a+')
    f2 = open(file2, 'a+')
    shutil.copyfile(file1, file2)


# In[ ]:


# Write hosts to file
def write_hosts(vra_host, file1):
    f1 = open(file1, 'w+')
    for content in data['content']:
        dep_id = str((content['id']))
        resource_name = get_resource_name(vra_host, dep_id, bearer_token)
        f1.writelines("%s\r\n" % r for r in resource_name)
    f1.close()


# In[ ]:


#Get Bearer Token
def get_token(vra_host):
    token_url = "https://" + vra_host + "/csp/gateway/am/api/login?/access_token"
    payload="{\n  \"username\": \"VRACST.CAAdmin\",\n  \"password\": \"j3pX&aeX73\"\n}"
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic cmljaC5kYWd1c3RvOkF1Z3VzdDA4MDU='
    }
    response = requests.request("POST", token_url, headers=headers, data=payload, verify=False)
    data = response.json()
    token = "Bearer" + " " + data['cspAuthToken']
    return token


# In[ ]:


#Get Total Number of Deployments
def get_num_elements(vra_host, token):
    url = "https://" + vra_host + "/deployment/api/deployments"
    payload = {}
    headers = {
      'Authorization': token
    }
    r = requests.request("GET", url, headers=headers, data=payload, verify=False).json()
    num_elements = r['totalElements']
    return num_elements


# In[ ]:


#Get Deployments Data
def get_deployments(vra_host, token, elements):
    url = "https://" + vra_host + "/deployment/api/deployments?$top=" + elements
    payload = {}
    headers = {
      'Authorization': token
    }
    r = requests.request("GET", url, headers=headers, data=payload, verify=False)
    data = r.json()
    return data


# In[ ]:


#Getting Resource Name
def get_resource_name(url, depID, token):
    resource_url = "https://" + url + "/deployment/api/deployments/" + str(depID) + "/resources"
    payload={}
    headers = {
      'Authorization': token
    }
    response = requests.request("GET", resource_url, headers=headers, data=payload, verify=False)
    data = response.json()
    host_names = []
    for content in data['content']:
        properties = content['properties']
        if properties['resourceName'] != 'PH1-vCenter-CST-Network':
            host_names.append(properties['resourceName'])
    return host_names


# In[ ]:


def compare_files(file1, file2):
    with open(file1, 'r') as hosts:
        with open(file2, 'r') as hosts_compare:
            diff = difflib.unified_diff(
                sorted(hosts_compare.readlines()),
                sorted(hosts.readlines()),
                fromfile='hosts',
                tofile='hosts_compare',
            )
            for line in diff:
                sys.stdout.write(line)


# In[ ]:


staging_host = "phltvra0001.vertexinc.com"
staging_file1 = "staging_hosts.txt"
staging_file2 = "staging_hosts_compare.txt"
copy_host_file(staging_file1, staging_file2)


# In[ ]:


production_host = "cstvmportal.vertexinc.com"
production_file1 = "production_hosts.txt"
production_file2 = "production_hosts_compare.txt"
copy_host_file(production_file1, production_file2)


# In[ ]:


bearer_token = get_token(staging_host)
elements = str(get_num_elements(staging_host, bearer_token))
data = get_deployments(staging_host, bearer_token, elements)


# In[ ]:


write_hosts(staging_host, staging_file1)


# In[ ]:


print("STAGING Unified Diff:")
compare_files(staging_file1, staging_file2)
print("\n")


# In[ ]:


bearer_token = get_token(production_host)
elements = str(get_num_elements(production_host, bearer_token))
data = get_deployments(production_host, bearer_token, elements)


# In[ ]:


write_hosts(production_host, production_file1)


# In[ ]:


print("PRODUCTION Unified Diff:")
compare_files(production_file1, production_file2)
print("\n")
