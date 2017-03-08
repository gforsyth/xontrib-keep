from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import Condition, EmacsInsertMode, ViInsertMode, HasFocus
from prompt_toolkit.enums import SEARCH_BUFFER
from prompt_toolkit import prompt
from keep import utils

__all__ = ()

@events.on_ptk_create
def custom_keybindings(bindings, **kw):
    handler = bindings.registry.add_binding
    arrow = ' <-- Command to add to keep'

    has_focus = HasFocus(SEARCH_BUFFER)

    @Condition
    def xonsh_has_history(cli):
        return len(__xonsh_history__) > 0

    @Condition
    def text(cli):
        return cli.current_buffer.text

    @handler(Keys.ControlK, filter=xonsh_has_history & ~text)
    def keep_save_last(event):
        event.cli.renderer.erase()
        _cmd = __xonsh_history__[-1].cmd.strip()
        desc = prompt('Add previous command to Keep\n'
                      'Add command: {}\nDescription: '.format(_cmd),
                      get_prompt_tokens=None)
        utils.save_command(_cmd, desc)
        event.cli.abort()

    @handler(Keys.ControlK, filter=text)
    def keep_save_current(event):
        _cmd = event.current_buffer.document.text
        event.cli.renderer.erase()
        desc = prompt('Add previous command to Keep\n'
                      'Add command: {}\nDescription: '.format(_cmd),
                      get_prompt_tokens=None)
        utils.save_command(_cmd, desc)
        event.cli.abort()