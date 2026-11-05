"""Offset-preserving screening of Lean comments and literal text (not an AST)."""
import re

_CHAR = re.compile(r"'(?:\\(?:u\{[0-9a-fA-F]+\}|x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|.)|[^\\'\n])'")
_RAW = re.compile(r'r(#+)"')


def lexical_spans(text):
    """Return non-code token spans; quoted identifiers remain code for screening."""
    spans=[]
    _scrub(text,spans)
    return spans


def scrub(text):
    return _scrub(text,[])


def _scrub(text,spans):
    out=list(text);i=0
    def blank(a,b):
        for j in range(a,b):
            if out[j]!='\n':out[j]=' '
    while i<len(text):
        start=i
        if text[i:i+2]=='--':
            end=text.find('\n',i);i=len(text) if end<0 else end
        elif text[i:i+2]=='/-':
            depth=1;i+=2
            while i<len(text) and depth:
                if text[i:i+2]=='/-':depth+=1;i+=2
                elif text[i:i+2]=='-/':depth-=1;i+=2
                else:i+=1
        elif (m:=_RAW.match(text,i)) and (i==0 or not text[i-1].isalnum()):
            end=text.find('"'+m.group(1),m.end());i=len(text) if end<0 else end+1+len(m.group(1))
        elif text[i]=='"':
            i+=1
            while i<len(text):
                if text[i]=='\\':i+=2
                elif text[i]=='"':i+=1;break
                else:i+=1
            i=min(i,len(text))
        elif text[i]=='«':
            end=text.find('»',i+1);i=len(text) if end<0 else end+1
            spans.append((start,i))
            out[start]=' '
            if end>=0:out[end]=' '
            continue
        elif text[i]=="'" and (i==0 or not (text[i-1].isalnum() or text[i-1] in "_'?!")) and (m:=_CHAR.match(text,i)):
            i=m.end()
        else:i+=1;continue
        spans.append((start,i));blank(start,i)
    return ''.join(out)
