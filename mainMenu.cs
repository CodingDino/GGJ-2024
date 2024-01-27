using Godot;
using System;

public partial class mainMenu : Control
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}

private void _StartGame()
{
	get_tree().change_scene("res://room.tscn");
}

private void _ApplicationQuit()
{
	get_tree().quit(); 
}
