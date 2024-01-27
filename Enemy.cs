using Godot;
using System;
using System.Numerics;

public partial class Enemy : CharacterBody3D
{


	[Export]
	NodePath playerPath;
	CharacterBody3D player;
	NavigationAgent3D navAgent;
	const float speed = 2.6969696969f;

	public override void _Ready() 
	{
		player = GetNode<CharacterBody3D>(playerPath);
		navAgent = GetNode<NavigationAgent3D>("NavigationAgent3D");
	}

	public override void _PhysicsProcess(double delta)
	{
		Velocity = Godot.Vector3.Zero;
		navAgent.TargetPosition = player.GlobalTransform.Origin;
		Godot.Vector3 nextNavPoint  = navAgent.GetNextPathPosition();
		Velocity = (nextNavPoint - GlobalTransform.Origin).Normalized() * speed;
		Godot.Vector3 lookatTarget = new Godot.Vector3(player.GlobalPosition.X,GlobalPosition.Y,player.GlobalPosition.Z);
		LookAt(lookatTarget);
		MoveAndSlide();
	}
}
