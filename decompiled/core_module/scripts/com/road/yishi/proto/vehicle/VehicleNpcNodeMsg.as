package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleNpcNodeMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var cur_x$field:int;
      
      private var cur_y$field:int;
      
      private var state$field:int;
      
      private var hp$field:int;
      
      private var name$field:String;
      
      private var sonType$field:int;
      
      private var heroTempId$field:int;
      
      private var resource$field:int;
      
      private var nameColor$field:int;
      
      private var rest_x$field:int;
      
      private var rest_y$field:int;
      
      private var team$field:int;
      
      [ArrayElementType("int")]
      public var path:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.vehicle.SkillBuffMsg")]
      public var skillBuffList:Array = [];
      
      public function VehicleNpcNodeMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeCurX() : void
      {
         hasField$0 &= 4294967291;
         cur_x$field = new int();
      }
      
      public function get hasCurX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curX(param1:int) : void
      {
         hasField$0 |= 4;
         cur_x$field = param1;
      }
      
      public function get curX() : int
      {
         return cur_x$field;
      }
      
      public function removeCurY() : void
      {
         hasField$0 &= 4294967287;
         cur_y$field = new int();
      }
      
      public function get hasCurY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curY(param1:int) : void
      {
         hasField$0 |= 8;
         cur_y$field = param1;
      }
      
      public function get curY() : int
      {
         return cur_y$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967263;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 32;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967231;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 64;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removeHeroTempId() : void
      {
         hasField$0 &= 4294967167;
         heroTempId$field = new int();
      }
      
      public function get hasHeroTempId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set heroTempId(param1:int) : void
      {
         hasField$0 |= 128;
         heroTempId$field = param1;
      }
      
      public function get heroTempId() : int
      {
         return heroTempId$field;
      }
      
      public function removeResource() : void
      {
         hasField$0 &= 4294967039;
         resource$field = new int();
      }
      
      public function get hasResource() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set resource(param1:int) : void
      {
         hasField$0 |= 256;
         resource$field = param1;
      }
      
      public function get resource() : int
      {
         return resource$field;
      }
      
      public function removeNameColor() : void
      {
         hasField$0 &= 4294966783;
         nameColor$field = new int();
      }
      
      public function get hasNameColor() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set nameColor(param1:int) : void
      {
         hasField$0 |= 512;
         nameColor$field = param1;
      }
      
      public function get nameColor() : int
      {
         return nameColor$field;
      }
      
      public function removeRestX() : void
      {
         hasField$0 &= 4294966271;
         rest_x$field = new int();
      }
      
      public function get hasRestX() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set restX(param1:int) : void
      {
         hasField$0 |= 1024;
         rest_x$field = param1;
      }
      
      public function get restX() : int
      {
         return rest_x$field;
      }
      
      public function removeRestY() : void
      {
         hasField$0 &= 4294965247;
         rest_y$field = new int();
      }
      
      public function get hasRestY() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set restY(param1:int) : void
      {
         hasField$0 |= 2048;
         rest_y$field = param1;
      }
      
      public function get restY() : int
      {
         return rest_y$field;
      }
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294963199;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 4096;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasCurX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cur_x$field);
         }
         if(hasCurY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_y$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasHeroTempId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,heroTempId$field);
         }
         if(hasResource)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,resource$field);
         }
         if(hasNameColor)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,nameColor$field);
         }
         if(hasRestX)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,rest_x$field);
         }
         if(hasRestY)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,rest_y$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         _loc2_ = 0;
         while(_loc2_ < path.length)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,path[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < skillBuffList.length)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_MESSAGE(param1,skillBuffList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc4_:SkillBuffMsg = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.nodeId cannot be set twice.");
                  }
                  _loc6_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.curX cannot be set twice.");
                  }
                  _loc5_++;
                  curX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.curY cannot be set twice.");
                  }
                  _loc13_++;
                  curY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.state cannot be set twice.");
                  }
                  _loc14_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.hp cannot be set twice.");
                  }
                  _loc15_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.name cannot be set twice.");
                  }
                  _loc11_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.sonType cannot be set twice.");
                  }
                  _loc10_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.heroTempId cannot be set twice.");
                  }
                  _loc9_++;
                  heroTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.resource cannot be set twice.");
                  }
                  _loc8_++;
                  resource = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.nameColor cannot be set twice.");
                  }
                  _loc3_++;
                  nameColor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.restX cannot be set twice.");
                  }
                  _loc18_++;
                  restX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.restY cannot be set twice.");
                  }
                  _loc12_++;
                  restY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleNpcNodeMsg.team cannot be set twice.");
                  }
                  _loc17_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if((_loc16_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,path);
                  }
                  else
                  {
                     path.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 15:
                  _loc4_ = new SkillBuffMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  skillBuffList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

