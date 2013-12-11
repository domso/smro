#inclib "openb3d"

''
''
'' functions -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __functions_bi__
#define __functions_bi__

declare function BackBufferToTex cdecl alias "BackBufferToTex" (byval tex as any ptr, byval frame as integer=0) as integer
declare function BufferToTex cdecl alias "BufferToTex" (byval tex as any ptr, byval buffer as any ptr, byval frame as integer) as integer
declare function MeshCullRadius cdecl alias "MeshCullRadius" (byval ent as any ptr, byval radius as single) as integer
declare function AddAnimSeq cdecl alias "AddAnimSeq" (byval ent as any ptr, byval length as integer) as integer
declare function AddMesh cdecl alias "AddMesh" (byval mesh1 as any ptr, byval mesh2 as any ptr) as any ptr
declare function AddTriangle cdecl alias "AddTriangle" (byval surf as any ptr, byval v0 as integer, byval v1 as integer, byval v2 as integer) as integer
declare function AddVertex cdecl alias "AddVertex" (byval surf as any ptr, byval x as single, byval y as single, byval z as single, byval u as single=0, byval v as single=0, byval w as single=0) as integer
declare function AmbientLight cdecl alias "AmbientLight" (byval r as single, byval g as single, byval b as single) as integer
declare function AntiAlias cdecl alias "AntiAlias" (byval samples as integer) as integer
declare function Animate cdecl alias "Animate" (byval ent as any ptr, byval mode as integer=1, byval speed as single=1, byval seq as integer=0, byval trans as integer=0) as integer
declare function Animating cdecl alias "Animating" (byval ent as any ptr) as integer
declare function AnimLength cdecl alias "AnimLength" (byval ent as any ptr) as integer
declare function AnimSeq cdecl alias "AnimSeq" (byval ent as any ptr) as integer
declare function AnimTime cdecl alias "AnimTime" (byval ent as any ptr) as single
declare function BrushAlpha cdecl alias "BrushAlpha" (byval brush as any ptr, byval a as single) as integer
declare function BrushBlend cdecl alias "BrushBlend" (byval brush as any ptr, byval blend as integer) as integer
declare function BrushColor cdecl alias "BrushColor" (byval brush as any ptr, byval r as single, byval g as single, byval b as single) as integer
declare function BrushFX cdecl alias "BrushFX" (byval brush as any ptr, byval fx as integer) as integer
declare function BrushShininess cdecl alias "BrushShininess" (byval brush as any ptr, byval s as single) as integer
declare function BrushTexture cdecl alias "BrushTexture" (byval brush as any ptr, byval tex as any ptr, byval frame as integer=0, byval index as integer=0) as integer
declare function CameraClsColor cdecl alias "CameraClsColor" (byval cam as any ptr, byval r as single, byval g as single, byval b as single) as integer
declare function CameraClsMode cdecl alias "CameraClsMode" (byval cam as any ptr, byval cls_depth as integer, byval cls_zbuffer as integer) as integer
declare function CameraFogColor cdecl alias "CameraFogColor" (byval cam as any ptr, byval r as single, byval g as single, byval b as single) as integer
declare function CameraFogMode cdecl alias "CameraFogMode" (byval cam as any ptr, byval mode as integer) as integer
declare function CameraFogRange cdecl alias "CameraFogRange" (byval cam as any ptr, byval nnear as single, byval nfar as single) as integer
declare function CameraPick cdecl alias "CameraPick" (byval cam as any ptr, byval x as single, byval y as single) as any ptr
declare function CameraProject cdecl alias "CameraProject" (byval cam as any ptr, byval x as single, byval y as single, byval z as single) as integer
declare function CameraProjMode cdecl alias "CameraProjMode" (byval cam as any ptr, byval mode as integer) as integer
declare function CameraRange cdecl alias "CameraRange" (byval cam as any ptr, byval nnear as single, byval nfar as single) as integer
declare function CameraViewport cdecl alias "CameraViewport" (byval cam as any ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as integer
declare function CameraZoom cdecl alias "CameraZoom" (byval cam as any ptr, byval zoom as single) as integer
declare function ClearSurface cdecl alias "ClearSurface" (byval surf as any ptr, byval clear_verts as integer=1, byval clear_tris as integer=1) as integer
declare function ClearTextureFilters cdecl alias "ClearTextureFilters" () as integer
declare function ClearWorld cdecl alias "ClearWorld" (byval entities as integer=1, byval brushes as integer=1, byval textures as integer=1) as integer
declare function CollisionEntity cdecl alias "CollisionEntity" (byval ent as any ptr, byval index as integer) as any ptr
declare function Collisions cdecl alias "Collisions" (byval src_no as integer, byval dest_no as integer, byval method_no as integer, byval response_no as integer=0) as integer
declare function CollisionNX cdecl alias "CollisionNX" (byval ent as any ptr, byval index as integer) as single
declare function CollisionNY cdecl alias "CollisionNY" (byval ent as any ptr, byval index as integer) as single
declare function CollisionNZ cdecl alias "CollisionNZ" (byval ent as any ptr, byval index as integer) as single
declare function CollisionSurface cdecl alias "CollisionSurface" (byval ent as any ptr, byval index as integer) as any ptr
declare function CollisionTime cdecl alias "CollisionTime" (byval ent as any ptr, byval index as integer) as single
declare function CollisionTriangle cdecl alias "CollisionTriangle" (byval ent as any ptr, byval index as integer) as integer
declare function CollisionX cdecl alias "CollisionX" (byval ent as any ptr, byval index as integer) as single
declare function CollisionY cdecl alias "CollisionY" (byval ent as any ptr, byval index as integer) as single
declare function CollisionZ cdecl alias "CollisionZ" (byval ent as any ptr, byval index as integer) as single
declare function CountChildren cdecl alias "CountChildren" (byval ent as any ptr) as integer
declare function CountCollisions cdecl alias "CountCollisions" (byval ent as any ptr) as integer
declare function CopyEntity cdecl alias "CopyEntity" (byval ent as any ptr, byval parent as any ptr=0) as any ptr
declare function CopyMesh cdecl alias "CopyMesh" (byval mesh as any ptr, byval parent as any ptr=0) as any ptr
declare function CountSurfaces cdecl alias "CountSurfaces" (byval mesh as any ptr) as integer
declare function CountTriangles cdecl alias "CountTriangles" (byval surf as any ptr) as integer
declare function CountVertices cdecl alias "CountVertices" (byval surf as any ptr) as integer
declare function CreateBrush cdecl alias "CreateBrush" (byval r as single=255, byval g as single=255, byval b as single=255) as any ptr
declare function CreateCamera cdecl alias "CreateCamera" (byval parent as any ptr=0) as any ptr
declare function CreateCone cdecl alias "CreateCone" (byval segments as integer=8, byval solid as integer=1, byval parent as any ptr=0) as any ptr
declare function CreateCylinder cdecl alias "CreateCylinder" (byval segments as integer=8, byval solid as integer=1, byval parent as any ptr=0) as any ptr
declare function CreateCube cdecl alias "CreateCube" (byval parent as any ptr=0) as any ptr
declare function CreateMesh cdecl alias "CreateMesh" (byval parent as any ptr=0) as any ptr
declare function CreateLight cdecl alias "CreateLight" (byval light_type as integer=1, byval parent as any ptr=0) as any ptr
declare function CreatePivot cdecl alias "CreatePivot" (byval parent as any ptr=0) as any ptr
declare function CreatePlane cdecl alias "CreatePlane" (byval Divisions as integer=1, byval parent as any ptr=0) as any ptr
declare function CreateSphere cdecl alias "CreateSphere" (byval segments as integer=8, byval parent as any ptr=0) as any ptr
declare function CreateSprite cdecl alias "CreateSprite" (byval parent as any ptr=0) as any ptr
declare function CreateSurface cdecl alias "CreateSurface" (byval mesh as any ptr, byval brush as any ptr=0) as any ptr
declare function CreateTerrain cdecl alias "CreateTerrain" (byval size as integer, byval parent as any ptr=0) as any ptr
declare function CreateTexture cdecl alias "CreateTexture" (byval width as integer, byval height as integer, byval flags as integer=1, byval frames as integer=1) as any ptr
declare function DeltaPitch cdecl alias "DeltaPitch" (byval ent1 as any ptr, byval ent2 as any ptr) as single
declare function DeltaYaw cdecl alias "DeltaYaw" (byval ent1 as any ptr, byval ent2 as any ptr) as single
declare function EntityAlpha cdecl alias "EntityAlpha" (byval ent as any ptr, byval alpha as single) as integer
declare function EntityAutoFade cdecl alias "EntityAutoFade" (byval ent as any ptr, byval near as single, byval far as single) as integer
declare function EntityBlend cdecl alias "EntityBlend" (byval ent as any ptr, byval blend as integer) as integer
declare function EntityBox cdecl alias "EntityBox" (byval ent as any ptr, byval x as single, byval y as single, byval z as single, byval w as single, byval h as single, byval d as single) as integer
declare function EntityClass cdecl alias "EntityClass" (byval ent as any ptr) as string
declare function EntityCollided cdecl alias "EntityCollided" (byval ent as any ptr, byval type_no as integer) as any ptr
declare function EntityColor cdecl alias "EntityColor" (byval ent as any ptr, byval red as single, byval green as single, byval blue as single) as integer
declare function EntityDistance cdecl alias "EntityDistance" (byval ent1 as any ptr, byval ent2 as any ptr) as single
declare function EntityFX cdecl alias "EntityFX" (byval ent as any ptr, byval fx as integer) as integer
declare function EntityInView cdecl alias "EntityInView" (byval ent as any ptr, byval cam as any ptr) as integer
declare function EntityName cdecl alias "EntityName" (byval ent as any ptr) as string
declare function EntityOrder cdecl alias "EntityOrder" (byval ent as any ptr, byval order as integer) as integer
declare function EntityParent cdecl alias "EntityParent" (byval ent as any ptr, byval parent_ent as any ptr, byval glob as integer=1) as integer
declare function EntityPick cdecl alias "EntityPick" (byval ent as any ptr, byval range as single) as any ptr
declare function EntityPickMode cdecl alias "EntityPickMode" (byval ent as any ptr, byval pick_mode as integer, byval obscurer as integer=1) as integer
declare function EntityPitch cdecl alias "EntityPitch" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityRadius cdecl alias "EntityRadius" (byval ent as any ptr, byval radius_x as single, byval radius_y as single=0) as integer
declare function EntityRoll cdecl alias "EntityRoll" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityShininess cdecl alias "EntityShininess" (byval ent as any ptr, byval shine as single) as integer
declare function EntityTexture cdecl alias "EntityTexture" (byval ent as any ptr, byval tex as any ptr, byval frame as integer=0, byval index as integer=0) as integer
declare function EntityType cdecl alias "EntityType" (byval ent as any ptr, byval type_no as integer, byval recursive as integer=0) as integer
declare function EntityVisible cdecl alias "EntityVisible" (byval src_ent as any ptr, byval dest_ent as any ptr) as integer
declare function EntityX cdecl alias "EntityX" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityY cdecl alias "EntityY" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityYaw cdecl alias "EntityYaw" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityZ cdecl alias "EntityZ" (byval ent as any ptr, byval glob as integer=0) as single
declare function ExtractAnimSeq cdecl alias "ExtractAnimSeq" (byval ent as any ptr, byval first_frame as integer, byval last_frame as integer, byval seq as integer=0) as integer
declare function FindChild cdecl alias "FindChild" (byval ent as any ptr, byval child_name as zstring ptr) as any ptr
declare function FindSurface cdecl alias "FindSurface" (byval mesh as any ptr, byval brush as any ptr) as any ptr
declare function FitMesh cdecl alias "FitMesh" (byval mesh as any ptr, byval x as single, byval y as single, byval z as single, byval width as single, byval height as single, byval depth as single, byval uniform as integer=0) as any ptr
declare function FlipMesh cdecl alias "FlipMesh" (byval mesh as any ptr) as any ptr
declare function FreeBrush cdecl alias "FreeBrush" (byval brush as any ptr) as integer
declare function FreeEntity cdecl alias "FreeEntity" (byval ent as any ptr) as integer
declare function FreeTexture cdecl alias "FreeTexture" (byval tex as any ptr) as integer
declare function GetBrushTexture cdecl alias "GetBrushTexture" (byval brush as any ptr, byval index as integer=0) as any ptr
declare function GetChild cdecl alias "GetChild" (byval ent as any ptr, byval child_no as integer) as any ptr
declare function GetEntityBrush cdecl alias "GetEntityBrush" (byval ent as any ptr) as any ptr
declare function GetEntityType cdecl alias "GetEntityType" (byval ent as any ptr) as integer
declare function GetMatElement cdecl alias "GetMatElement" (byval ent as any ptr, byval row as integer, byval col as integer) as single
declare function GetParentEntity cdecl alias "GetParentEntity" (byval ent as any ptr) as any ptr
declare function GetSurface cdecl alias "GetSurface" (byval mesh as any ptr, byval surf_no as integer) as any ptr
declare function GetSurfaceBrush cdecl alias "GetSurfaceBrush" (byval surf as any ptr) as any ptr
declare function Graphics3D cdecl alias "Graphics3D" (byval width as integer, byval height as integer, byval depth as integer=0, byval mode as integer=0, byval rate as integer=60) as integer
declare function HandleSprite cdecl alias "HandleSprite" (byval sprite as any ptr, byval h_x as single, byval h_y as single) as integer
declare function HideEntity cdecl alias "HideEntity" (byval ent as any ptr) as integer
declare function LightColor cdecl alias "LightColor" (byval light as any ptr, byval red as single, byval green as single, byval blue as single) as integer
declare function LightConeAngles cdecl alias "LightConeAngles" (byval light as any ptr, byval inner_ang as single, byval outer_ang as single) as integer
declare function LightRange cdecl alias "LightRange" (byval light as any ptr, byval range as single) as integer
declare function LinePick cdecl alias "LinePick" (byval x as single, byval y as single, byval z as single, byval dx as single, byval dy as single, byval dz as single, byval radius as single=0) as any ptr
declare function LoadAnimMesh cdecl alias "LoadAnimMesh" (byval file as zstring ptr, byval parent as any ptr=0) as any ptr
declare function LoadAnimTexture cdecl alias "LoadAnimTexture" (byval file as zstring ptr, byval flags as integer, byval frame_width as integer, byval frame_height as integer, byval first_frame as integer, byval frame_count as integer) as any ptr
declare function LoadBrush cdecl alias "LoadBrush" (byval file as zstring ptr, byval flags as integer=1, byval u_scale as single=1, byval v_scale as single=1) as any ptr
declare function LoadMesh cdecl alias "LoadMesh" (byval file as zstring ptr, byval parent as any ptr=0) as any ptr
declare function LoadTerrain cdecl alias "LoadTerrain" (byval file as zstring ptr, byval parent as any ptr=0) as any ptr
declare function LoadTexture cdecl alias "LoadTexture" (byval file as zstring ptr, byval flags as integer=1) as any ptr
declare function LoadSprite cdecl alias "LoadSprite" (byval tex_file as zstring ptr, byval tex_flag as integer=1, byval parent as any ptr=0) as any ptr
declare function MeshDepth cdecl alias "MeshDepth" (byval mesh as any ptr) as single
declare function MeshesIntersect cdecl alias "MeshesIntersect" (byval mesh1 as any ptr, byval mesh2 as any ptr) as any ptr
declare function MeshHeight cdecl alias "MeshHeight" (byval mesh as any ptr) as single
declare function MeshWidth cdecl alias "MeshWidth" (byval mesh as any ptr) as single
declare function ModifyTerrain cdecl alias "ModifyTerrain" (byval terr as any ptr, byval x as integer, byval z as integer, byval height as single) as any ptr
declare function MoveEntity cdecl alias "MoveEntity" (byval ent as any ptr, byval x as single, byval y as single, byval z as single) as integer
declare function NameEntity cdecl alias "NameEntity" (byval ent as any ptr, byval name as zstring ptr) as integer
declare function PaintEntity cdecl alias "PaintEntity" (byval ent as any ptr, byval brush as any ptr) as integer
declare function PaintMesh cdecl alias "PaintMesh" (byval mesh as any ptr, byval brush as any ptr) as any ptr
declare function PaintSurface cdecl alias "PaintSurface" (byval surf as any ptr, byval brush as any ptr) as integer
declare function PickedEntity cdecl alias "PickedEntity" () as any ptr
declare function PickedNX cdecl alias "PickedNX" () as single
declare function PickedNY cdecl alias "PickedNY" () as single
declare function PickedNZ cdecl alias "PickedNZ" () as single
declare function PickedSurface cdecl alias "PickedSurface" () as any ptr
declare function PickedTime cdecl alias "PickedTime" () as single
declare function PickedTriangle cdecl alias "PickedTriangle" () as integer
declare function PickedX cdecl alias "PickedX" () as single
declare function PickedY cdecl alias "PickedY" () as single
declare function PickedZ cdecl alias "PickedZ" () as single
declare function PointEntity cdecl alias "PointEntity" (byval ent as any ptr, byval target_ent as any ptr, byval roll as single=0) as integer
declare function PositionEntity cdecl alias "PositionEntity" (byval ent as any ptr, byval x as single, byval y as single, byval z as single, byval glob as integer=0) as integer
declare function PositionMesh cdecl alias "PositionMesh" (byval mesh as any ptr, byval px as single, byval py as single, byval pz as single) as integer
declare function PositionTexture cdecl alias "PositionTexture" (byval tex as any ptr, byval u_pos as integer, byval v_pos as integer) as integer
declare function ProjectedX cdecl alias "ProjectedX" () as single
declare function ProjectedY cdecl alias "ProjectedY" () as single
declare function ProjectedZ cdecl alias "ProjectedZ" () as single
declare function RenderWorld cdecl alias "RenderWorld" () as integer
declare function ResetEntity cdecl alias "ResetEntity" (byval ent as any ptr) as integer
declare function RotateEntity cdecl alias "RotateEntity" (byval ent as any ptr, byval x as single, byval y as single, byval z as single, byval glob as integer=0) as integer
declare function RotateMesh cdecl alias "RotateMesh" (byval mesh as any ptr, byval pitch as single, byval yaw as single, byval roll as single) as any ptr
declare function RotateSprite cdecl alias "RotateSprite" (byval sprite as any ptr, byval ang as single) as integer
declare function RotateTexture cdecl alias "RotateTexture" (byval tex as any ptr, byval ang as single) as integer
declare function ScaleEntity cdecl alias "ScaleEntity" (byval ent as any ptr, byval x as single, byval y as single, byval z as single, byval glob as integer=0) as integer
declare function ScaleMesh cdecl alias "ScaleMesh" (byval mesh as any ptr, byval sx as single, byval sy as single, byval sz as single) as integer
declare function ScaleSprite cdecl alias "ScaleSprite" (byval sprite as any ptr, byval s_x as single, byval s_y as single) as integer
declare function ScaleTexture cdecl alias "ScaleTexture" (byval tex as any ptr, byval u_scale as single, byval v_scale as single) as integer
declare function SetAnimTime cdecl alias "SetAnimTime" (byval ent as any ptr, byval time as single, byval seq as integer=0) as integer
declare function SetCubeFace cdecl alias "SetCubeFace" (byval tex as any ptr, byval face as integer) as integer
declare function SetCubeMode cdecl alias "SetCubeMode" (byval tex as any ptr, byval mode as integer) as integer
declare function ShowEntity cdecl alias "ShowEntity" (byval ent as any ptr) as integer
declare function SpriteViewMode cdecl alias "SpriteViewMode" (byval sprite as any ptr, byval mode as integer) as integer
declare function TextureBlend cdecl alias "TextureBlend" (byval tex as any ptr, byval blend as integer) as integer
declare function TextureCoords cdecl alias "TextureCoords" (byval tex as any ptr, byval coords as integer) as integer
declare function TextureHeight cdecl alias "TextureHeight" (byval tex as any ptr) as integer
declare function TextureFilter cdecl alias "TextureFilter" (byval match_text as zstring ptr, byval flags as integer) as integer
declare function TextureName cdecl alias "TextureName" (byval tex as any ptr) as string
declare function TerrainHeight cdecl alias "TerrainHeight" (byval terr as any ptr, byval x as integer, byval z as integer) as single
declare function TerrainX cdecl alias "TerrainX" (byval terr as any ptr, byval x as single, byval y as single, byval z as single) as single
declare function TerrainY cdecl alias "TerrainY" (byval terr as any ptr, byval x as single, byval y as single, byval z as single) as single
declare function TerrainZ cdecl alias "TerrainZ" (byval terr as any ptr, byval x as single, byval y as single, byval z as single) as single
declare function TextureWidth cdecl alias "TextureWidth" (byval tex as any ptr) as integer
declare function TFormedX cdecl alias "TFormedX" () as single
declare function TFormedY cdecl alias "TFormedY" () as single
declare function TFormedZ cdecl alias "TFormedZ" () as single
declare function TFormNormal cdecl alias "TFormNormal" (byval x as single, byval y as single, byval z as single, byval src_ent as any ptr, byval dest_ent as any ptr) as integer
declare function TFormPoint cdecl alias "TFormPoint" (byval x as single, byval y as single, byval z as single, byval src_ent as any ptr, byval dest_ent as any ptr) as integer
declare function TFormVector cdecl alias "TFormVector" (byval x as single, byval y as single, byval z as single, byval src_ent as any ptr, byval dest_ent as any ptr) as integer
declare function TranslateEntity cdecl alias "TranslateEntity" (byval ent as any ptr, byval x as single, byval y as single, byval z as single, byval glob as integer=0) as integer
declare function TriangleVertex cdecl alias "TriangleVertex" (byval surf as any ptr, byval tri_no as integer, byval corner as integer) as integer
declare function TurnEntity cdecl alias "TurnEntity" (byval ent as any ptr, byval x as single, byval y as single, byval z as single, byval glob as integer=0) as integer
declare function UpdateNormals cdecl alias "UpdateNormals" (byval mesh as any ptr) as integer
declare function UpdateWorld cdecl alias "UpdateWorld" (byval anim_speed as single=1) as integer
declare function VectorPitch cdecl alias "VectorPitch" (byval vx as single, byval vy as single, byval vz as single) as single
declare function VectorYaw cdecl alias "VectorYaw" (byval vx as single, byval vy as single, byval vz as single) as single
declare function VertexAlpha cdecl alias "VertexAlpha" (byval surf as any ptr, byval vid as integer) as single
declare function VertexBlue cdecl alias "VertexBlue" (byval surf as any ptr, byval vid as integer) as single
declare function VertexColor cdecl alias "VertexColor" (byval surf as any ptr, byval vid as integer, byval r as single, byval g as single, byval b as single, byval a as single=1) as integer
declare sub VertexCoords cdecl alias "VertexCoords" (byval surf as any ptr, byval vid as integer, byval x as single, byval y as single, byval z as single)
declare function VertexGreen cdecl alias "VertexGreen" (byval surf as any ptr, byval vid as integer) as single
declare function VertexNormal cdecl alias "VertexNormal" (byval surf as any ptr, byval vid as integer, byval nx as single, byval ny as single, byval nz as single) as integer
declare function VertexNX cdecl alias "VertexNX" (byval surf as any ptr, byval vid as integer) as single
declare function VertexNY cdecl alias "VertexNY" (byval surf as any ptr, byval vid as integer) as single
declare function VertexNZ cdecl alias "VertexNZ" (byval surf as any ptr, byval vid as integer) as single
declare function VertexRed cdecl alias "VertexRed" (byval surf as any ptr, byval vid as integer) as single
declare function VertexTexCoords cdecl alias "VertexTexCoords" (byval surf as any ptr, byval vid as integer, byval u as single, byval v as single, byval w as single=0, byval coord_set as integer=0) as integer
declare function VertexU cdecl alias "VertexU" (byval surf as any ptr, byval vid as integer, byval coord_set as integer=0) as single
declare function VertexV cdecl alias "VertexV" (byval surf as any ptr, byval vid as integer, byval coord_set as integer=0) as single
declare function VertexW cdecl alias "VertexW" (byval surf as any ptr, byval vid as integer, byval coord_set as integer=0) as single
declare function VertexX cdecl alias "VertexX" (byval surf as any ptr, byval vid as integer) as single
declare function VertexY cdecl alias "VertexY" (byval surf as any ptr, byval vid as integer) as single
declare function VertexZ cdecl alias "VertexZ" (byval surf as any ptr, byval vid as integer) as single
declare function Wireframe cdecl alias "Wireframe" (byval enable as integer) as integer
declare function EntityScaleX cdecl alias "EntityScaleX" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityScaleY cdecl alias "EntityScaleY" (byval ent as any ptr, byval glob as integer=0) as single
declare function EntityScaleZ cdecl alias "EntityScaleZ" (byval ent as any ptr, byval glob as integer=0) as single

#endif

