import logging
import random
import time
import functools

class retry(object):
    """
    Converts with_retry into a decorator.

    @see with_retry for args
    """
    def __init__(self, *args, **kwargs):
        self._args = args
        self._kwargs = kwargs

    def __call__(self, fn):
        @functools.wraps(fn)
        def wrapped_f(*args, **kwargs):
            self._kwargs['retry_stats'] = kwargs.get('retry_stats')
            self._kwargs['retry_log_prefix'] = kwargs.get('retry_log_prefix')
            return with_retry(lambda: fn(*args, **kwargs),
                    *self._args,
                    **self._kwargs)
        return wrapped_f

def with_retry(func, num_retries=1, validator=None,
               exceptions=[],
               sleep_interval=None,
               retry_stats={},
               retry_log_prefix=None,
               default=None,
        ):
    """
    Execute the function with given number of retries, until the response
    satisfies the condition the validator is checking for.

    @param func: lambda:
    @param num_retries: int, the number of additionl times the func call
    will be attempted. No retries are attempted if this number is 0.
    @param validator: lambda x: bool
    @param exceptions: list(Exception), if specified, only catch exceptions
    of given types.
    @param sleep_interval: int|None, in seconds
    @param retry_stats: dict, modified, to keep track of the retry stats
    @param retry_log_prefix: str|None, prefix
    @param default: Object|None, value to return if we run out of retries
    @return: object
    """
    validator = validator or (lambda x: True)
    trial = 0
    retry_stats = retry_stats or {}
    while trial <= num_retries:
        trial += 1
        try:
            val = func()
            if validator(val):
                return val
            raise ValueError('validation failed')
        except Exception, exception:
            exception_name = exception.__class__.__name__
            if exception_name not in retry_stats:
                retry_stats[exception_name] = 0
            retry_stats[exception_name] += 1

            if exceptions:
                if not any(map(lambda klass: isinstance(exception, klass), exceptions)):
                    raise

            # If ran out of retries, raise exception
            if trial > num_retries:
                if default != None:
                    return default
                raise
            if sleep_interval:
                interval = random.uniform(0.5, 1.5) * sleep_interval * (trial)
                msg = "sleeping %s seconds before retry (%s/%s)" % (interval, trial, num_retries)
                if retry_log_prefix:
                    msg = "%s %s" % (retry_log_prefix, msg)
                logging.info(msg)
                if 'sleep_interval' not in retry_stats:
                    retry_stats['sleep_interval'] = 0
                retry_stats['sleep_interval'] += interval
                time.sleep(interval)
            pass
    return None
