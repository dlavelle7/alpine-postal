from postal.parser import parse_address


def test_postal():
    result = parse_address(
        'The Book Club 100-106 Leonard St, Shoreditch, '
        'London, Greater London, EC2A 4RH, United Kingdom')
    expected = [
        ('the book club', 'house'),
        ('100-106', 'house_number'),
        ('leonard st', 'road'),
        ('shoreditch', 'suburb'),
        ('london', 'city'),
        ('greater london', 'state_district'),
        ('ec2a 4rh', 'postcode'), ('united kingdom', 'country')
    ]
    assert result == expected, "Postal did not parse test address correctly"
