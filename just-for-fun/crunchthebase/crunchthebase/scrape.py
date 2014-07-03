import requests
import logging
from pprint import pprint
from utils.decorator import retry
from utils.dicttools import get_dotted
from settings import APIKEY
from utils.timeutils import to_datetime
from models import Company

BASE_URL = "http://api.crunchbase.com/v/2/{item}?order=updated_at%20desc&user_key=" + APIKEY

LIMIT = 1
MAX = 100
SLEEP = 60


def create_company(act=False):
    companies = _get_companies()
    if not act:
        pprint(companies)
    else:
        for company in companies:
            Company(external_id=company.get('external_id'),
                    name=company.get('name'),
                    desc=company.get('desc'),
                    city=company.get('city'),
                    total_founding=company.get('total_founding'),
                    founded_on=company.get('founded_on'),
                    homepage_url=company.get('homepage_url'),
                    is_closed=company.get('is_closed'),
                    ).put()

def _get_companies(limit=10):
    companies = []
    links = _get_companies_links()
    for link in links:
        company = _get_company(link)
        companies.append(company)
        if limit and len(companies) > limit:
            break
    return companies

@retry(num_retries=3, sleep_interval=SLEEP)
def _get_companies_links(limit=1):
    to_return = []
    url = BASE_URL.format(item="organizations")
    for i in range(1, MAX):
        cur_url = url + "&page=%d" % i
        json_ = _get_json(cur_url)
        names_and_links = _get_company_name_and_path(json_)
        permlinks = [permlink for _, permlink in names_and_links]
        if limit and len(to_return) > limit:
            break
        to_return.extend(permlinks)
    return to_return

def _create_company_dict(name=None, city=None, total_founding=None,
                    founded_on=None,
                    category=None,
                    homepage_url=None,
                    external_id=None,
                    desc=None,
                    is_closed=None,
                    founders=None,
                    ):
    return dict(name=name,
                city=city,
                total_founding=total_founding,
                category=category,
                homepage_url=homepage_url,
                external_id=external_id,
                desc=desc,
                founded_on=founded_on,
                is_closed=is_closed,
                founders=founders)

def _get_company(permlink):
    item = 'organization/%s' % permlink
    url = BASE_URL.format(item=item)
    json_ = _get_json(url)

    data = json_.get('data')
    properties = data.get('properties')

    external_id = data.get('uuid')
    name =  properties.get('name')
    desc = properties.get('short_description')
    founded_on = to_datetime(properties.get('founded_on'))
    total_founding = properties.get('total_funding_usd')
    homepage_url = properties.get('homepage_url')
    is_closed = properties.get('is_closed')

    relationships = data.get('relationships')
    #addr_items = get_dotted(relationships, 'headquarters.items[0]') #address
    city = get_dotted(relationships, 'headquarters.items[0].city')
    category = get_dotted(relationships, 'categories.items[0].name')
    founder_items = get_dotted(relationships, 'founders.items')
    founders = [f.get('name') for f in founder_items] if founder_items else None

    dict_ = _create_company_dict(name=name, city=city, total_founding=total_founding,
                    founded_on=founded_on,
                    category=category,
                    homepage_url=homepage_url,
                    external_id=external_id,
                    desc=desc,
                    is_closed=is_closed,
                    founders=founders,
                    )
    return dict_

def _get_json(url):
    resp = requests.get(url)
    if resp.status_code != 200:
        raise ValueError("404")
    return resp.json

def _get_company_name_and_path(json_):
    def _get_permlink(path):
        return path.split('/')[1]

    items = get_dotted(json_, 'data.items')
    names_and_paths = [(item.get('name'), _get_permlink(item.get('path'))) for item in items]
    return names_and_paths



def main():
    """
    debug
    """
    define("act",
            type=bool,
            default=False,
            )
    parse_command_line()

    if not options.act:
        logging.info('dry-run only, run with --act=True')

    create_company(act=options.act)


if __name__ == "__main__":
    from utils.cmdline import define
    from utils.cmdline import options
    from utils.cmdline import parse_command_line
    exit(main())
    exit(main())
