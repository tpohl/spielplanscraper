# -*- coding: utf-8 -*-
import scrapy


class DatesSpider(scrapy.Spider):
    name = "dates"
    allowed_domains = ["meinspielplan.de"]
    start_urls = ['http://www.meinspielplan.de/plan/JVt7Sv?a=dates']

    def parse(self, response):
        for match in response.css('tr.select_matches'):
           result =  match.css("div.dates_match_result::text")
           score1 = result.extract_first()
           score2 = None;
           if score1 is not None:
              score1 = score1.strip()
              score2 = result[1].extract().strip();
           yield {
             'player1': match.css("a.team_link::text")[0].extract().strip(),
             'player2': match.css("a.team_link::text")[1].extract().strip(),
             'score1': score1,
             'score2': score2,
           }
