#!/usr/bin/env python
from quickapp import QuickAppBase
from compmake.exceptions import UserError
import os, string
from system_cmd import system_cmd_result

template = """
\\documentclass{DOCUMENTCLASS} 
\\usepackage{fontspec}
\\setmonofont{FONTFAMILY}
\\usepackage{minted}
\\usemintedstyle{STYLE}
\\begin{document} 
\\thispagestyle{empty}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\begin{minipage}{WIDTH}
\\begin{minted}[linenos=true,bgcolor=bg,fontsize=\\FONTSIZE,fontfamily=tt]{python} 
CODE
\\end{minted} 
\\end{minipage}
\\end{document}

"""
class Py2pdf(QuickAppBase):
    """ Converts a Python snipped into a PDF file using minted. """
    cmd = 'py2pdf'
    def define_program_options(self, params):
        params.add_string('input', short='-i')
        params.add_string('output', short='o', default=None)
        params.add_string('fontsize',  default='footnotesize')
        params.add_string('style',  default='trac')
        params.add_string('fontfamily',  default='Consolas')
        params.add_string('width',  default='8.6cm')
        params.add_string('documentclass',  default='IEEEtran')

    def go(self):
        options = self.get_options()

        filename = options.input

        if options.output is None:
            pdf = os.path.splitext(filename)[0] + '.pdf' 
        else:
            pdf = options.output

        if not os.path.exists(filename):
            msg = 'File does not exist: %s' % filename
            raise UserError(msg)
        with open(filename) as f:
            code = f.read()
        code = string.strip(code)
        s = template
        s = s.replace('CODE', code)
        s = s.replace('STYLE', options.style)
        s = s.replace('WIDTH', options.width)
        s = s.replace('FONTSIZE', options.fontsize)
        s = s.replace('DOCUMENTCLASS', options.documentclass)
        s = s.replace('FONTFAMILY', options.fontfamily)

        b = os.path.splitext(filename)[0] 
        tex = b + '_tmp.tex'
        pdf1 = b + '_tmp.pdf'
        with open(tex, 'w') as f:
            f.write(s)

        cwd = os.path.dirname(tex)
        if cwd == '': 
            cwd = os.getcwd()

        basename = os.path.basename(tex)
        latex = 'xelatex'
        cmd = [latex, '-shell-escape', basename]
        system_cmd_result(cwd=cwd, cmd=cmd, 
            display_stdout=True,
            display_stderr=True,
            raise_on_error=True)

        
        cmd = ['pdfcrop', os.path.basename(pdf1), 
            os.path.basename(pdf)]

        system_cmd_result(cwd=cwd, cmd=cmd, 
            display_stdout=True,
            display_stderr=True,
            raise_on_error=True)

        remove = [pdf1, tex, b+'_tmp.aux', b+'_tmp.log']
        for r in remove:
            if os.path.exists(r):
                os.unlink(r)


if __name__ == '__main__':
    main = Py2pdf.get_sys_main()
    main()