class empty(Command):
    """:empty

    Empties the trash directory
    """

    def execute(self):
        self.fm.run("rm -rf /home/carlosado/.local/share/Trash/files/{*,.[^.]*}")
