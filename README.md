
## Objective
Analyze and visualize the magnitude, phase, and pole-zero response of different FIR filter types using MATLAB.

## Impulse Responses Used
- **Type I:** h1 = [1 2 3 4 4 3 2 1]  (Symmetric, even length)
- **Type II:** h2 = [1 2 3 4 3 2 1] (Symmetric, odd length)
- **Type III:** h3 = [-1 -2 -3 -4 3 3 2 1] (Antisymmetric, even length)
- **Type IV:** h4 = [-1 -2 -3 0 3 2 1] (Antisymmetric, odd length)

## Plots Generated
- Magnitude Response
- Phase Response (Unwrapped)
- Zero-Pole Plot

## Observations
- Type I and II filters show linear phase due to symmetry.
- Type III and IV filters show antisymmetric impulse response, resulting in phase shifts.
- Zero locations reflect the symmetry property of each filter.