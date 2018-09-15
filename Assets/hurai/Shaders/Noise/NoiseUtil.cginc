inline float random(fixed2 p)
{
	return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
}

fixed2 random2(fixed2 st)
{
	st = fixed2(
		dot(st, fixed2(127.1, 311.7)),
		dot(st, fixed2(269.5, 183.3)));
	return -1.0 + 2.0 * frac(sin(st) * 43758.5453123);
}

inline float noise(fixed2 n)
{
	fixed2 p = floor(n);
	return random(p);
}

inline float PerlinNoise(fixed2 st)
{
	fixed2 p = floor(st);
	fixed2 f = frac(st);
	fixed2 u = f * f * (3.0 - 2.0 * f);

	float v00 = random2(p + fixed2(0, 0));
	float v10 = random2(p + fixed2(1, 0));
	float v01 = random2(p + fixed2(0, 1));
	float v11 = random2(p + fixed2(1, 1));

	return lerp(lerp(dot(v00, f - fixed2(0,0)), dot(v10, f - fixed2(1, 0)), u.x),
				lerp(dot(v01, f - fixed2(0,1)), dot(v11, f - fixed2(1, 1)), u.x),
				u.y) + 0.5f;
}

inline float fBm(fixed2 st)
{
	float f = 0;
	fixed2 q = st;

	f += 0.5000 * PerlinNoise(q);
	q = q * 2.01;
	f += 0.2500 * PerlinNoise(q);
	q = q * 2.02;
	f += 0.1250 * PerlinNoise(q);
	q = q * 2.03;
	f += 0.0625 * PerlinNoise(q);
	q = q * 2.01;

	return f;
}