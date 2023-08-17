## Why do we want a DFT?
Let's say that we have a discrete time signal of a finite length, and we want to do some processing that involves the frequency domain.

To do this, we can break down our signal with $N$ samples into a sum of $N$ complex exponentials using the DFT, do some processing in the frequency domain, and then turn those $N$ complex exponentials back into a time-domain signal using the inverse DFT. 

This means that the DFT must contain all of the time-domain signal's information so that we can turn it back into a time domain signal with an IDFT.

A complex exponential has the form $Ae^{j\omega t + \theta}$, where $\omega$ is the angular frequency, $\theta$ is the phase, and $A$ is the amplitude. Why do we use complex exponentials instead of sines and cosines?
* This allows use to do a DFT on complex data. Don't worry though - if we do a DFT on real samples and then try to use those complex exponentials to recreate the samples, all imaginary parts of the complex exponentials will cancel out, leaving us with real data.
* Because we have both $\omega$, $\theta$, and $A$, we know the amplitude, frequency, and phase. All of these are necessary for turning the DFT back into a time-domain signal.

The DFT finds us phasors that can be represented in the form $A e^{\theta}$, giving us magnitude and phase. How do we know what the frequency is? The angular frequency $\omega$ is a function of the index of the DFT (which spans $[0, N)$ and is the same length as the time-domain signal). $\omega$ spans the range $[0, 2\pi)$. If we know the sample rate of the signal, we can also convert $\omega$ into a Hz frequency value.

One more thing, the DFT outputs complex values in the form $a + jb$. These can be converted to $A e^{\theta}$ form if we want to look at magnitude and phase.

## Example
Let's try a DFT of length 4. Our samples are all real valued with the values [ 0, 1, 1, 0 ].

The DFT of those samples is [2,  -1-j,  0, -1+j]. What does this mean?

These coefficients represent the properites of the complex exponentials that we can use to reconstruct our original 4 samples. We can convert these coefficients from $a+bj$ form to $A e^\theta$ form to get:

[ $2 e^{j0}$, $\sqrt 2 e^{j\frac{-3\pi}{4}}$,  0, $\sqrt 2 e^{j\frac{3\pi}{4}}$]

Cool. Now we know that two of our frequencies have an amplitude of $\sqrt 2$, one frequency has an amplitude of 0, and one frequency has a phase of $0$ radians.

By the way, the complex exponentials have angular frequency $\omega$ values of [ $0$, $\pi/2$, $\pi$, $3\pi/2$] and can be obtained from the DFT formula. 

So to reconstruct the original signal, we just use this function given by our DFT coefficients:
$$\frac{2 e^{j(0t + 0)} + \sqrt 2 e^{j(\frac{\pi}{2}t - \frac{3\pi}{4})} +  0 + \sqrt 2 e^{j(\frac{3\pi}{2} t + \frac{3\pi}{4})}}{4}$$

### **We now have a representation of our original function as a sum of complex exponentials of different frequency!!**

We have to divide by the length of the signal $N=4$ at the end, by the way (it's in the IDFT formula). 

If we feel like it, we can do some frequency domain DSP and modify the complex exponentials in any way we want to. And, when we evaluate this function from [0, 4), we should get the original samples [0, 1, 1, 0] back.

## Summary

The DFT breaks down a time-domain signal of fixed length into frequencies. It stores the amplitude and phase of each frequency as well. The amount of terms is equal to the length of the original signal. Performing an inverse DFT always gives back the original signal.

