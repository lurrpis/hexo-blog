<!doctype html>
<html class="next-plus {% if theme.use_motion %}use-motion{% endif %}">
<head>
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
</head>

<body>
  <div class="container one-column {% block page_class %}{% endblock %}">
    <div id="header" class="header">
      <div class="headband"></div>
        {% include '_partials/header.swig' %}
    </div>

    <div id="main" class="main">
      <div class="main-inner">
        <div id="content" class="content">
          {% if is_home() or is_post() %}
            {% set postsClass = "posts-expand" %}
          {% else %}
            {% set postsClass = "posts-collapse" %}
          {% endif %}

          <div id="posts" class="{{ postsClass }}">
            {% block content %}{% endblock %}
          </div>

          {% if not is_post() and (page.prev || page.next) %}
            <div class="pagination">
              {{ paginator({prev_text: '&laquo;', next_text: '&raquo;'}) }}
            </div>
          {% endif %}
        </div>

        {% include '_partials/sidebar.swig' %}

      </div>
    </div>

    <div id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
      </div>
    </div>

    <div class="back-to-top"></div>
  </div>

  <script type="text/javascript" src="{{ url_for(theme.vendors) }}/jquery/index.js?v=2.1.3"></script>
  {% include '_partials/fancy-box.swig' %}


  {% if theme.use_motion %}

  <script type="text/javascript" src="{{ url_for(theme.vendors) }}/velocity/velocity.min.js"></script>
  <script type="text/javascript" src="{{ url_for(theme.vendors) }}/velocity/velocity.ui.min.js"></script>

  {% if is_home() %}
  <script type="text/javascript">
    $(document).ready(function () {
      $.Velocity.RunSequence([
        { e: $('.brand'), p: { opacity: 1 }, o: { duration: 100 } },
        { e: $('.logo'), p: { opacity: 1, top: 0 }, o: { duration: 50} },
        { e: $('.site-title'), p: { opacity: 1, top: 0 }, o: { duration: 200, sequenceQueue: false } }
      ]);
      $('.menu-item').velocity('transition.slideDownIn', {display: null});
    });
  </script>
  {% endif %}

  <script type="text/javascript">
    $(document).ready(function () {
      if(isDesktop()){ 
        $("#wechat").hover(function(){
          $(".ercode").filter(':not(:animated)').fadeIn();
          $(".sidebar-toggle").filter(':not(:animated)').fadeOut();
          $(".back-to-top").filter(':not(:animated)').fadeOut();
        },function(){
          $(".ercode").fadeOut();
          $(".sidebar-toggle").fadeIn();
          $(".back-to-top").fadeIn();
        })
      }else{
        $("#wechat").html("<i class='fa fa-qq'></i> Online");
        $("#wechat").attr('href','http://wpa.qq.com/msgrd?v=3&uin=28568090&site=lurrpis.com&menu=yes');
      }
      if(isMobile()){
        $(".nav-link").click(function(){
            sidebarHideMotion();
        });
      }

      function getParam(pname) { 
        var params = location.search.substr(1);
        var ArrParam = params.split('&');  
        if (ArrParam.length == 1) {  
          return params.split('=')[1];  
        } else {  
        for (var i = 0; i < ArrParam.length; i++) {  
          if (ArrParam[i].split('=')[0] == pname) {  
              return ArrParam[i].split('=')[1];  
            }  
          }  
        }
      } 

      var anchor = $("#" + getParam("to"));
      if (anchor.length > 0) {
         var pos = anchor.offset().top;  
         var poshigh = anchor.height();  
         $("html,body").animate({ scrollTop: pos-poshigh }, 1000);
      } 

      var body = $('body');
      var isSidebarVisible = false;
      var sidebarToggle = $('.sidebar-toggle');
      var sidebarToggleLine1st = $('.sidebar-toggle-line-first')
      var sidebarToggleLine2nd = $('.sidebar-toggle-line-middle');
      var sidebarToggleLine3rd = $('.sidebar-toggle-line-last');
      var sidebar = $('.sidebar');

      var sidebarToogleLineStatusInit = {width: '100%', opacity: 1, left: 0, rotateZ: 0, top: 0};

      var sidebarToggleLine1stStatusInit = sidebarToogleLineStatusInit;
      var sidebarToggleLine1stStatusArrow = {width: '50%', rotateZ: '-45deg', top: '2px'};
      var sidebarToogleLine1stStatusClose = {width: '100%', rotateZ: '-45deg', top: '5px'};

      var sidebarToggleLine2ndStatusInit = sidebarToogleLineStatusInit;
      var sidebarToggleLine2ndStatusArrow = {width: '90%'};
      var sidebarToogleLine2ndStatusClose = {opacity: 0};

      var sidebarToggleLine3rdStatusInit = sidebarToogleLineStatusInit;
      var sidebarToggleLine3rdStatusArrow = {width: '50%', rotateZ: '45deg', top: '-2px'};
      var sidebarToogleLine3rdStatusClose = {width: '100%', rotateZ: '45deg', top: '-5px'};

      sidebatToggleMotion();
      postsListMotion();
      backToTopMotion();

      function sidebarContentMotion () {
        $('.sidebar .motion-element').velocity(
          'transition.slideRightIn',
          {stagger: 50, drag: true}
        );
      }

      function backToTopMotion () {
        var b2top = $('.back-to-top');
        b2top.on('click', function () {
          body.velocity('scroll');
        });
      }

      function sidebarShowMotion () {
        var sidebarDisplayDuration = 300;
        if(isMobile())
          var sidebarWidth = '100%';
        else
          var sidebarWidth = '320px';

        sidebarToggleLine1st.velocity(sidebarToogleLine1stStatusClose);
        sidebarToggleLine2nd.velocity(sidebarToogleLine2ndStatusClose);
        sidebarToggleLine3rd.velocity(sidebarToogleLine3rdStatusClose);

        sidebar.velocity({width: sidebarWidth}, sidebarDisplayDuration);
        isDesktop() && body.velocity({paddingRight: sidebarWidth}, sidebarDisplayDuration);
        sidebarContentMotion();
      }

      function sidebarHideMotion () {
        isDesktop() && body.velocity({paddingRight: 0});
        sidebar.velocity('reverse');

        sidebarToggleLine1st.velocity(sidebarToggleLine1stStatusInit);
        sidebarToggleLine2nd.velocity(sidebarToggleLine2ndStatusInit);
        sidebarToggleLine3rd.velocity(sidebarToggleLine3rdStatusInit);
      };

      function postsListMotion () {
      var postMotionOptions = window.postMotionOptions || {stagger: 300, drag: true};
      $('.post').velocity('transition.slideDownIn', postMotionOptions);
    }

      function sidebatToggleMotion () {
        sidebarToggle.on('click', function () {
          isSidebarVisible ? sidebarHideMotion() : sidebarShowMotion();
          isSidebarVisible = !isSidebarVisible;
        });
        if(isDesktop()){
          sidebarToggle.hover(function () {
            if (isSidebarVisible) {return}
            sidebarToggleLine1st.velocity('stop').velocity(sidebarToggleLine1stStatusArrow);
            sidebarToggleLine2nd.velocity('stop').velocity(sidebarToggleLine2ndStatusArrow);
            sidebarToggleLine3rd.velocity('stop').velocity(sidebarToggleLine3rdStatusArrow);
          }, function () {
            if (isSidebarVisible) {return}
            sidebarToggleLine1st.velocity('stop').velocity(sidebarToggleLine1stStatusInit);
            sidebarToggleLine2nd.velocity('stop').velocity(sidebarToggleLine2ndStatusInit);
            sidebarToggleLine3rd.velocity('stop').velocity(sidebarToggleLine3rdStatusInit);
          });
        }
      }
    });

    function isDesktop () {
      return screen.width > 991;
    }

    function isTablet () {
      return screen.width < 992 && screen.width > 767;
    }

    function isMobile () {
      return screen.width < 767;
    }
  </script>

  {% else %}
    <script type="text/javascript">
      $(document).ready(function () {
        var isSidebarVisible;
        var DURATION = 300;
        var SIDEBAR_WIDTH = 320;

        sidebar();
        backToTop();

        function sidebar() {
          $('.sidebar-toggle').on('click', function () {
            var sidebarWidth = isSidebarVisible ? 0 : SIDEBAR_WIDTH;
            $('.sidebar').animate({
              width: sidebarWidth
            }, DURATION);
            isSidebarVisible = !isSidebarVisible;
          });
        }

        function backToTop() {
          $('.back-to-top').on('click', function () {
            $('html, body').animate({
              scrollTop: 0
            }, DURATION);
          });
        }
      });
    </script>
  {% endif %}
  {% block script_extra %}{% endblock %}
  {% include '_partials/comments/duoshuo.swig' %}
  {% include '_partials/analytics/baidu-analytics.swig' %}
</body>
</html>
