class_name Actor
extends Node2D


@export var frameSpeed: float = 0.15

@onready var sprite: Sprite2D = $Sprite2D

var frameCounter: float
var isFrozen: bool

func move(vector: Vector2) -> void:
	position += vector


func animate(direction: Vector2, delta: float) -> void:
	# reset animations when still
	if (direction == Vector2.ZERO):
		sprite.frame_coords.x = 0
		frameCounter = 0
		return
	else:
		frameCounter += delta
		if (frameCounter >= frameSpeed):
			frameCounter -= frameSpeed
			sprite.frame_coords.x = (1 + sprite.frame_coords.x) % sprite.hframes
		
		# set animation layer
		if (direction.y > 0.0):
			sprite.frame_coords.y = 0
		elif (direction.y < 0.0):
			sprite.frame_coords.y = 3
		elif (direction.x > 0.0):
			sprite.frame_coords.y = 2
		elif (direction.x < 0.0):
			sprite.frame_coords.y = 1


	#Actor(Texture2D text, int startCell, float spd = SPEED)
	#{
		#isMoving = false;
		#currentCell = startCell;
		#speed = spd;
#
		#texture = text;
		#offset = {24.f, 80.f};
#
		#position = PositionOfCell(startCell);
		#frameRec = {0.0f, 0.0f, (float)texture.width / FRAMES, (float)texture.height / LAYERS};
		#currentFrame = 0;
		#currentLayer = 1;
		#framesCounter = 0;
		#framesSpeed = FRAME_SPEED;
	#}
	#void update();
	#void setCell(int cell);
	#void setTexture(Texture2D text);
	#void move(Command *command);
	#bool canMove();
	#void draw();
	#void draw2D();
#
#private:

#
	#void animate();
#};
#
#void Actor::update()
#{
	#// stand still when motionless
	#Actor::animate();
#
	#// reset for next frame
	#isMoving = false;
#}
#
#void Actor::setCell(int cell)
#{
	#currentCell = cell;
	#position = PositionOfCell(cell);
#}
#
#void Actor::setTexture(Texture2D text)
#{
	#texture = text;
#}
#
#void Actor::move(Command *command)
#{
	#// we are now in motion
	#isMoving = true;
#
	#// update position
	#Vector2 direction = (Vector2){0.f, 0.f};
	#switch (*command)
	#{
	#case Command::N:
		#direction += (Vector2){0.f, -1.f};
		#currentLayer = 3;
		#break;
	#case Command::NE:
		#direction += (Vector2){DIAGONAL, -DIAGONAL};
		#currentLayer = 3;
		#break;
	#case Command::E:
		#direction += (Vector2){1.f, 0.f};
		#currentLayer = 2;
		#break;
	#case Command::SE:
		#direction += (Vector2){DIAGONAL, DIAGONAL};
		#currentLayer = 0;
		#break;
	#case Command::S:
		#direction += (Vector2){0.f, 1.f};
		#currentLayer = 0;
		#break;
	#case Command::SW:
		#direction += (Vector2){-DIAGONAL, DIAGONAL};
		#currentLayer = 0;
		#break;
	#case Command::W:
		#direction += (Vector2){-1.f, 0.f};
		#currentLayer = 1;
		#break;
	#case Command::NW:
		#direction += (Vector2){-DIAGONAL, -DIAGONAL};
		#currentLayer = 3;
		#break;
	#default:
		#return;
	#}
#
	#position += Vector2Scale(direction, speed * GetFrameTime());
	#// printf(TextFormat("\tpos x: %f\tpos y: %f\tcurrent cell: %i", position.x, position.y, currentCell));
#
	#// update current cell
	#Vector2 center = {(position.x + HALF_CELL), (position.y + HALF_CELL)};
	#currentCell = (int)floor(center.x / CELL_SIZE) + (int)floor(center.y / CELL_SIZE) * MAP_WIDTH;
#}
#
#void Actor::draw()
#{
	#DrawText(TextFormat("pos x: %f\tpos y: %f\tcurrent cell: %i", position.x, position.y, currentCell), 20, 20, 40, WHITE);
#
	#DrawRectangleLines(position.x, position.y, CELL_SIZE, CELL_SIZE, LIME);
#}
#
#void Actor::draw2D()
#{
	#DrawTextureRec(texture, frameRec, position - offset, WHITE);
#}
#
#void Actor::animate()
#{
	#// only animate when in motion
	#if (isMoving)
	#{
		#// move with the flow
		#framesCounter++;
		#if (framesCounter >= (FRAME_RATE / framesSpeed))
		#{
			#currentFrame++;
			#framesCounter = 0;
			#if (currentFrame >= FRAMES)
			#{
				#currentFrame = 0;
			#}
		#}
	#}
	#else
	#{
		#currentFrame = 0;
	#}
#
	#// anways update animation rect
	#frameRec.x = (float)currentFrame * (float)texture.width / FRAMES;
	#frameRec.y = (float)currentLayer * (float)texture.height / LAYERS;
#}
#
#bool Actor::canMove()
#{
	#return !isFrozen;
#}
#
##endif
