from ranger.api.commands import Command
import os.path

class open_quicklook(Command):
    """:open_quicklook <filename>

    open the file in MacOS finder-quicklook
    """

    def execute(self):
        current = self.fm.thisfile.path
        if os.path.isdir(current):
            self.fm.execute_console("move right=1")
        else:
            self.fm.execute_console("shell qlmanage -p %s >& /dev/null")

