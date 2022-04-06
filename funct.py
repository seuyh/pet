import requests
from lxml import html


def technical_search(technical_cout, search_res_url, headers=None):
    if headers is None:
        headers = {'user-agent': 'OPR/73.0.3856.438 (Edition Yx GX)'}
    technical_default = 86400
    technical_text = '1 день'
    if technical_cout == 0:
        technical_default = '86400'
        technical_text = '1 день'
    elif technical_cout == 1:
        technical_default = 'week'
        technical_text = '1 неделю'
    elif technical_cout == 2:
        technical_default = 'month'
        technical_text = '1 месяц'
    elif technical_cout == -1:
        technical_default = '18000'
        technical_text = '5 часов'
    elif technical_cout == -2:
        technical_default = '3600'
        technical_text = '1 час'
    elif technical_cout == -3:
        technical_default = '1800'
        technical_text = '30 минут'
    elif technical_cout == -4:
        technical_default = '900'
        technical_text = '15 минут'
    elif technical_cout == -5:
        technical_default = '300'
        technical_text = '5 минут'
    elif technical_cout == -6:
        technical_default = '60'
        technical_text = '1 минута'
    search_res_url_tec = f'{search_res_url}-technical?period={technical_default}'
    response_search_res_tec = requests.get(search_res_url_tec, headers=headers)
    parser_tree_res_tec = html.fromstring(response_search_res_tec.content)
    indicators1 = ''.join(parser_tree_res_tec.xpath(
        '//div[@id="techinalContent"]/div/div[@class = '
        '"summaryTableLine"][1]/span[1]//text()')) + '\n  ' + ''.join(
        parser_tree_res_tec.xpath(
            '//div[@id="techinalContent"]/div/div[@class = '
            '"summaryTableLine"][1]/span[2]//text()')) + '  [' + ''.join(
        parser_tree_res_tec.xpath(
            '//div[@id="techinalContent"]/div/div[@class = '
            '"summaryTableLine"][1]/span[3]//text()')) + ' ' + ''.join(
        parser_tree_res_tec.xpath(
            '//div[@id="techinalContent"]/div/div[@class = "summaryTableLine"][1]/span[4]//text()')) + ']'
    indicators2 = ''.join(parser_tree_res_tec.xpath(
        '//div[@id="techinalContent"]/div/div[@class = '
        '"summaryTableLine"][2]/span[1]//text()')) + '\n  ' + ''.join(
        parser_tree_res_tec.xpath(
            '//div[@id="techinalContent"]/div/div[@class = '
            '"summaryTableLine"][2]/span[2]//text()')) + '  [' + ''.join(
        parser_tree_res_tec.xpath(
            '//div[@id="techinalContent"]/div/div[@class = '
            '"summaryTableLine"][2]/span[3]//text()')) + ' ' + ''.join(
        parser_tree_res_tec.xpath(
            '//div[@id="techinalContent"]/div/div[@class = '
            '"summaryTableLine"][2]/span[4]//text()')) + ']'
    indicators = f'Индикаторы на {technical_text}:\n{indicators1}\n{indicators2}'
    if indicators1 != '\n    [ ]':
        return indicators
    else:
        return ''
