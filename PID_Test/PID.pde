class PID {

    private float lastError;
    private float integral;

    private float pGain;
    private float iGain;
    private float dGain;
    private float deltaTime; // Time step for the PID calculations
    private float maxIntegral; // Maximum value for the integral term to prevent windup

    public PID(float pGain, float iGain, float dGain, float frameRate, float maxIntegral) {
        setPGain(pGain);
        setIGain(iGain);
        setDGain(dGain);
        setMaxIntegral(maxIntegral);
        setDeltaTime(frameRate);
        reset();
    }

    private void setDeltaTime(float frameRate) {
        if (frameRate <= 0) {
            throw new IllegalArgumentException("Frame rate must be positive.");
        }
        this.deltaTime = 1.0f / frameRate;
    }

    private float pTerm(float error) {
        return error * pGain;
    }

    private float iTerm(float error) {
        integral += error * deltaTime;
        integral = clamp(integral, -maxIntegral, maxIntegral);
        return integral * iGain;
    }

    private float dTerm(float error) {
        float derivative = (error - lastError) / deltaTime;
        lastError = error;
        return derivative * dGain;
    }

    public float getMove(float target, float actual) {
        float error = target - actual;

        float output = 0;
        output += pTerm(error);
        output += iTerm(error);
        output += dTerm(error);

        return output;
    }

    public void reset() {
        lastError = 0;
        integral = 0;
    }

    private float clamp(float value, float min, float max) {
        return Math.max(min, Math.min(max, value));
    }

    // Setters for gains and max integral
    public void setPGain(float pGain) {
        this.pGain = pGain;
    }

    public void setIGain(float iGain) {
        this.iGain = iGain;
    }

    public void setDGain(float dGain) {
        this.dGain = dGain;
    }

    public void setMaxIntegral(float maxIntegral) {
        this.maxIntegral = maxIntegral;
    }
}
