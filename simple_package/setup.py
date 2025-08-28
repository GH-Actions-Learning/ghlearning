from setuptools import setup, find_packages

setup(
    name="sample_pkg",                                       # The name used when installing: pip install sample_pkg
    version="0.0.1",                                         # Initial version
    author="Rich",
    author_email="rich@rich.com",
    description="A very basic Python package example",
    packages=find_packages(),                                # Automatically finds 'sample_pkg'
    classifiers=[
        "Programming Language :: Python :: 3",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.0",                                # Minimum Python version
)
