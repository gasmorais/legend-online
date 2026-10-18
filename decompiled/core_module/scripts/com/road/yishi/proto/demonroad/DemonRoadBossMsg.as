package com.road.yishi.proto.demonroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DemonRoadBossMsg extends Message implements IExternalizable
   {
      
      private var level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var resource$field:String;
      
      [ArrayElementType("com.road.yishi.proto.demonroad.DemonRoadRewardMsg")]
      public var rewards:Array = [];
      
      public function DemonRoadBossMsg()
      {
         super();
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967294;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 1;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeResource() : void
      {
         resource$field = null;
      }
      
      public function get hasResource() : Boolean
      {
         return resource$field != null;
      }
      
      public function set resource(param1:String) : void
      {
         resource$field = param1;
      }
      
      public function get resource() : String
      {
         return resource$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasResource)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,resource$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:DemonRoadRewardMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadBossMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadBossMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadBossMsg.resource cannot be set twice.");
                  }
                  _loc6_++;
                  resource = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc7_ = new DemonRoadRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  rewards.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

