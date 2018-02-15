require "firebase"
require "json"

base_uri = 'https://earthquake-info.firebaseio.com/'

firebase_creds = Rails.root.join('lib', 'creds', 'earthquake-info-firebase-adminsdk-46zpb-442a1da06e.json')

firebase_key = File.open(firebase_creds).read

FIREBASE = Firebase::Client.new(base_uri, firebase_key)

# GeoData = JSON.parse(File.read('sample.json'), symbolize_keys: true)