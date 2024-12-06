import logging
from logging.config import dictConfig

CATEGORY_SIZE = 48
LOG_RECORD_BUILTIN_ATTRS = [
    "args",
    "asctime",
    "created",
    "exc_info",
    "exc_text",
    "filename",
    "funcName",
    "levelname",
    "levelno",
    "lineno",
    "module",
    "msecs",
    "message",
    "msg",
    "name",
    "pathname",
    "process",
    "processName",
    "relativeCreated",
    "stack_info",
    "thread",
    "threadName",
    "taskName",
]


class DeepyFormatter(logging.Formatter):
    def format(self, record):
        extra_data = {
            key: value if key != "category" else f"{value:<{CATEGORY_SIZE}}"
            for key, value in record.__dict__.items()
            if key not in LOG_RECORD_BUILTIN_ATTRS
        }
        extra_string = "".join([f" | {value}" for value in extra_data.values()]) if extra_data else ""
        record.extra = extra_string
        return super().format(record)


class LoggerConfig:
    @staticmethod
    def setup_logging():
        logging_config = {
            "version": 1,
            "disable_existing_loggers": True,
            "formatters": {
                "deepy": {
                    "()": DeepyFormatter,
                    "format": "%(asctime)s | %(levelname)-8s %(extra)s | %(funcName)s [L%(lineno)03d] | %(message)s",
                },
            },
            "handlers": {
                "console": {
                    "level": "INFO",
                    "class": "logging.StreamHandler",
                    "formatter": "deepy",
                }
            },
            "loggers": {
                "": {
                    "handlers": ["console"],
                    "level": "INFO",
                    "propagate": True,
                },
                "py4j": {
                    "handlers": ["console"],
                    "level": "WARNING",
                    "propagate": False,
                },
            },
        }

        dictConfig(logging_config)


# Configure global logger
LoggerConfig.setup_logging()
log = logging.getLogger()


def example_function():
    # Logging with extra parameters directly
    log.info("This is a test messagess", extra={"user_id": 12345, "extra": "extra field"})
    var = "John Doe"
    log.info("Another test message", extra={"names": var})
    log.info("Another test message", extra={"category": var})
    log.info("An error message without extra fields")
    log.error("An error message without extra fields")


if __name__ == "__main__":
    log.info("This is a test messagess", extra={"user_id": 12345, "extra": "extra field"})
    example_function()
