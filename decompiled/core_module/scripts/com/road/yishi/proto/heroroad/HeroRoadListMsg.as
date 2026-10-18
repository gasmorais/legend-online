package com.road.yishi.proto.heroroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroRoadListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var taskTempId$field:int;
      
      private var heroScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.heroroad.HeroRoadInfoMsg")]
      public var roadInfo:Array = [];
      
      public function HeroRoadListMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeTaskTempId() : void
      {
         hasField$0 &= 4294967293;
         taskTempId$field = new int();
      }
      
      public function get hasTaskTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set taskTempId(param1:int) : void
      {
         hasField$0 |= 2;
         taskTempId$field = param1;
      }
      
      public function get taskTempId() : int
      {
         return taskTempId$field;
      }
      
      public function removeHeroScore() : void
      {
         hasField$0 &= 4294967291;
         heroScore$field = new int();
      }
      
      public function get hasHeroScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set heroScore(param1:int) : void
      {
         hasField$0 |= 4;
         heroScore$field = param1;
      }
      
      public function get heroScore() : int
      {
         return heroScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasTaskTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,taskTempId$field);
         }
         if(hasHeroScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,heroScore$field);
         }
         _loc2_ = 0;
         while(_loc2_ < roadInfo.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,roadInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc7_:HeroRoadInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadListMsg.op cannot be set twice.");
                  }
                  _loc5_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadListMsg.taskTempId cannot be set twice.");
                  }
                  _loc3_++;
                  taskTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadListMsg.heroScore cannot be set twice.");
                  }
                  _loc6_++;
                  heroScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc7_ = new HeroRoadInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  roadInfo.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

