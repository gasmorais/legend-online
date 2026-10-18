package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LevelMsg extends Message implements IExternalizable
   {
      
      private var levelId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var needPoint$field:int;
      
      private var isFinish$field:Boolean;
      
      private var takeDays$field:int;
      
      private var maxTakeDays$field:int;
      
      private var canTake$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.GiftItemMsg")]
      public var item:Array = [];
      
      private var name$field:String;
      
      private var desc$field:String;
      
      public function LevelMsg()
      {
         super();
      }
      
      public function removeLevelId() : void
      {
         hasField$0 &= 4294967294;
         levelId$field = new int();
      }
      
      public function get hasLevelId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set levelId(param1:int) : void
      {
         hasField$0 |= 1;
         levelId$field = param1;
      }
      
      public function get levelId() : int
      {
         return levelId$field;
      }
      
      public function removeNeedPoint() : void
      {
         hasField$0 &= 4294967293;
         needPoint$field = new int();
      }
      
      public function get hasNeedPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set needPoint(param1:int) : void
      {
         hasField$0 |= 2;
         needPoint$field = param1;
      }
      
      public function get needPoint() : int
      {
         return needPoint$field;
      }
      
      public function removeIsFinish() : void
      {
         hasField$0 &= 4294967291;
         isFinish$field = new Boolean();
      }
      
      public function get hasIsFinish() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isFinish(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isFinish$field = param1;
      }
      
      public function get isFinish() : Boolean
      {
         return isFinish$field;
      }
      
      public function removeTakeDays() : void
      {
         hasField$0 &= 4294967287;
         takeDays$field = new int();
      }
      
      public function get hasTakeDays() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set takeDays(param1:int) : void
      {
         hasField$0 |= 8;
         takeDays$field = param1;
      }
      
      public function get takeDays() : int
      {
         return takeDays$field;
      }
      
      public function removeMaxTakeDays() : void
      {
         hasField$0 &= 4294967279;
         maxTakeDays$field = new int();
      }
      
      public function get hasMaxTakeDays() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set maxTakeDays(param1:int) : void
      {
         hasField$0 |= 16;
         maxTakeDays$field = param1;
      }
      
      public function get maxTakeDays() : int
      {
         return maxTakeDays$field;
      }
      
      public function removeCanTake() : void
      {
         hasField$0 &= 4294967263;
         canTake$field = new Boolean();
      }
      
      public function get hasCanTake() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set canTake(param1:Boolean) : void
      {
         hasField$0 |= 32;
         canTake$field = param1;
      }
      
      public function get canTake() : Boolean
      {
         return canTake$field;
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
      
      public function removeDesc() : void
      {
         desc$field = null;
      }
      
      public function get hasDesc() : Boolean
      {
         return desc$field != null;
      }
      
      public function set desc(param1:String) : void
      {
         desc$field = param1;
      }
      
      public function get desc() : String
      {
         return desc$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLevelId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,levelId$field);
         }
         if(hasNeedPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,needPoint$field);
         }
         if(hasIsFinish)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isFinish$field);
         }
         if(hasTakeDays)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,takeDays$field);
         }
         if(hasMaxTakeDays)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,maxTakeDays$field);
         }
         if(hasCanTake)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,canTake$field);
         }
         _loc2_ = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasDesc)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,desc$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc7_:GiftItemMsg = null;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.levelId cannot be set twice.");
                  }
                  _loc3_++;
                  levelId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.needPoint cannot be set twice.");
                  }
                  _loc12_++;
                  needPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.isFinish cannot be set twice.");
                  }
                  _loc4_++;
                  isFinish = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.takeDays cannot be set twice.");
                  }
                  _loc9_++;
                  takeDays = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.maxTakeDays cannot be set twice.");
                  }
                  _loc8_++;
                  maxTakeDays = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.canTake cannot be set twice.");
                  }
                  _loc6_++;
                  canTake = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  _loc7_ = new GiftItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  item.push(_loc7_);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.name cannot be set twice.");
                  }
                  _loc5_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LevelMsg.desc cannot be set twice.");
                  }
                  _loc10_++;
                  desc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

