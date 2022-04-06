import logging
import requests
from lxml import html
from time import sleep
from transliterate import translit
from transliterate.utils import LanguageDetectionError
from aiogram import Bot, Dispatcher, executor, types
from funct import technical_search

bot = Bot(token="///")
dp = Dispatcher(bot)
logging.basicConfig(level=logging.INFO)


@dp.message_handler(commands="start")
async def cmd_start(message: types.Message):
    await message.answer("/search <<Ваш запрос>>")


global_value1 = 0
global_value2 = 5
mesagge_data = ''
pages_bot = 1
pagee = 1
technical_default_def = 86400
technical_cout_def = 0
name = ''
price = ''
search_res_url = ''
headers = ''
tag = ''


def get_key():
    buttons = [
        types.InlineKeyboardButton(text="Прогнозы на меньший срок", callback_data='res_minus'),
        types.InlineKeyboardButton(text="Прогнозы на больший срок", callback_data='res_plus'),
        types.InlineKeyboardButton(text="Получить график", callback_data='get_graph')

    ]
    keyboard = types.InlineKeyboardMarkup(row_width=2)
    keyboard.add(*buttons)
    return keyboard


def get_key_low():
    buttons = [
        types.InlineKeyboardButton(text="Прогнозы на больший срок", callback_data='res_plus'),
        types.InlineKeyboardButton(text="Получить график", callback_data='get_graph')
    ]
    keyboard = types.InlineKeyboardMarkup(row_width=1)
    keyboard.add(*buttons)
    return keyboard


def get_key_high():
    buttons = [
        types.InlineKeyboardButton(text="Прогнозы на меньший срок", callback_data='res_minus'),
        types.InlineKeyboardButton(text="Получить график", callback_data='get_graph')
    ]
    keyboard = types.InlineKeyboardMarkup(row_width=1)
    keyboard.add(*buttons)
    return keyboard


@dp.message_handler(commands="search")
async def main(message: types.Message):
    global headers
    headers = {'user-agent': 'OPR/73.0.3856.438 (Edition Yx GX)'}
    global pagee
    global tag
    tag = ''
    pagee = 1
    global global_value2
    global global_value1
    global_value1 = 0
    global_value2 = 5
    global mesagge_data
    mesagge_data = message.text[8:]
    if mesagge_data != '':
        global pages_bot
        pages_bot = 1
        await bot.send_message(message.from_user.id, f'Ищем {mesagge_data}...')
        search = mesagge_data
        try:
            search = translit(search, reversed=True)
        except LanguageDetectionError:
            pass
        url = f'https://ru.investing.com/search/?q={search}'
        response_search = requests.get(url, headers=headers)
        sleep(1)
        parser_tree = html.fromstring(response_search.content)
        a_find = ''.join(parser_tree.xpath('//a[@class="js-inner-all-results-quote-item row"][1]/@href'))
        if a_find == '':
            await bot.send_message(message.from_user.id, 'Ничего не нашлось :(')
        else:
            global search_res_url
            global name
            global price
            search_res_url = f'https://ru.investing.com{a_find}'
            response_search_res = requests.get(search_res_url, headers=headers)
            parser_tree_res = html.fromstring(response_search_res.content)
            name = ''.join(
                parser_tree_res.xpath('//*[@id="__next"]/div[2]/div/div/div[2]/main/div/div[1]/div[1]/h1//text()'))
            if name != '':
                sleep(1)
                duration = ''.join(
                    parser_tree_res.xpath(
                        '//*[@id="__next"]'
                        '/div[2]/div/div/div[2]/main/div/div[1]/div[2]/div[1]/div[2]//text()'))
                sleep(1)
                price = ''.join(parser_tree_res.xpath(
                    '//*[@id="__next"]'
                    '/div[2]/div/div/div[2]/main/div/div[1]/div[2]/div[1]/span//text()')) + '$  ' + duration
            else:
                name = ''.join(parser_tree_res.xpath('//*[@id="leftColumn"]/div[1]/h1//text()'))
                duration = ''.join(parser_tree_res.xpath(
                    '//*[@id="quotes_summary_current_data"]/div[1]/div[2]/div[1]/span[2]//text()')) + '(' + ''.join(
                    parser_tree_res.xpath(
                        '//*[@id="quotes_summary_current_data"]/div[1]/div[2]/div[1]/span[4]//text()')) + ')'
                sleep(1)
                price = ''.join(parser_tree_res.xpath('//*[@id="last_last"]//text()')) + '$  ' + duration

            sleep(1)

            try:
                tag = name.split("(")[1][:-1]
            except IndexError:
                pass
            if technical_search(technical_cout_def, search_res_url) != '':
                await bot.send_message(message.from_user.id,
                                       f'{name}\n{price}\n{technical_search(technical_cout_def, search_res_url)}',
                                       reply_markup=get_key())
            else:
                await bot.send_message(message.from_user.id,
                                       f'{name}\n{price}'
                                       f'\nОшибка получения индикаторов и графика'
                                       f'\nВозможная причина: Криптовалюта, индикаторы '
                                       f'недоступны график доступен с использованием команды /graph')
    else:
        await bot.send_message(message.from_user.id, 'Вы забили написать запрос :/')


@dp.message_handler(commands="graph")
async def main(message: types.Message):
    mesagge_data = message.text[7:]
    if mesagge_data != '':
        await bot.send_message(message.from_user.id, f'Ищем график {mesagge_data}...')
        url_graph = f'https://stockcharts.com/h-sc/ui?s={mesagge_data}'
        response_search_graph = requests.get(url_graph, headers=headers)
        parser_tree_graph = html.fromstring(response_search_graph.content)
        graph = ''.join(parser_tree_graph.xpath(
            '//img[@class="chartimg"]/@src'))
        if graph != '':
            await bot.send_message(message.from_user.id, f'{graph[2:]}')
        else:
            await bot.send_message(message.from_user.id,
                                   f'Невозможно получить график\nОшибка неизвстный тэг "{mesagge_data}"')
    else:
        await bot.send_message(message.from_user.id, 'Вы забили написать запрос :/')


@dp.message_handler(commands="debug")
async def main(message: types.Message):
    await bot.send_message(message.from_user.id, f'{mesagge_data}\n{name}\n{price}\n{search_res_url}\n{headers}')


@dp.callback_query_handler(text="res_plus")
async def send_plus_value(call: types.CallbackQuery):
    global technical_cout_def
    global search_res_url
    global headers
    technical_cout_def += 1

    if technical_cout_def == 2:
        await call.message.edit_text(f'{name}\n{price}\n{technical_search(technical_cout_def, search_res_url)}',
                                     reply_markup=get_key_high())
    else:
        await call.message.edit_text(f'{name}\n{price}\n{technical_search(technical_cout_def, search_res_url)}',
                                     reply_markup=get_key())


@dp.callback_query_handler(text="res_minus")
async def send_plus_value(call: types.CallbackQuery):
    global technical_cout_def
    global search_res_url
    global headers
    technical_cout_def -= 1

    if technical_cout_def == -6:
        await call.message.edit_text(f'{name}\n{price}\n{technical_search(technical_cout_def, search_res_url)}',
                                     reply_markup=get_key_low())
    else:
        await call.message.edit_text(f'{name}\n{price}\n{technical_search(technical_cout_def, search_res_url)}',
                                     reply_markup=get_key())


@dp.callback_query_handler(text="get_graph")
async def send_value(call: types.CallbackQuery):
    if tag != '':
        url_graph = f'https://stockcharts.com/h-sc/ui?s={tag}'
        response_search_graph = requests.get(url_graph, headers=headers)
        parser_tree_graph = html.fromstring(response_search_graph.content)
        graph = ''.join(parser_tree_graph.xpath(
            '//img[@class="chartimg"]/@src'))
        await call.message.answer(f'{graph[2:]}')
    else:
        await call.message.answer(
            f'Невозможно получить график\nОшибка неизвстный тэг "{tag}'
            f'"\nЕсли вам известен тэг можете поискать вручную: /graph <<tag>>')


if __name__ == "__main__":
    executor.start_polling(dp, skip_updates=True)
