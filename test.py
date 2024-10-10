for i in range(12):
    if i % 2 == 0:
        continue
    elif i == 5:
        break
    print(i)
else:
    print("Стоп!")