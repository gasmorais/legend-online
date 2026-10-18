package com.road.yishi.proto.finalroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FinalRoadGroupRspMsg extends Message implements IExternalizable
   {
      
      private var chapter$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var groupLevel$field:int;
      
      private var state$field:int;
      
      private var surplusLevelTimes$field:int;
      
      private var levelSkills$field:String;
      
      [ArrayElementType("com.road.yishi.proto.finalroad.FinalRoadEventRspMsg")]
      public var events:Array = [];
      
      public function FinalRoadGroupRspMsg()
      {
         super();
      }
      
      public function removeChapter() : void
      {
         hasField$0 &= 4294967294;
         chapter$field = new int();
      }
      
      public function get hasChapter() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set chapter(param1:int) : void
      {
         hasField$0 |= 1;
         chapter$field = param1;
      }
      
      public function get chapter() : int
      {
         return chapter$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeGroupLevel() : void
      {
         hasField$0 &= 4294967291;
         groupLevel$field = new int();
      }
      
      public function get hasGroupLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set groupLevel(param1:int) : void
      {
         hasField$0 |= 4;
         groupLevel$field = param1;
      }
      
      public function get groupLevel() : int
      {
         return groupLevel$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeSurplusLevelTimes() : void
      {
         hasField$0 &= 4294967279;
         surplusLevelTimes$field = new int();
      }
      
      public function get hasSurplusLevelTimes() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set surplusLevelTimes(param1:int) : void
      {
         hasField$0 |= 16;
         surplusLevelTimes$field = param1;
      }
      
      public function get surplusLevelTimes() : int
      {
         return surplusLevelTimes$field;
      }
      
      public function removeLevelSkills() : void
      {
         levelSkills$field = null;
      }
      
      public function get hasLevelSkills() : Boolean
      {
         return levelSkills$field != null;
      }
      
      public function set levelSkills(param1:String) : void
      {
         levelSkills$field = param1;
      }
      
      public function get levelSkills() : String
      {
         return levelSkills$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasChapter)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,chapter$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasGroupLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,groupLevel$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasSurplusLevelTimes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,surplusLevelTimes$field);
         }
         if(hasLevelSkills)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,levelSkills$field);
         }
         _loc2_ = 0;
         while(_loc2_ < events.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,events[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:FinalRoadEventRspMsg = null;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadGroupRspMsg.chapter cannot be set twice.");
                  }
                  _loc9_++;
                  chapter = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadGroupRspMsg.level cannot be set twice.");
                  }
                  _loc4_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadGroupRspMsg.groupLevel cannot be set twice.");
                  }
                  _loc3_++;
                  groupLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadGroupRspMsg.state cannot be set twice.");
                  }
                  _loc7_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadGroupRspMsg.surplusLevelTimes cannot be set twice.");
                  }
                  _loc6_++;
                  surplusLevelTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadGroupRspMsg.levelSkills cannot be set twice.");
                  }
                  _loc10_++;
                  levelSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  _loc5_ = new FinalRoadEventRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  events.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

