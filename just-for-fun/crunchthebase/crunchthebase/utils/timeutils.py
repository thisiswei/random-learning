from datetime import datetime

DATE_FORMAT = '%Y-%m-%d'

def to_datetime(date_str):
    return datetime.strptime(date_str, DATE_FORMAT)
