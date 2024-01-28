using Godot;
using System;
using System.Numerics;

public partial class Enemy : CharacterBody3D
{
	[Export]
	NodePath playerPath;
	Godot.CharacterBody3D player;
	NavigationAgent3D navAgent;
	const float speed = 2.420f;
	Godot.Vector3 velocity;
	float followRange = 5f;
	float attackRange = 1f;
	AnimationPlayer animPlayer;
	AnimationTree animTree; 

	public override void _Ready() 
	{
		player = GetNode<Godot.CharacterBody3D>(playerPath); //../Player
		navAgent = GetNode<NavigationAgent3D>("NavigationAgent3D");
		animPlayer = GetNode<AnimationPlayer>("Chucklenug/AnimationPlayer");
		animTree = GetNode<AnimationTree>("Chucklenug/AnimationTree");
	}

	public override void _PhysicsProcess(double delta)
	{
		Velocity = Godot.Vector3.Zero;
		navAgent.TargetPosition = player.GlobalTransform.Origin;
		navAgent.TargetDesiredDistance = 1.0f;
		Godot.Vector3 lookatTarget = new Godot.Vector3(player.GlobalPosition.X,GlobalPosition.Y,player.GlobalPosition.Z);
		//if(!animPlayer.IsPlaying() && animPlayer.CurrentAnimation != "idle"){
			//animPlayer.Play("idle");
		//}
		animTree.Set("parameters/conditions/idle", !playerInRangeToFollow()); 
		animTree.Set("parameters/conditions/atk", playerInRangeToAttack()); 
		animTree.Set("parameters/conditions/run", playerInRangeToFollow()); 
		if(playerInRangeToFollow())
		{
			//Play walking animation
			//if(!animPlayer.IsPlaying() && animPlayer.CurrentAnimation != "run"){
			//animPlayer.Play("run");
			//}
			
			Godot.Vector3 nextNavPoint  = navAgent.GetNextPathPosition();
			velocity = (nextNavPoint - GlobalTransform.Origin).Normalized() * speed;
			if(playerInRangeToAttack())
			{
				//if(!animPlayer.IsPlaying() && animPlayer.CurrentAnimation != "laughAttack"){
			//animPlayer.Play("laughAttack");
		//}
		
				//animPlayer.Play("laughAttack");
				//Attack Goes here!
				//Play Attack Animation
				//play big laugh audio
				//Send Damage to Player
			}
				
			
		}
		else
		{
			//Play idle animation
			//Set audio streamer to 'idle' laugh
			velocity = Godot.Vector3.Zero;
		}

		
		
		

		
		
		LookAt(lookatTarget);
		Velocity = velocity;
		MoveAndSlide();
	}

	public bool playerInRangeToFollow()
	{
		return GlobalPosition.DistanceTo(player.GlobalPosition) < followRange;
	}
	public bool playerInRangeToAttack()
	{
		return GlobalPosition.DistanceTo(player.GlobalPosition) < attackRange;
	}

	

	
}
