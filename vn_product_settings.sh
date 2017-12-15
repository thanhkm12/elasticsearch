curl -XPUT localhost:9200/_template/fteluv01 -d '{
  "template": "fteluv*",
  "settings": {
   "number_of_shards" : 1,
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
         "filter": ["lowercase", "my_ascii_folding", "text_filter", "filter_shingle"]
                 },
      "whitespace_analyzer": {
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": [ "lowercase", "my_ascii_folding"]
        },
      "viet_analyzer":{
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": ["lowercase", "text_filter", "SYNONYM", "filter_shingle", "my_ascii_folding"]
       },
      "viet_analyzer_test":{
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": ["lowercase", "text_filter", "SYNONYM", "filter_shingle_test", "my_ascii_folding"]
       },
      "keyword_analyzer": {
        "type": "custom",
        "tokenizer": "keyword",
        "filter": ["lowercase", "my_ascii_folding"]
        },
      "vietname_analyzer_search": {
        "type": "custom",
        "filter": ["standard", "lowercase", "my_ascii_folding"],
        "tokenizer": "vi_tokenizer"
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
      "filter_shingle": {
        "type":"shingle",
        "max_shingle_size":5,
        "min_shingle_size":2,
        "output_unigrams": true,
        "tokenizer": "vi_tokenizer"
       },
      "filter_shingle_test": {
        "type":"shingle",
        "max_shingle_size":5,
        "min_shingle_size":2,
        "output_unigrams": false,
        "tokenizer": "vi_tokenizer"
       },
      "englishSnowball" : {
        "type" : "snowball",
        "language" : "english"
         },
      "my_ascii_folding": {
        "type": "asciifolding",
        "preserve_original": true
       },
      "Edge_NGRAM": {
        "type": "edge_ngram",
        "min_gram": 1,
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
         "analyzer": "viet_analyzer",
         "search_analyzer": "vietname_analyzer_search"
        },
       "description": {
         "type": "text",
         "index": false
        },
       "directors": {
         "type": "text",
         "analyzer": "viet_analyzer",
         "index": true,
         "search_analyzer": "vietname_analyzer_search"
        },
       "title": {
         "type": "text",
         "analyzer": "viet_analyzer",
         "search_analyzer": "vietname_analyzer_search"
        },
       "title_vie": {
         "type": "text",
         "analyzer": "viet_analyzer",
         "search_analyzer": "vietname_analyzer_search"
        },
       "title_origin": {
         "type": "text",
         "analyzer": "viet_analyzer",
         "search_analyzer": "vietname_analyzer_search"
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
