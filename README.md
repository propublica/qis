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

Search Instagram for photos taken at a [given place and time](http://www.propublica.org/nerds/item/a-super-simple-tool-to-search-instagram-by-time-and-location).

## Quick Start

0. `bundle install`

1. Register for a new [Instagram client application](http://instagram.com/developer/clients/register/) and set your OAuth redirect_uri to `http://localhost:4567/`.

2. Get a [Google Maps API key](https://developers.google.com/maps/documentation/javascript/tutorial#api_key).

3. Create a `keys.yml` file in the root of the app, and set it like so:

```
root_uri: http://localhost:4567/
instagram_client_id: YOUR_KEY
instagram_secret: YOUR_KEY
google_client_id: YOUR_KEY
google_key: YOUR_KEY
```

2. Run using `ruby app.rb` or however you like running Sinatra apps.

## License (MIT)

Copyright (c) 2013 ProPublica

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
