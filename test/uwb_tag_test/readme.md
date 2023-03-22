# *uwb_tag_test* folder

Contains the data collected to test the rTDoA running on board the UWB tag.

Each folder is a different collected dataset, and contains:

- A data folder where the data records are grouped (if more then one), more details in the readme file inside the folder
- A python script to parse the data
- One or more matlab files to elaborate the data, compute info about the algorithm performances, and test KF for positioning

In the file [comparison](/test/uwb_tag_test/comparison.m) the dataset results and algorithms are compared
