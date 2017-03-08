from setuptools import setup

setup(
    name='xontrib-xontrib-keep',
    version='0.1.0',
    url='https://github.com/gforsyth/xontrib-keep',
    license='MIT',
    author='Gil Forsyth',
    author_email='gilforsyth@gmail.com',
    description='A short description of the project',
    packages=['xontrib'],
    package_dir={'xontrib': 'xontrib'},
    package_data={'xontrib': ['*.xsh']},
    platforms='any',
)
