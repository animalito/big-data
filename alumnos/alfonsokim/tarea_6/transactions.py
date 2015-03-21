
def transactions(n):
    import random
    from datetime import datetime, timedelta
    import uuid

    for i in range(n):
        now = datetime.now()
        ri = random.randint
        delta = timedelta(days=ri(1, 10), hours=ri(1, 60), minutes=ri(1, 60), seconds=ri(1, 60))
        print now + delta


transactions(10)
