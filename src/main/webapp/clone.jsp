<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>无标题文档</title>
 <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>	
 
 <script language="javascript" type="text/javascript">
 $(document).ready(function(){
   
    $('span.pull-quote').each(function(index) {
    var $parentParagraph = $(this).parent('p');
    $parentParagraph.css('position', 'relative');

    var $clonedCopy = $(this).clone();

    $clonedCopy
      .addClass('pulled')
      .find('span.drop')
        .html('&hellip;')
      .end()
      .prependTo($parentParagraph)
      .wrap('<div class="pulled-wrapper"></div>');

    var clonedText = $clonedCopy.text();
    $clonedCopy.html(clonedText);
  });
 });
 </script>
 
 <style type="text/css">
 html, body {
  margin: 0;
  padding: 0;
}

body {
  font: 62.5% Arial, Verdana, sans-serif;
  color: #000;
  background: #fff;
}
#container {
  font-size: 1.2em;
  margin: 10px 2em;
}

h1 {
  font-size: 2.5em;
  margin-bottom: 0;
}
h1.subtitle {
  font: italic normal 1.5em "Times New Roman", Times, serif;
  margin-top: 0;
  margin-bottom: 2em;
}
h2 {
  font-size: 1.3em;
  margin-bottom: .5em;
}
h2.subtitle {
  font: italic normal 1em "Times New Roman", Times, serif;
  margin-top: 0;
  margin-bottom: .5em;
}
h3 {
  font-size: 1.1em;
  margin-bottom: 0;
}
#branding {
  border-bottom: 1px solid #e3e3e3;
  margin-bottom: .5em;
}
#chapter-number {
  float: right;
  font: normal 7em "Times New Roman", Times, serif;
  margin-top: -15px;
}

/* ----------------------------
=Alsett Clearing Method for floats 
-------------------------------*/  
.clearfix:after {
  content: ".";
  display: block;
  height: 0;
  clear: both;
  visibility: hidden;
  }
.clearfix {display: inline-block;}
/* backslash hack hides from IE Mac \*/
 * html .clearfix {height: 1%;}
 .clearfix {display: block;}
/* end backslash hack */
.chapter {
  width: 42em;
}
#f-title {
  font-size: 1.5em;
}
#excerpt {
  font-style: italic;
}

/* -----------------------------------
   =FOOTNOTES
-------------------------------------- */

span.footnote {
  font-style: italic;
  font-family: "Times New Roman", Times, serif;
  display: block;
  margin: 1em 0;
}

.chapter span.footnote {
  display: inline;
}
.text-reference {
  font-weight: bold;
}
#notes li {
 margin: 1em 0; 
}

#notes {
  margin-top: 1em;
  border-top: 1px solid #dedede;  
}
#footer {
  margin-top: 1em;
  border-top: 1px solid #dedede;
}

/* -----------------------------------
   =SIMPLE PULL-QUOTE
-------------------------------------- */
/*.pulled {
  background: #e5e5e5;
  position: absolute;
  width: 145px;
  top: -20px;
  right: -180px;
  padding: 12px 5px 12px 10px;
  font: italic 1.4em "Times New Roman", Times, serif;
}
*/
/* -----------------------------------
   =PULL-QUOTE WITH ROUNDED CORNERS AND DROP SHADOWS
-------------------------------------- */


.pulled-wrapper {
  background: url(pq-top.jpg) no-repeat left top;
  position: absolute;
  width: 160px;
  right: -180px;
  padding-top: 18px;
}
.pulled {
  background: url(pq-bottom.jpg) no-repeat left bottom;  
  position: relative;
  display: block;
  width: 140px;
  padding: 0 10px 24px 10px;
  font: italic 1.4em "Times New Roman", Times, serif;
}
 </style>
</head>

<body>
  <div id="container">
    <div id="branding" class="clearfix">
      <div id="chapter-number">
        5
      </div>

      <h1>DOM Manipulation</h1>

      <h1 class="subtitle">How to Change Your Page on Command</h1>
    </div>
    
<!-- Begin example  -->
  
<h1 id="f-title">Flatland: A Romance of Many Dimensions</h1>
<div id="f-author">by Edwin A. Abbott</div>
<h2>Part 1, Section 3</h2>
<h3 id="f-subtitle">Concerning the Inhabitants of Flatland</h3>
<div id="excerpt">an excerpt</div>

<div class="chapter">
  <p class="square">Our Professional Men and Gentlemen are Squares (to which class I myself belong) and Five-Sided Figures or <a href="http://en.wikipedia.org/wiki/Pentagon">Pentagons</a>.</p>

  <p class="nobility hexagon">Next above these come the Nobility, of whom there are several degrees, beginning at Six-Sided Figures, or <a href="http://en.wikipedia.org/wiki/Hexagon">Hexagons</a>, and from thence rising in the number of their sides till they receive the honourable title of <a href="http://en.wikipedia.org/wiki/Polygon">Polygonal</a>, or many-Sided. Finally when the number of the sides becomes so numerous, and the sides themselves so small, that the figure cannot be distinguished from a <a href="http://en.wikipedia.org/wiki/Circle">circle</a>, he is included in the Circular or Priestly order; and this is the highest class of all.</p>

  <p><span class="pull-quote">It is a Law of Nature <span class="drop">with us</span> that a male child shall have <strong>one more side</strong> than his father</span>, so that each generation shall rise (as a rule) one step in the scale of development and nobility. Thus the son of a Square is a Pentagon; the son of a Pentagon, a Hexagon; and so on.</p>

  <p>But this rule applies not always to the Tradesman, and still less often to the Soldiers, and to the Workmen; who indeed can hardly be said to deserve the name of human Figures, since they have not all their sides equal. With them therefore the Law of Nature does not hold; and the son of an Isosceles (i.e. a Triangle with two sides equal) remains Isosceles still. Nevertheless, all hope is not such out, even from the Isosceles, that his posterity may ultimately rise above his degraded condition.&hellip;</p>

  <p>Rarely&mdash;in proportion to the vast numbers of Isosceles births&mdash;is a genuine and certifiable Equal-Sided Triangle produced from Isosceles parents. <span class="footnote">"What need of a certificate?" a Spaceland critic may ask: "Is not the procreation of a Square Son a certificate from Nature herself, proving the Equal-sidedness of the Father?" I reply that no Lady of any position will marry an uncertified Triangle. Square offspring has sometimes resulted from a slightly Irregular Triangle; but in almost every such case the Irregularity of the first generation is visited on the third; which either fails to attain the Pentagonal rank, or relapses to the Triangular.</span> Such a birth requires, as its antecedents, not only a series of carefully arranged intermarriages, but also a long-continued exercise of frugality and self-control on the part of the would-be ancestors of the coming Equilateral, and a patient, systematic, and continuous development of the Isosceles intellect through many generations.</p>

  <p><span class="pull-quote">The birth  of a True Equilateral Triangle from Isosceles parents is the subject of rejoicing in our country <span class="drop">for many furlongs round</span>.</span> After a strict examination conducted by the Sanitary and Social Board, the infant, if certified as Regular, is with solemn ceremonial admitted into the class of Equilaterals. He is then immediately taken from his proud yet sorrowing parents and adopted by some childless Equilateral. <span class="footnote">The Equilateral is bound by oath never to permit the child henceforth to enter his former home or so much as to look upon his relations again, for fear lest the freshly developed organism may, by force of unconscious imitation, fall back again into his hereditary level.</span></p>
  
  <p>How admirable is the Law of Compensation! <span class="footnote">And how perfect a proof of the natural fitness and, I may almost say, the divine origin of the aristocratic constitution of the States of Flatland!</span> By a judicious use of this Law of Nature, the Polygons and Circles are almost always able to stifle sedition in its very cradle, taking advantage of the irrepressible and boundless hopefulness of the human mind.&hellip;</p>

  <p>Then the wretched rabble of the Isosceles, planless and leaderless, are ether transfixed without resistance by the small body of their brethren whom the Chief Circle keeps in pay for emergencies of this kind; or else more often, by means of jealousies and suspicious skillfully fomented among them by the Circular party, they are stirred to mutual warfare, and perish by one another's angles. No less than one hundred and twenty rebellions are recorded in our annals, besides minor outbreaks numbered at two hundred and thirty-five; and they have all ended thus.</p>
</div>
<div id="footer">
  <p>Read the <a href="http://web.archive.org/web/20050208012252/http://www.ibiblio.org/eldritch/eaa/FL.HTM">complete text of <i>Flatland</i></a>. Learn about the upcoming <a href="http://www.flatlandthemovie.com/">Flatland movie</a>.</p>
</div>

<!-- End example  -->
  </div>
</body>
</html>