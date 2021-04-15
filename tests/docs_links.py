import os, re, requests

def findDocsLinks(_text):
  pattern = r'(https://www.microfocus.com/documentation+([\w\d:#@%/;$~_?\+-=\.&](#!)?)*)'
  return list(map(lambda x: x[0], re.findall(pattern, _text)))

count = 0
passed = 0

for dir_path, dir_names, file_names in os.walk(".."):
  for file_name in file_names:
    if not file_name.endswith(".md"): continue
    file_path = os.path.join(dir_path, file_name)
    
    print('-'*20)
    print(file_path)
    print('-'*20)

    with open(file_path, 'r') as md_file:
      for link in findDocsLinks(md_file.read()):
        x = requests.get(link)
        print(link)
        print(x.status_code)

        count += 1
        if x.status_code == 200:
          passed += 1

print('='*20)
print(f'Test complete. {passed} passed out of {count}.')
print('='*20)
