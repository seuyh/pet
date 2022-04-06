from scrapy.loader import ItemLoader
from itemloaders.processors import TakeFirst, MapCompose, Compose
from urllib.parse import urljoin
from json import loads as json_loads
from base64 import b64decode
from io import BytesIO
from PIL import Image

import pytesseract

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'


# def edit_price(itm):
#     price = itm + " ₽"
#     return price


def delete_space(itm):
    address = itm.replace("\n", "")
    address = address[1:-1]
    return address


def full_url(itm):
    seller_link = itm
    return seller_link


def get_phone(string):
    try:
        phone_string = json_loads(string)["image64"].split(sep=',')[1]
        image = Image.open(BytesIO(b64decode(phone_string)))
        phone = pytesseract.image_to_string(image).replace("\n", "")
        return phone
    except IndexError:
        pass


class AvitoLoader(ItemLoader):
    default_item_class = dict
    url_out = TakeFirst()
    title_out = TakeFirst()
    # price_in = MapCompose(edit_price)
    # price_out = TakeFirst()
    address_in = MapCompose(delete_space)
    address_out = TakeFirst()
    # apartment_parameters_out = Compose()
    seller_link_in = MapCompose(full_url)
    seller_link_out = TakeFirst()
    seller_name_in = MapCompose(delete_space)
    seller_name_out = TakeFirst()
    phone_in = MapCompose(get_phone)
    phone_out = TakeFirst()
