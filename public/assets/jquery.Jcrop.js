/**
 * jquery.Jcrop.js v0.9.12
 * jQuery Image Cropping Plugin - released under MIT License 
 * Author: Kelly Hallman <khallman@gmail.com>
 * http://github.com/tapmodo/Jcrop
 * Copyright (c) 2008-2013 Tapmodo Interactive LLC {{{
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * }}}
 */
!function(t){t.Jcrop=function(e,i){function n(t){return Math.round(t)+"px"}function s(t){return z.baseClass+"-"+t}function o(){return t.fx.step.hasOwnProperty("backgroundColor")}function r(e){var i=t(e).offset();return[i.left,i.top]}function a(t){return[t.pageX-L[0],t.pageY-L[1]]}function l(e){"object"!=typeof e&&(e={}),z=t.extend(z,e),t.each(["onChange","onSelect","onRelease","onDblClick"],function(t,e){"function"!=typeof z[e]&&(z[e]=function(){})})}function h(t,e,i){if(L=r(Y),fe.setCursor("move"===t?t:t+"-resize"),"move"===t)return fe.activateHandlers(u(e),g,i);var n=ue.getFixed(),s=d(t),o=ue.getCorner(d(s));ue.setPressed(ue.getCorner(s)),ue.setCurrent(o),fe.activateHandlers(c(t,n),g,i)}function c(t,e){return function(i){if(z.aspectRatio)switch(t){case"e":i[1]=e.y+1;break;case"w":i[1]=e.y+1;break;case"n":i[0]=e.x+1;break;case"s":i[0]=e.x+1}else switch(t){case"e":i[1]=e.y2;break;case"w":i[1]=e.y2;break;case"n":i[0]=e.x2;break;case"s":i[0]=e.x2}ue.setCurrent(i),pe.update()}}function u(t){var e=t;return me.watchKeys(),function(t){ue.moveOffset([t[0]-e[0],t[1]-e[1]]),e=t,pe.update()}}function d(t){switch(t){case"n":return"sw";case"s":return"nw";case"e":return"nw";case"w":return"ne";case"ne":return"sw";case"nw":return"se";case"se":return"nw";case"sw":return"ne"}}function p(t){return function(e){return z.disabled?!1:"move"!==t||z.allowMove?(L=r(Y),ne=!0,h(t,a(e)),e.stopPropagation(),e.preventDefault(),!1):!1}}function f(t,e,i){var n=t.width(),s=t.height();n>e&&e>0&&(n=e,s=e/t.width()*t.height()),s>i&&i>0&&(s=i,n=i/t.height()*t.width()),ee=t.width()/n,ie=t.height()/s,t.width(n).height(s)}function m(t){return{x:t.x*ee,y:t.y*ie,x2:t.x2*ee,y2:t.y2*ie,w:t.w*ee,h:t.h*ie}}function g(){var t=ue.getFixed();t.w>z.minSelect[0]&&t.h>z.minSelect[1]?(pe.enableHandles(),pe.done()):pe.release(),fe.setCursor(z.allowSelect?"crosshair":"default")}function v(t){if(z.disabled)return!1;if(!z.allowSelect)return!1;ne=!0,L=r(Y),pe.disableHandles(),fe.setCursor("crosshair");var e=a(t);return ue.setPressed(e),pe.update(),fe.activateHandlers(y,g,"touch"===t.type.substring(0,5)),me.watchKeys(),t.stopPropagation(),t.preventDefault(),!1}function y(t){ue.setCurrent(t),pe.update()}function b(){var e=t("<div></div>").addClass(s("tracker"));return N&&e.css({opacity:0,backgroundColor:"white"}),e}function x(t){U.removeClass().addClass(s("holder")).addClass(t)}function w(t,e){function i(){window.setTimeout(y,u)}var n=t[0]/ee,s=t[1]/ie,o=t[2]/ee,r=t[3]/ie;if(!se){var a=ue.flipCoords(n,s,o,r),l=ue.getFixed(),h=[l.x,l.y,l.x2,l.y2],c=h,u=z.animationDelay,d=a[0]-h[0],p=a[1]-h[1],f=a[2]-h[2],m=a[3]-h[3],g=0,v=z.swingSpeed;n=c[0],s=c[1],o=c[2],r=c[3],pe.animMode(!0);var y=function(){return function(){g+=(100-g)/v,c[0]=Math.round(n+g/100*d),c[1]=Math.round(s+g/100*p),c[2]=Math.round(o+g/100*f),c[3]=Math.round(r+g/100*m),g>=99.8&&(g=100),100>g?(_(c),i()):(pe.done(),pe.animMode(!1),"function"==typeof e&&e.call(ge))}}();i()}}function k(t){_([t[0]/ee,t[1]/ie,t[2]/ee,t[3]/ie]),z.onSelect.call(ge,m(ue.getFixed())),pe.enableHandles()}function _(t){ue.setPressed([t[0],t[1]]),ue.setCurrent([t[2],t[3]]),pe.update()}function C(){return m(ue.getFixed())}function T(){return ue.getFixed()}function S(t){l(t),F()}function D(){z.disabled=!0,pe.disableHandles(),pe.setCursor("default"),fe.setCursor("default")}function P(){z.disabled=!1,F()}function A(){pe.done(),fe.activateHandlers(null,null)}function M(){U.remove(),B.show(),B.css("visibility","visible"),t(e).removeData("Jcrop")}function E(t,e){pe.release(),D();var i=new Image;i.onload=function(){var n=i.width,s=i.height,o=z.boxWidth,r=z.boxHeight;Y.width(n).height(s),Y.attr("src",t),G.attr("src",t),f(Y,o,r),X=Y.width(),$=Y.height(),G.width(X).height($),ae.width(X+2*re).height($+2*re),U.width(X).height($),de.resize(X,$),P(),"function"==typeof e&&e.call(ge)},i.src=t}function I(t,e,i){var n=e||z.bgColor;z.bgFade&&o()&&z.fadeTime&&!i?t.animate({backgroundColor:n},{queue:!1,duration:z.fadeTime}):t.css("backgroundColor",n)}function F(t){z.allowResize?t?pe.enableOnly():pe.enableHandles():pe.disableHandles(),fe.setCursor(z.allowSelect?"crosshair":"default"),pe.setCursor(z.allowMove?"move":"default"),z.hasOwnProperty("trueSize")&&(ee=z.trueSize[0]/X,ie=z.trueSize[1]/$),z.hasOwnProperty("setSelect")&&(k(z.setSelect),pe.done(),delete z.setSelect),de.refresh(),z.bgColor!=le&&(I(z.shade?de.getShades():U,z.shade?z.shadeColor||z.bgColor:z.bgColor),le=z.bgColor),he!=z.bgOpacity&&(he=z.bgOpacity,z.shade?de.refresh():pe.setBgOpacity(he)),Q=z.maxSize[0]||0,Z=z.maxSize[1]||0,J=z.minSize[0]||0,te=z.minSize[1]||0,z.hasOwnProperty("outerImage")&&(Y.attr("src",z.outerImage),delete z.outerImage),pe.refresh()}var L,z=t.extend({},t.Jcrop.defaults),j=navigator.userAgent.toLowerCase(),N=/msie/.test(j),H=/msie [1-6]\./.test(j);"object"!=typeof e&&(e=t(e)[0]),"object"!=typeof i&&(i={}),l(i);var O={border:"none",visibility:"visible",margin:0,padding:0,position:"absolute",top:0,left:0},B=t(e),W=!0;if("IMG"==e.tagName){if(0!=B[0].width&&0!=B[0].height)B.width(B[0].width),B.height(B[0].height);else{var R=new Image;R.src=B[0].src,B.width(R.width),B.height(R.height)}var Y=B.clone().removeAttr("id").css(O).show();Y.width(B.width()),Y.height(B.height()),B.after(Y).hide()}else Y=B.css(O).show(),W=!1,null===z.shade&&(z.shade=!0);f(Y,z.boxWidth,z.boxHeight);var X=Y.width(),$=Y.height(),U=t("<div />").width(X).height($).addClass(s("holder")).css({position:"relative",backgroundColor:z.bgColor}).insertAfter(B).append(Y);z.addClass&&U.addClass(z.addClass);var G=t("<div />"),V=t("<div />").width("100%").height("100%").css({zIndex:310,position:"absolute",overflow:"hidden"}),q=t("<div />").width("100%").height("100%").css("zIndex",320),K=t("<div />").css({position:"absolute",zIndex:600}).dblclick(function(){var t=ue.getFixed();z.onDblClick.call(ge,t)}).insertBefore(Y).append(V,q);W&&(G=t("<img />").attr("src",Y.attr("src")).css(O).width(X).height($),V.append(G)),H&&K.css({overflowY:"hidden"});var Q,Z,J,te,ee,ie,ne,se,oe,re=z.boundary,ae=b().width(X+2*re).height($+2*re).css({position:"absolute",top:n(-re),left:n(-re),zIndex:290}).mousedown(v),le=z.bgColor,he=z.bgOpacity;L=r(Y);var ce=function(){function t(){var t,e={},i=["touchstart","touchmove","touchend"],n=document.createElement("div");try{for(t=0;t<i.length;t++){var s=i[t];s="on"+s;var o=s in n;o||(n.setAttribute(s,"return;"),o="function"==typeof n[s]),e[i[t]]=o}return e.touchstart&&e.touchend&&e.touchmove}catch(r){return!1}}function e(){return z.touchSupport===!0||z.touchSupport===!1?z.touchSupport:t()}return{createDragger:function(t){return function(e){return z.disabled?!1:"move"!==t||z.allowMove?(L=r(Y),ne=!0,h(t,a(ce.cfilter(e)),!0),e.stopPropagation(),e.preventDefault(),!1):!1}},newSelection:function(t){return v(ce.cfilter(t))},cfilter:function(t){return t.pageX=t.originalEvent.changedTouches[0].pageX,t.pageY=t.originalEvent.changedTouches[0].pageY,t},isSupported:t,support:e()}}(),ue=function(){function t(t){t=r(t),f=d=t[0],m=p=t[1]}function e(t){t=r(t),c=t[0]-f,u=t[1]-m,f=t[0],m=t[1]}function i(){return[c,u]}function n(t){var e=t[0],i=t[1];0>d+e&&(e-=e+d),0>p+i&&(i-=i+p),m+i>$&&(i+=$-(m+i)),f+e>X&&(e+=X-(f+e)),d+=e,f+=e,p+=i,m+=i}function s(t){var e=o();switch(t){case"ne":return[e.x2,e.y];case"nw":return[e.x,e.y];case"se":return[e.x2,e.y2];case"sw":return[e.x,e.y2]}}function o(){if(!z.aspectRatio)return l();var t,e,i,n,s=z.aspectRatio,o=z.minSize[0]/ee,r=z.maxSize[0]/ee,c=z.maxSize[1]/ie,u=f-d,g=m-p,v=Math.abs(u),y=Math.abs(g),b=v/y;return 0===r&&(r=10*X),0===c&&(c=10*$),s>b?(e=m,i=y*s,t=0>u?d-i:i+d,0>t?(t=0,n=Math.abs((t-d)/s),e=0>g?p-n:n+p):t>X&&(t=X,n=Math.abs((t-d)/s),e=0>g?p-n:n+p)):(t=f,n=v/s,e=0>g?p-n:p+n,0>e?(e=0,i=Math.abs((e-p)*s),t=0>u?d-i:i+d):e>$&&(e=$,i=Math.abs(e-p)*s,t=0>u?d-i:i+d)),t>d?(o>t-d?t=d+o:t-d>r&&(t=d+r),e=e>p?p+(t-d)/s:p-(t-d)/s):d>t&&(o>d-t?t=d-o:d-t>r&&(t=d-r),e=e>p?p+(d-t)/s:p-(d-t)/s),0>t?(d-=t,t=0):t>X&&(d-=t-X,t=X),0>e?(p-=e,e=0):e>$&&(p-=e-$,e=$),h(a(d,p,t,e))}function r(t){return t[0]<0&&(t[0]=0),t[1]<0&&(t[1]=0),t[0]>X&&(t[0]=X),t[1]>$&&(t[1]=$),[Math.round(t[0]),Math.round(t[1])]}function a(t,e,i,n){var s=t,o=i,r=e,a=n;return t>i&&(s=i,o=t),e>n&&(r=n,a=e),[s,r,o,a]}function l(){var t,e=f-d,i=m-p;return Q&&Math.abs(e)>Q&&(f=e>0?d+Q:d-Q),Z&&Math.abs(i)>Z&&(m=i>0?p+Z:p-Z),te/ie&&Math.abs(i)<te/ie&&(m=i>0?p+te/ie:p-te/ie),J/ee&&Math.abs(e)<J/ee&&(f=e>0?d+J/ee:d-J/ee),0>d&&(f-=d,d-=d),0>p&&(m-=p,p-=p),0>f&&(d-=f,f-=f),0>m&&(p-=m,m-=m),f>X&&(t=f-X,d-=t,f-=t),m>$&&(t=m-$,p-=t,m-=t),d>X&&(t=d-$,m-=t,p-=t),p>$&&(t=p-$,m-=t,p-=t),h(a(d,p,f,m))}function h(t){return{x:t[0],y:t[1],x2:t[2],y2:t[3],w:t[2]-t[0],h:t[3]-t[1]}}var c,u,d=0,p=0,f=0,m=0;return{flipCoords:a,setPressed:t,setCurrent:e,getOffset:i,moveOffset:n,getCorner:s,getFixed:o}}(),de=function(){function e(t,e){f.left.css({height:n(e)}),f.right.css({height:n(e)})}function i(){return s(ue.getFixed())}function s(t){f.top.css({left:n(t.x),width:n(t.w),height:n(t.y)}),f.bottom.css({top:n(t.y2),left:n(t.x),width:n(t.w),height:n($-t.y2)}),f.right.css({left:n(t.x2),width:n(X-t.x2)}),f.left.css({width:n(t.x)})}function o(){return t("<div />").css({position:"absolute",backgroundColor:z.shadeColor||z.bgColor}).appendTo(p)}function r(){d||(d=!0,p.insertBefore(Y),i(),pe.setBgOpacity(1,0,1),G.hide(),a(z.shadeColor||z.bgColor,1),pe.isAwake()?h(z.bgOpacity,1):h(1,1))}function a(t,e){I(u(),t,e)}function l(){d&&(p.remove(),G.show(),d=!1,pe.isAwake()?pe.setBgOpacity(z.bgOpacity,1,1):(pe.setBgOpacity(1,1,1),pe.disableHandles()),I(U,0,1))}function h(t,e){d&&(z.bgFade&&!e?p.animate({opacity:1-t},{queue:!1,duration:z.fadeTime}):p.css({opacity:1-t}))}function c(){z.shade?r():l(),pe.isAwake()&&h(z.bgOpacity)}function u(){return p.children()}var d=!1,p=t("<div />").css({position:"absolute",zIndex:240,opacity:0}),f={top:o(),left:o().height($),right:o().height($),bottom:o()};return{update:i,updateRaw:s,getShades:u,setBgColor:a,enable:r,disable:l,resize:e,refresh:c,opacity:h}}(),pe=function(){function e(e){var i=t("<div />").css({position:"absolute",opacity:z.borderOpacity}).addClass(s(e));return V.append(i),i}function i(e,i){var n=t("<div />").mousedown(p(e)).css({cursor:e+"-resize",position:"absolute",zIndex:i}).addClass("ord-"+e);return ce.support&&n.bind("touchstart.jcrop",ce.createDragger(e)),q.append(n),n}function o(t){var e=z.handleSize,n=i(t,D++).css({opacity:z.handleOpacity}).addClass(s("handle"));return e&&n.width(e).height(e),n}function r(t){return i(t,D++).addClass("jcrop-dragbar")}function a(t){var e;for(e=0;e<t.length;e++)M[t[e]]=r(t[e])}function l(t){var i,n;for(n=0;n<t.length;n++){switch(t[n]){case"n":i="hline";break;case"s":i="hline bottom";break;case"e":i="vline right";break;case"w":i="vline"}P[t[n]]=e(i)}}function h(t){var e;for(e=0;e<t.length;e++)A[t[e]]=o(t[e])}function c(t,e){z.shade||G.css({top:n(-e),left:n(-t)}),K.css({top:n(e),left:n(t)})}function u(t,e){K.width(Math.round(t)).height(Math.round(e))}function d(){var t=ue.getFixed();ue.setPressed([t.x,t.y]),ue.setCurrent([t.x2,t.y2]),f()}function f(t){return S?g(t):void 0}function g(t){var e=ue.getFixed();u(e.w,e.h),c(e.x,e.y),z.shade&&de.updateRaw(e),S||y(),t?z.onSelect.call(ge,m(e)):z.onChange.call(ge,m(e))}function v(t,e,i){(S||e)&&(z.bgFade&&!i?Y.animate({opacity:t},{queue:!1,duration:z.fadeTime}):Y.css("opacity",t))}function y(){K.show(),z.shade?de.opacity(he):v(he,!0),S=!0}function x(){_(),K.hide(),z.shade?de.opacity(1):v(1),S=!1,z.onRelease.call(ge)}function w(){E&&q.show()}function k(){return E=!0,z.allowResize?(q.show(),!0):void 0}function _(){E=!1,q.hide()}function C(t){t?(se=!0,_()):(se=!1,k())}function T(){C(!1),d()}var S,D=370,P={},A={},M={},E=!1;z.dragEdges&&t.isArray(z.createDragbars)&&a(z.createDragbars),t.isArray(z.createHandles)&&h(z.createHandles),z.drawBorders&&t.isArray(z.createBorders)&&l(z.createBorders),t(document).bind("touchstart.jcrop-ios",function(e){t(e.currentTarget).hasClass("jcrop-tracker")&&e.stopPropagation()});var I=b().mousedown(p("move")).css({cursor:"move",position:"absolute",zIndex:360});return ce.support&&I.bind("touchstart.jcrop",ce.createDragger("move")),V.append(I),_(),{updateVisible:f,update:g,release:x,refresh:d,isAwake:function(){return S},setCursor:function(t){I.css("cursor",t)},enableHandles:k,enableOnly:function(){E=!0},showHandles:w,disableHandles:_,animMode:C,setBgOpacity:v,done:T}}(),fe=function(){function e(e){ae.css({zIndex:450}),e?t(document).bind("touchmove.jcrop",r).bind("touchend.jcrop",l):d&&t(document).bind("mousemove.jcrop",n).bind("mouseup.jcrop",s)}function i(){ae.css({zIndex:290}),t(document).unbind(".jcrop")}function n(t){return c(a(t)),!1}function s(t){return t.preventDefault(),t.stopPropagation(),ne&&(ne=!1,u(a(t)),pe.isAwake()&&z.onSelect.call(ge,m(ue.getFixed())),i(),c=function(){},u=function(){}),!1}function o(t,i,n){return ne=!0,c=t,u=i,e(n),!1}function r(t){return c(a(ce.cfilter(t))),!1}function l(t){return s(ce.cfilter(t))}function h(t){ae.css("cursor",t)}var c=function(){},u=function(){},d=z.trackDocument;return d||ae.mousemove(n).mouseup(s).mouseout(s),Y.before(ae),{activateHandlers:o,setCursor:h}}(),me=function(){function e(){z.keySupport&&(o.show(),o.focus())}function i(){o.hide()}function n(t,e,i){z.allowMove&&(ue.moveOffset([e,i]),pe.updateVisible(!0)),t.preventDefault(),t.stopPropagation()}function s(t){if(t.ctrlKey||t.metaKey)return!0;oe=t.shiftKey?!0:!1;var e=oe?10:1;switch(t.keyCode){case 37:n(t,-e,0);break;case 39:n(t,e,0);break;case 38:n(t,0,-e);break;case 40:n(t,0,e);break;case 27:z.allowSelect&&pe.release();break;case 9:return!0}return!1}var o=t('<input type="radio" />').css({position:"fixed",left:"-120px",width:"12px"}).addClass("jcrop-keymgr"),r=t("<div />").css({position:"absolute",overflow:"hidden"}).append(o);return z.keySupport&&(o.keydown(s).blur(i),H||!z.fixedSupport?(o.css({position:"absolute",left:"-20px"}),r.append(o).insertBefore(Y)):o.insertBefore(Y)),{watchKeys:e}}();ce.support&&ae.bind("touchstart.jcrop",ce.newSelection),q.hide(),F(!0);var ge={setImage:E,animateTo:w,setSelect:k,setOptions:S,tellSelect:C,tellScaled:T,setClass:x,disable:D,enable:P,cancel:A,release:pe.release,destroy:M,focus:me.watchKeys,getBounds:function(){return[X*ee,$*ie]},getWidgetSize:function(){return[X,$]},getScaleFactor:function(){return[ee,ie]},getOptions:function(){return z},ui:{holder:U,selection:K}};return N&&U.bind("selectstart",function(){return!1}),B.data("Jcrop",ge),ge},t.fn.Jcrop=function(e,i){var n;return this.each(function(){if(t(this).data("Jcrop")){if("api"===e)return t(this).data("Jcrop");t(this).data("Jcrop").setOptions(e)}else"IMG"==this.tagName?t.Jcrop.Loader(this,function(){t(this).css({display:"block",visibility:"hidden"}),n=t.Jcrop(this,e),t.isFunction(i)&&i.call(n)}):(t(this).css({display:"block",visibility:"hidden"}),n=t.Jcrop(this,e),t.isFunction(i)&&i.call(n))}),this},t.Jcrop.Loader=function(e,i,n){function s(){r.complete?(o.unbind(".jcloader"),t.isFunction(i)&&i.call(r)):window.setTimeout(s,50)}var o=t(e),r=o[0];o.bind("load.jcloader",s).bind("error.jcloader",function(){o.unbind(".jcloader"),t.isFunction(n)&&n.call(r)}),r.complete&&t.isFunction(i)&&(o.unbind(".jcloader"),i.call(r))},t.Jcrop.defaults={allowSelect:!0,allowMove:!0,allowResize:!0,trackDocument:!0,baseClass:"jcrop",addClass:null,bgColor:"black",bgOpacity:.6,bgFade:!1,borderOpacity:.4,handleOpacity:.5,handleSize:null,aspectRatio:0,keySupport:!0,createHandles:["n","s","e","w","nw","ne","se","sw"],createDragbars:["n","s","e","w"],createBorders:["n","s","e","w"],drawBorders:!0,dragEdges:!0,fixedSupport:!0,touchSupport:null,shade:null,boxWidth:0,boxHeight:0,boundary:2,fadeTime:400,animationDelay:20,swingSpeed:3,minSelect:[0,0],maxSize:[0,0],minSize:[0,0],onChange:function(){},onSelect:function(){},onDblClick:function(){},onRelease:function(){}}}(jQuery);