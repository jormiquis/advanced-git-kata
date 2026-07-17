from calculator import divide

def test_divide_by_zero_raises_error():
    try:
        divide(10, 0)
        assert False, "should have raised ValueError"
    except ValueError:
        assert True

def test_divide_normal():
    assert divide(10, 2) == 5
