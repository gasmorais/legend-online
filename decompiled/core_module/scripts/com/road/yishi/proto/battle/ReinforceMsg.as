package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReinforceMsg extends Message implements IExternalizable
   {
      
      private var side$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var hero:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.SoldierMsg")]
      public var soldiers:Array = [];
      
      private var reinforceWave$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var pets:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var children:Array = [];
      
      [ArrayElementType("int")]
      public var removeLivingIds:Array = [];
      
      [ArrayElementType("int")]
      public var heroTempId:Array = [];
      
      [ArrayElementType("Int64")]
      public var life:Array = [];
      
      private var frame_num$field:int;
      
      private var opType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var goddesses:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var monsters:Array = [];
      
      public function ReinforceMsg()
      {
         super();
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967294;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 1;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removeReinforceWave() : void
      {
         hasField$0 &= 4294967293;
         reinforceWave$field = new int();
      }
      
      public function get hasReinforceWave() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set reinforceWave(param1:int) : void
      {
         hasField$0 |= 2;
         reinforceWave$field = param1;
      }
      
      public function get reinforceWave() : int
      {
         return reinforceWave$field;
      }
      
      public function removeFrameNum() : void
      {
         hasField$0 &= 4294967291;
         frame_num$field = new int();
      }
      
      public function get hasFrameNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set frameNum(param1:int) : void
      {
         hasField$0 |= 4;
         frame_num$field = param1;
      }
      
      public function get frameNum() : int
      {
         return frame_num$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967287;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 8;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc7_:* = 0;
         var _loc6_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc8_:* = 0;
         var _loc10_:* = 0;
         var _loc4_:* = 0;
         var _loc9_:* = 0;
         var _loc5_:* = 0;
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         _loc7_ = 0;
         while(_loc7_ < hero.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,hero[_loc7_]);
            _loc7_++;
         }
         _loc6_ = 0;
         while(_loc6_ < soldiers.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,soldiers[_loc6_]);
            _loc6_++;
         }
         if(hasReinforceWave)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,reinforceWave$field);
         }
         _loc3_ = 0;
         while(_loc3_ < pets.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,pets[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < children.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,children[_loc2_]);
            _loc2_++;
         }
         _loc8_ = 0;
         while(_loc8_ < removeLivingIds.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,removeLivingIds[_loc8_]);
            _loc8_++;
         }
         _loc10_ = 0;
         while(_loc10_ < heroTempId.length)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,heroTempId[_loc10_]);
            _loc10_++;
         }
         _loc4_ = 0;
         while(_loc4_ < life.length)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,life[_loc4_]);
            _loc4_++;
         }
         if(hasFrameNum)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,frame_num$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         _loc9_ = 0;
         while(_loc9_ < goddesses.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,goddesses[_loc9_]);
            _loc9_++;
         }
         _loc5_ = 0;
         while(_loc5_ < monsters.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,monsters[_loc5_]);
            _loc5_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc3_:HeroMsg = null;
         var _loc5_:SoldierMsg = null;
         var _loc6_:HeroMsg = null;
         var _loc4_:HeroMsg = null;
         var _loc8_:HeroMsg = null;
         var _loc9_:HeroMsg = null;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ReinforceMsg.side cannot be set twice.");
                  }
                  _loc10_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  hero.push(_loc3_);
                  break;
               case 2:
                  _loc5_ = new SoldierMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  soldiers.push(_loc5_);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ReinforceMsg.reinforceWave cannot be set twice.");
                  }
                  _loc7_++;
                  reinforceWave = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  pets.push(_loc6_);
                  break;
               case 5:
                  _loc4_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  children.push(_loc4_);
                  break;
               case 6:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,removeLivingIds);
                  }
                  else
                  {
                     removeLivingIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 7:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,heroTempId);
                  }
                  else
                  {
                     heroTempId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 8:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT64,life);
                  }
                  else
                  {
                     life.push(ReadUtils.read$TYPE_INT64(param1));
                  }
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ReinforceMsg.frameNum cannot be set twice.");
                  }
                  _loc13_++;
                  frameNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ReinforceMsg.opType cannot be set twice.");
                  }
                  _loc11_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  _loc8_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  goddesses.push(_loc8_);
                  break;
               case 12:
                  _loc9_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  monsters.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

