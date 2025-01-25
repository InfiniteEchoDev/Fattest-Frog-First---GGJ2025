// Feather disable all
/// @desc    Returns whether mouse wheel up is newly activated this frame.

function input_mouse_wheel_up()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__mouse_allowed 
    ||  !_global.__game_input_allowed 
    ||   _global.__cleared)
    {
        return false;
    }
    
    return mouse_wheel_up();
}
