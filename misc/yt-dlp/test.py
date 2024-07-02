from __future__ import annotations

import time

CONTROL_SEQUENCES = {
    'UP': '\033[A',
    'ERASE_LINE': '\033[K',
    'RESET': '\033[0m',
}


def loop_updater(iterations=11, delay=0.1):
    def decorator(content_provider):
        def wrapper(*args, **kwargs):
            num_iterations = kwargs.pop('num_iterations', iterations)

            for iteration in range(num_iterations):
                content = content_provider(iteration, *args, **kwargs)
                print(f'{CONTROL_SEQUENCES['UP']}{CONTROL_SEQUENCES['ERASE_LINE']}{content}')
                time.sleep(delay)

            print(CONTROL_SEQUENCES['RESET'])  # Reset to the default state after the loop

        return wrapper

    return decorator


if __name__ == '__main__':
    @loop_updater()
    def loading_percentage_content(iteration):
        return f'Loading: {iteration}%'

    # Default number of iterations
    loading_percentage_content()
    # Custom number of iterations
    loading_percentage_content(num_iterations=6)
