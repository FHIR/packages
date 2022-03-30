#!/usr/bin/env python
# coding: utf-8

# In[91]:


import pandas as pd
import json


# In[92]:


df = pd.read_excel('Radlex.xls')


# In[93]:


#Select required columns
radlexCS=df[['Class ID','Preferred Label','Definitions']]


# In[94]:


#rename columns to FHIR codesystem schema
radlexCSrename=radlexCS.rename(columns={'Class ID':'code', 'Preferred Label':'display', 'Definitions':'definition'})


# In[95]:


#Slicing 'http://www.radlex.org/RID/#' string to leave bare codes
radlexCSrename['code']=radlexCSrename['code'].str.slice(start=27)


# In[96]:


#Sort by 'code' column
radlexCSsorted=radlexCSrename.sort_values(by=['code'])


# In[97]:


#drop row with 'Obsolete Radlex Term'
radlexCSsorted.drop(radlexCSsorted[radlexCSsorted.display == 'RID15849'].index, inplace=True)


# In[98]:


#convert to json str
RadlexJSON=radlexCSsorted.to_json(orient="records")


# In[99]:


#append codesystem metadata
meta='{"resourceType":"CodeSystem","meta":{"profile": "http://hl7.org/fhir/StructureDefinition/shareablecodesystem"},"url": "http://radlex.org/","version": "4.1.0","name": "RadLexCodeSystem","title": "RadLex radiology lexicon","status": "draft","experimental": false,"contact": {"name": "informatics@rsna.org"},"publisher": "Radiological Society of North America (RSNA.org)","content": "complete","date": "2020-11-25","description": "RadLex is a comprehensive set of radiology terms for use in radiology reporting, decision support, data mining, data registries, education and research.","concept": '
end='}'
RadlexJSONmeta=meta+RadlexJSON+end


# In[100]:


#parsing json
RadlexParsed = json.loads(RadlexJSONmeta)


# In[101]:


#Recursively remove all None values
def clean_nones(value):
    if isinstance(value, list):
        return [clean_nones(x) for x in value if x is not None]
    elif isinstance(value, dict):
        return {
            key: clean_nones(val)
            for key, val in value.items()
            if val is not None
        }
    else:
        return value
Radlexfinal=clean_nones(RadlexParsed)


# In[102]:


#dump json
with open('RadlexCodeSystem.codesystem.json', 'w', encoding='utf-8') as f:
    json.dump(Radlexfinal, f, ensure_ascii=False, indent=4)

