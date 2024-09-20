import secrets, string


def generate_master_key(length=10):
    characters = string.ascii_uppercase + string.ascii_lowercase + string.digits + string.punctuation
    master_key = ''.join(secrets.choice(characters) for i in range(length))
    return master_key