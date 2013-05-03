```
            o8o
            `"'
 .ooooo oo oooo   .oooo.o
d88' `888  `888  d88(  "8
888   888   888  `"Y88b.
888   888   888  o.  )88b
`V8bod888  o888o 8""888P'
      888.
      8P'
      "
```


Quick Instagram search tool.

Requires [Sinatra](http://www.sinatrarb.com/)

## Quick Start

0. `bundle install`

1. Register for a new [Instagram client application](http://instagram.com/developer/clients/register/) and set your OAuth redirect_uri to `http://localhost:4567/`.

2. Get a [Google Maps API key](https://developers.google.com/maps/documentation/javascript/tutorial#api_key).

3. Create a `keys.yml` file in the root of the app, and set it like so:

```
instagram_client_id: YOUR_KEY
instagram_secret: YOUR_KEY
google_client_id: YOUR_KEY
google_key: YOUR_KEY
```

2. Run using `ruby app.rb` or however you like running Sinatra apps.

