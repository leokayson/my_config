text = []
for i in range(26):
    text += [(chr)(ord('a') + i)]
print('", "'.join(text))

for i in range(26):
    text += [(chr)(ord('A') + i)]
print('", "'.join(text))