{% if config.feed and config.feed.path %}
    {% set theme.feed = config.root + config.feed.path %}
{% endif %}

<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

{% if theme.google_site_verification %}
  <meta name="google-site-verification" content="{{ theme.google_site_verification }}" />
{% endif %}

{% if theme.fancybox %}
  <link rel="stylesheet" type="text/css" href="{{ url_for(theme.vendors) }}/fancybox/source/jquery.fancybox.css?v=2.1.5"/>
{% endif %}

<link rel="stylesheet" type="text/css" href="{{ url_for(theme.css) }}/main.css?v={{ theme.version }}"/>

{% if theme.awesome %}
  <link rel="stylesheet" type="text/css" href="{{ url_for(theme.vendors) }}/awesome/css/font-awesome.min.css?v=4.3.0"/>
{% endif %}

{% if config.description %}
    <meta name="description" content="{{ config.description }}" />
{% endif %}

{% if page.tags and page.tags.length %}
	<meta name="keywords" content="{% for tag in page.tags %}{{ tag.name }},{% endfor %}" />
{% else %}
{% if theme.keywords %}
    <meta name="keywords" content="{{ theme.keywords }}" />
{% endif %}

{% if theme.feed %}
    <link rel="alternate" href="{{ url_for(theme.feed) }}" title="{{ config.title }}" type="application/atom+xml" />
{% endif %}

{% if theme.favicon %}
    <link rel="shorticon icon" type="image/x-icon" href="{{ url_for(theme.favicon) }}?v={{ theme.version }}" />
{% endif %}

{% include 'analytics/baidu-analytics.swig' %}