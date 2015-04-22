Medical Computer Vision Project
===============================

CAP 6515 - Jacob Panikulam

Implementation of [Model-Based Segmentation of Medical Imagery by Matching Distributions](http://www.ecse.rpiscrews.us/~rjradke/papers/radketmi04.pdf)

# Gameplan
1. Implement sub-image histogram grabbing
2. Implement histogram comparison, Bregman Divergences
	- [Mahalanobis Distance](http://www.mathworks.com/help/stats/mahal.html)
	- [Generalized KL](http://www.mathworks.com/matlabcentral/fileexchange/20688-kullback-leibler-divergence)
	- [Itakura-Saito](http://musicweb.ucsd.edu/~sdubnov/CATbox/InfoRate%20v2.0/distispf.m)
	- CDF Distance -- [cdf](http://www.mathworks.com/help/stats/ecdf.html)
	These should return a scalar, pick the best set of matches (Spool up an EC2 to bounce tests)
3. Start with a guess, start expanding outwards with blocks from #2
	- If time permits, do blocks of shrinking size
	- If time double-permits, implement fast-marching
	- With JUST CDF distance, it is much more practical to directly solve the optimization problem
4. Geometric expansion / minimization of divergence [a method](http://www.mathworks.com/matlabcentral/fileexchange/19567-active-contour-segmentation/content//regionbased_seg/region_seg.m)

Effectively: Gradient descent on divergence

# TODO

- Implement Divergences
- Implement 