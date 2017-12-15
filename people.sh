curl -XPUT localhost:9200/_template/people01 -d '{
  "template": "people*",
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
        "tokenizer": "standard",
        "filter": ["lowercase", "filter_shingle", "my_ascii_folding"]
       },
      "keyword_analyzer": {
	"type": "custom",
	"tokenizer": "keyword",
        "filter": ["lowercase", "my_ascii_folding"]  
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
        "max_shingle_size":6,
        "min_shingle_size":2,
        "output_unigrams": true,
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
    "people-mapping": {
      "_all": {
       "enabled": false
      },
      "properties": {
       "birth_day": {
         "type": "text",
         "index": false
        },
       "portrait": {
         "type": "text",
         "index": false
        },
       "bio_vie": {
         "type": "text",
         "index": false
        },
       "avatar": {
         "type": "text",
         "index": false
        },
       "event_type": {
         "type": "text",
         "index": false
        },
       "source_url": {
         "type": "text",
         "index": false
        },
       "character": {
         "type": "text",
         "index": false
        },
       "bio": {
         "type": "text",
         "index": false
        },
       "vie_name": {
         "type": "text",
         "index": true,
         "analyzer": "keyword_analyzer",
         "search_analyzer": "keyword_analyzer"
        },
       "slug": {
         "type": "text",
         "analyzer": "whitespace_analyzer",
         "index": true,
         "search_analyzer": "whitespace_analyzer"
        },
       "full_name": {
         "type": "text",
         "analyzer": "whitespace_analyzer",
         "search_analyzer": "whitespace_analyzer"
        },
       "alt_name": {
         "type": "text",
         "analyzer": "whitespace_analyzer",
         "search_analyzer": "whitespace_analyzer"
        }
     }
    }
   }
}'

