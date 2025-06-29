from setuptools import setup, find_packages

with open("requirements.txt") as f:
    requirements= f.read().splitlines()
setup(
    name="MLOPS-UTEC-GIT-2025",
    version="1.0",
    author="Raul Martinez",
    packages=find_packages(),
    install_requires=requirements


)