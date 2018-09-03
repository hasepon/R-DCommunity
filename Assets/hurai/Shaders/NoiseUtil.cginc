inline float random(fixed2 p)
{
	return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
}