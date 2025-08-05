import sys
import unittest
from framework import AssemblyTest, print_coverage, _venus_default_args
from tools.check_hashes import check_hashes

"""
Coverage tests for project 2 is meant to make sure you understand
how to test RISC-V code based on function descriptions.
Before you attempt to write these tests, it might be helpful to read
unittests.py and framework.py.
Like project 1, you can see your coverage score by submitting to gradescope.
The coverage will be determined by how many lines of code your tests run,
so remember to test for the exceptions!
"""

"""
abs_loss
# =======================================================
# FUNCTION: Get the absolute difference of 2 int arrays,
#   store in the result array and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result array

# Returns:
#   a0 (int)  is the sum of the absolute loss
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# =======================================================
"""


class TestAbsLoss(unittest.TestCase):
    def test_abs_loss_standard(self):
        t = AssemblyTest(self, "../coverage-src/abs_loss.s")

        arr0 = t.array([1, 2, 3, 4, 5, 6, 7, 1, 13])
        t.input_array("a0", arr0)
        arr1 = t.array([-5, 4, 3, 7, 10, 6, -4, 8, 9])
        t.input_array("a1", arr1)
        t.input_scalar("a2", len(arr0))
        arr2 = t.array([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        t.input_array("a3", arr2)
        t.call("abs_loss")
        t.check_array(arr2, [6,2,0,3,5,0,11,7,4])
        t.check_scalar("a0", 38)
        t.execute()

    def test_abs_loss_length_1(self):
        t = AssemblyTest(self, "../coverage-src/abs_loss.s")
    
        arr0 = t.array([1])
        t.input_array("a0", arr0)
        arr1 = t.array([-5])
        t.input_array("a1", arr1)
        t.input_scalar("a2", len(arr0))
        arr2 = t.array([-1])
        t.input_array("a3", arr2)
        t.call("abs_loss")
        t.check_array(arr2, [6])
        t.check_scalar("a0", 6)
        t.execute()
    
    def test_abs_loss_length_error(self):
        t = AssemblyTest(self, "../coverage-src/abs_loss.s")

    
        arr0 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a0", arr0)
        arr1 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a1", arr1)
        t.input_scalar("a2", 0)
        arr2 = t.array([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        t.input_array("a3", arr2)
        t.call("abs_loss")
        t.execute(code=36)

    @classmethod
    def tearDownClass(cls):
        print_coverage("abs_loss.s", verbose=False)


"""
squared_loss
# =======================================================
# FUNCTION: Get the squared difference of 2 int arrays,
#   store in the result array and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result array

# Returns:
#   a0 (int)  is the sum of the squared loss
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# =======================================================
"""


class TestSquaredLoss(unittest.TestCase):
    def test_squared_loss_standard(self):
        t = AssemblyTest(self, "../coverage-src/squared_loss.s")

        arr0 = t.array([1, 2, 3, 4, 5, 6, 7, 1, 13])
        t.input_array("a0", arr0)
        arr1 = t.array([-5, 4, 3, 7, 10, 6, -4, 8, 9])
        t.input_array("a1", arr1)
        t.input_scalar("a2", len(arr0))
        arr2 = t.array([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        t.input_array("a3", arr2)
        t.call("squared_loss")
        t.check_array(arr2, [36,4,0,9,25,0,121,49,16])
        t.check_scalar("a0", 260)
        t.execute()

    def test_squared_loss_length_1(self):
        t = AssemblyTest(self, "../coverage-src/squared_loss.s")
    
        arr0 = t.array([1])
        t.input_array("a0", arr0)
        arr1 = t.array([-5])
        t.input_array("a1", arr1)
        t.input_scalar("a2", len(arr0))
        arr2 = t.array([-1])
        t.input_array("a3", arr2)
        t.call("squared_loss")
        t.check_array(arr2, [36])
        t.check_scalar("a0", 36)
        t.execute()
    
    def test_squared_loss_length_error(self):
        t = AssemblyTest(self, "../coverage-src/squared_loss.s")

    
        arr0 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a0", arr0)
        arr1 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a1", arr1)
        t.input_scalar("a2", 0)
        arr2 = t.array([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        t.input_array("a3", arr2)
        t.call("squared_loss")
        t.execute(code=36)

    @classmethod
    def tearDownClass(cls):
        print_coverage("squared_loss.s", verbose=False)


"""
zero_one_loss
# =======================================================
# FUNCTION: Generates a 0-1 classifer array inplace in the result array,
#  where result[i] = (arr0[i] == arr1[i])
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result array

# Returns:
#   NONE
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# =======================================================
"""


class TestZeroOneLoss(unittest.TestCase):
    def test_zero_one_loss_standard(self):
        t = AssemblyTest(self, "../coverage-src/zero_one_loss.s")

        arr0 = t.array([1, 2, 3, 4, 5, 6, 7, 1, 13])
        t.input_array("a0", arr0)
        arr1 = t.array([-5, 4, 3, 7, 10, 6, -4, 8, 9])
        t.input_array("a1", arr1)
        t.input_scalar("a2", len(arr0))
        arr2 = t.array([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        t.input_array("a3", arr2)
        t.call("zero_one_loss")
        t.check_array(arr2, [0,0,1,0,0,1,0,0,0])
        t.execute()

    def test_zero_one_loss_length_1(self):
        t = AssemblyTest(self, "../coverage-src/zero_one_loss.s")
    
        arr0 = t.array([1])
        t.input_array("a0", arr0)
        arr1 = t.array([-5])
        t.input_array("a1", arr1)
        t.input_scalar("a2", len(arr0))
        arr2 = t.array([-1])
        t.input_array("a3", arr2)
        t.call("zero_one_loss")
        t.check_array(arr2, [0])
        t.execute()
    
    def test_squared_loss_length_error(self):
        t = AssemblyTest(self, "../coverage-src/zero_one_loss.s")

    
        arr0 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a0", arr0)
        arr1 = t.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
        t.input_array("a1", arr1)
        t.input_scalar("a2", 0)
        arr2 = t.array([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        t.input_array("a3", arr2)
        t.call("zero_one_loss")
        t.execute(code=36)

    @classmethod
    def tearDownClass(cls):
        print_coverage("zero_one_loss.s", verbose=False)


"""
initialize_zero
# =======================================================
# FUNCTION: Initialize a zero array with the given length
# Arguments:
#   a0 (int) size of the array

# Returns:
#   a0 (int*)  is the pointer to the zero array
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# - If malloc fails, this function terminates the program with exit code 26.
# =======================================================
"""


class TestInitializeZero(unittest.TestCase):
    def test_initialize_zero_length_error1(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")

        t.input_scalar("a0",0)
        t.call("initialize_zero")
        t.execute(code=36)

    def test_initialize_zero_malloc_fail_error2(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")

        t.input_scalar("a0",1024*1024*1024)
        t.call("initialize_zero")
        t.execute(code=26)

    def test_initialize_zero_stardard(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")

        t.input_scalar("a0",5)
        t.call("initialize_zero")
        t.check_array_pointer("a0",[0,0,0,0,0])
        t.execute()

    def test_initialize_zero_length_1(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")

        t.input_scalar("a0",1)
        t.call("initialize_zero")
        t.check_array_pointer("a0",[0])
        t.execute()

    @classmethod
    def tearDownClass(cls):
        print_coverage("initialize_zero.s", verbose=False)


if __name__ == "__main__":
    split_idx = sys.argv.index("--")
    for arg in sys.argv[split_idx + 1 :]:
        _venus_default_args.append(arg)

    check_hashes()

    unittest.main(argv=sys.argv[:split_idx])
