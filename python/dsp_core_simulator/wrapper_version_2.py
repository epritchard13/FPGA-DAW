SAMP_BIT_WIDT = 16
COEF_BIT_WIDT = 16
SAMP_BUF_SIZE = 8
COEF_BUF_SIZE = 8
ACCU_REG_QUAN = 8


def dsp(samp,coef,accu):
    return accu + (samp*coef)

def inst():
    samp_buffer = [[None] * SAMP_BIT_WIDT] * SAMP_BUF_SIZE
    coef_buffer = [[None] * COEF_BIT_WIDT] * COEF_BUF_SIZE
    accu_regist = [[None] * ACCU_REG_QUAN] * ACCU_REG_QUAN
    return samp_buffer,coef_buffer,accu_regist

print(inst())

