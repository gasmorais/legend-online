package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveInfoMsg extends Message implements IExternalizable
   {
      
      private var active_uid$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.ActiveRewardMsg")]
      public var activeReward:Array = [];
      
      private var param1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var beginTime$field:String;
      
      private var endTime$field:String;
      
      private var type$field:int;
      
      private var desc$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.ActiveSimpleMsg")]
      public var activeSimpleMsg:Array = [];
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      public function ActiveInfoMsg()
      {
         super();
      }
      
      public function removeActiveUid() : void
      {
         active_uid$field = null;
      }
      
      public function get hasActiveUid() : Boolean
      {
         return active_uid$field != null;
      }
      
      public function set activeUid(param1:String) : void
      {
         active_uid$field = param1;
      }
      
      public function get activeUid() : String
      {
         return active_uid$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967294;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 1;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeBeginTime() : void
      {
         beginTime$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return beginTime$field != null;
      }
      
      public function set beginTime(param1:String) : void
      {
         beginTime$field = param1;
      }
      
      public function get beginTime() : String
      {
         return beginTime$field;
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : String
      {
         return endTime$field;
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
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967291;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 4;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967287;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 8;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasActiveUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_uid$field);
         }
         _loc3_ = 0;
         while(_loc3_ < activeReward.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,activeReward[_loc3_]);
            _loc3_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,beginTime$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,endTime$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasDesc)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,desc$field);
         }
         _loc2_ = 0;
         while(_loc2_ < activeSimpleMsg.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,activeSimpleMsg[_loc2_]);
            _loc2_++;
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc7_:ActiveRewardMsg = null;
         var _loc12_:ActiveSimpleMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.activeUid cannot be set twice.");
                  }
                  _loc4_++;
                  activeUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc7_ = new ActiveRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  activeReward.push(_loc7_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.beginTime cannot be set twice.");
                  }
                  _loc10_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.endTime cannot be set twice.");
                  }
                  _loc3_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.type cannot be set twice.");
                  }
                  _loc9_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.desc cannot be set twice.");
                  }
                  _loc8_++;
                  desc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  _loc12_ = new ActiveSimpleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc12_);
                  activeSimpleMsg.push(_loc12_);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

