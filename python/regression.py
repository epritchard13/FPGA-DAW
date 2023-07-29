import serial, unittest, random
from tqdm import tqdm

class SanityTest(unittest.TestCase):
    def setUp(self):
        self.ser = serial.Serial('COM5', 9600)
        self.ser.write(b'h')
        while self.ser.in_waiting > 0:
            self.ser.read()
    
    def tearDown(self):
        while self.ser.in_waiting > 0:
            self.ser.read()
        self.ser.close()
    
    # make sure that the pico is responding to serial
    def test_pico_serial(self):
        for i in range(0, 50):
            self.ser.write(b'/json\n')
            res = self.ser.readline()
            assert len(res) > 0 and res.startswith(b'{')
    
    # test an SD register
    def test_sd_reg(self):
        for i in range(0, 100):
            num = random.randint(0, 255)
            # encode num as hex str
            num = hex(num)[2:].encode()
            self.ser.write(b'/sdwrite 4 ' + num + b'\n')
            self.ser.write(b'/sd 4\n')
            res = self.ser.readline()
            test = res.strip() == num
            if test == False:
                print('Expected:', num, ', Got:', res)
            assert test

    # test reading a file
    def test_fat_init(self):
        for i in range(20):
            self.ser.write(b'/init\n')
            while True:
                line = self.ser.readline().strip()
                if line.startswith(b'fat_example_main returned'):
                    assert line.endswith(b'0')
                    break
    
    # test writing to a file
    def test_fat_write(self):
        for i in range(2):
            self.ser.write(b'/test_write\n')
            while True:
                line = self.ser.readline().strip()
                if line.startswith(b'fat_test_write returned'):
                    assert line.endswith(b'0')
                    break

if __name__ == '__main__':
    unittest.main()
