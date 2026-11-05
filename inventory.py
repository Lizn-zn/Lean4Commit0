#!/usr/bin/env python3
"""Recreate the lexical task inventory; not a Lean parser or solution scorer."""
from pathlib import Path
import hashlib,json,re

from lean_lex import scrub as strip_lean_comments_and_strings

root=Path(__file__).resolve().parent
rows=[]
for lib in sorted((root/'libs').iterdir()):
 if not lib.is_dir() or lib.name=='Shared':continue
 files=[]
 for p in sorted(lib.rglob('*.lean')):
  if '.misc' in p.parts:continue
  text=p.read_text()
  code=strip_lean_comments_and_strings(text)
  declarations=list(re.finditer(r'(?m)^\s*(?:(?:private|protected|noncomputable|unsafe|partial)\s+)*(def|theorem|lemma|instance|abbrev|example)\b',code))
  categories={'implementation':0,'theorem':0}
  for match in re.finditer(r'\bsorry\b',code):
   preceding=[d for d in declarations if d.start()<match.start()]
   kind=preceding[-1].group(1) if preceding else 'unknown'
   categories['theorem' if kind in {'theorem','lemma','example'} else 'implementation']+=1
  files.append({'path':str(p.relative_to(root)), 'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),
    'sorry_tokens':sum(categories.values()), 'lexical_declaration_categories':categories})
 rows.append({'library':lib.name,'sorry_tokens':sum(x['sorry_tokens'] for x in files),'files':files})
result={'counting_method':'Lexical sorry tokens in active task .lean files; comments, strings and .misc excluded. Not a Lean parser or scoring result.',
        'library_count':len(rows),'total_sorry_tokens':sum(x['sorry_tokens'] for x in rows),
        'lexical_declaration_categories':{k:sum(f['lexical_declaration_categories'][k] for row in rows for f in row['files']) for k in ['implementation','theorem']},'libraries':rows}
(root/'TASK_INVENTORY.json').write_text(json.dumps(result,indent=2)+'\n')
print(result['library_count'],'libraries;',result['total_sorry_tokens'],'active task sorry tokens')
