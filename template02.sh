curl -XPUT localhost:9200/_template/template02 -d '{
  "template": "mongodb*",
  "settings": {
   "number_of_shards" :   1,
   "number_of_replicas" : 0,
   "index": {
    "refresh_interval" : "1s",
    "similarity": {
     "default": {
      "type": "classic"
          }
        },
    "analysis": {
     "analyzer": {
      "my_analyzer": {
         "type": "custom",
         "tokenizer": "standard",
         "filter": ["lowercase", "asciifolding","shingle"]
                 },
      "whitespace_analyzer": {
            "type": "custom",
        "tokenizer": "whitespace",
        "filter": [ "lowercase", "asciifolding"]
        }
       },
     "filter": {
      "text_filter": {
        "type": "word_delimiter",
        "split_on_numerics": true,
        "split_on_case_change": true,
        "generate_word_parts": true,
        "generate_number_parts": true,
        "catenate_all": true,
        "preserve_original": true,
        "catenate_numbers": true,
        "type_table": ["& => DIGIT"]
    },
       "my_ascii_folding": {
        "type": "asciifolding",
        "preserve_original": true
       },
       "Edge_NGRAM": {
        "type": "edge_ngram",
        "min_gram": 2,
        "max_gram": 30,
        "token_chars": [ "letter", "digit", "whitespace", "punctuation", "symbol" ]
       },
       "SYNONYM": {
        "type": "synonym",
        "synonyms_path": "synonym_character.txt"
       }
    }
   }
  }
 },
   "mappings": {
    "fteluv-mapping": {
      "_all": {
       "enabled": false
      },
      "properties": {
       "GEOIP_COUNTRY_CODE_availability": {
         "type": "text",
         "index": true,
         "analyzer": "keyword",
         "include_in_all": false
        },
       "actors": {
         "type": "text",
         "index": true,
         "analyzer": "my_analyzer",
         "search_analyzer": "my_analyzer"
        },
       "description": {
         "type": "text",
         "index": true,
         "analyzer": "keyword",
         "include_in_all": false
        },
       "directors": {
         "type": "text",
         "analyzer": "my_analyzer",
         "index": true,
         "search_analyzer": "my_analyzer"
        },
       "title": {
         "type": "text",
         "analyzer": "my_analyzer",
         "search_analyzer": "my_analyzer"
        },
       "title_vie": {
         "type": "text",
         "analyzer": "my_analyzer",
         "search_analyzer": "my_analyzer"
        },
       "title_origin": {
         "type": "text",
         "analyzer": "my_analyzer",
         "search_analyzer": "my_analyzer"
        },
       "platforms": {
         "type": "text",
         "index": true,
         "analyzer": "keyword",
         "include_in_all": false
      }
     }
    }
   }
}'
