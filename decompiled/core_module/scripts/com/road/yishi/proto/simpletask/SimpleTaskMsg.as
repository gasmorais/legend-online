package com.road.yishi.proto.simpletask
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleTaskMsg extends Message implements IExternalizable
   {
      
      private var taskId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var detail$field:String;
      
      private var iParam1$field:int;
      
      private var iParam2$field:int;
      
      private var iParam3$field:int;
      
      private var iParam4$field:int;
      
      private var iParam5$field:int;
      
      private var sParam1$field:String;
      
      private var extraRewardCost$field:int;
      
      [ArrayElementType("com.road.yishi.proto.simpletask.SimpleTaskRewardMsg")]
      public var generalReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.simpletask.SimpleTaskRewardMsg")]
      public var extraReward:Array = [];
      
      public function SimpleTaskMsg()
      {
         super();
      }
      
      public function removeTaskId() : void
      {
         hasField$0 &= 4294967294;
         taskId$field = new int();
      }
      
      public function get hasTaskId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set taskId(param1:int) : void
      {
         hasField$0 |= 1;
         taskId$field = param1;
      }
      
      public function get taskId() : int
      {
         return taskId$field;
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
      
      public function removeDetail() : void
      {
         detail$field = null;
      }
      
      public function get hasDetail() : Boolean
      {
         return detail$field != null;
      }
      
      public function set detail(param1:String) : void
      {
         detail$field = param1;
      }
      
      public function get detail() : String
      {
         return detail$field;
      }
      
      public function removeIParam1() : void
      {
         hasField$0 &= 4294967291;
         iParam1$field = new int();
      }
      
      public function get hasIParam1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set iParam1(param1:int) : void
      {
         hasField$0 |= 4;
         iParam1$field = param1;
      }
      
      public function get iParam1() : int
      {
         return iParam1$field;
      }
      
      public function removeIParam2() : void
      {
         hasField$0 &= 4294967287;
         iParam2$field = new int();
      }
      
      public function get hasIParam2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set iParam2(param1:int) : void
      {
         hasField$0 |= 8;
         iParam2$field = param1;
      }
      
      public function get iParam2() : int
      {
         return iParam2$field;
      }
      
      public function removeIParam3() : void
      {
         hasField$0 &= 4294967279;
         iParam3$field = new int();
      }
      
      public function get hasIParam3() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set iParam3(param1:int) : void
      {
         hasField$0 |= 16;
         iParam3$field = param1;
      }
      
      public function get iParam3() : int
      {
         return iParam3$field;
      }
      
      public function removeIParam4() : void
      {
         hasField$0 &= 4294967263;
         iParam4$field = new int();
      }
      
      public function get hasIParam4() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set iParam4(param1:int) : void
      {
         hasField$0 |= 32;
         iParam4$field = param1;
      }
      
      public function get iParam4() : int
      {
         return iParam4$field;
      }
      
      public function removeIParam5() : void
      {
         hasField$0 &= 4294967231;
         iParam5$field = new int();
      }
      
      public function get hasIParam5() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set iParam5(param1:int) : void
      {
         hasField$0 |= 64;
         iParam5$field = param1;
      }
      
      public function get iParam5() : int
      {
         return iParam5$field;
      }
      
      public function removeSParam1() : void
      {
         sParam1$field = null;
      }
      
      public function get hasSParam1() : Boolean
      {
         return sParam1$field != null;
      }
      
      public function set sParam1(param1:String) : void
      {
         sParam1$field = param1;
      }
      
      public function get sParam1() : String
      {
         return sParam1$field;
      }
      
      public function removeExtraRewardCost() : void
      {
         hasField$0 &= 4294967167;
         extraRewardCost$field = new int();
      }
      
      public function get hasExtraRewardCost() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set extraRewardCost(param1:int) : void
      {
         hasField$0 |= 128;
         extraRewardCost$field = param1;
      }
      
      public function get extraRewardCost() : int
      {
         return extraRewardCost$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasTaskId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,taskId$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasDetail)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,detail$field);
         }
         if(hasIParam1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,iParam1$field);
         }
         if(hasIParam2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,iParam2$field);
         }
         if(hasIParam3)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,iParam3$field);
         }
         if(hasIParam4)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,iParam4$field);
         }
         if(hasIParam5)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,iParam5$field);
         }
         if(hasSParam1)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,sParam1$field);
         }
         if(hasExtraRewardCost)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,extraRewardCost$field);
         }
         _loc2_ = 0;
         while(_loc2_ < generalReward.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,generalReward[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < extraReward.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,extraReward[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc10_:SimpleTaskRewardMsg = null;
         var _loc11_:SimpleTaskRewardMsg = null;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.taskId cannot be set twice.");
                  }
                  _loc7_++;
                  taskId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.detail cannot be set twice.");
                  }
                  _loc12_++;
                  detail = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.iParam1 cannot be set twice.");
                  }
                  _loc5_++;
                  iParam1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.iParam2 cannot be set twice.");
                  }
                  _loc3_++;
                  iParam2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.iParam3 cannot be set twice.");
                  }
                  _loc4_++;
                  iParam3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.iParam4 cannot be set twice.");
                  }
                  _loc15_++;
                  iParam4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.iParam5 cannot be set twice.");
                  }
                  _loc9_++;
                  iParam5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.sParam1 cannot be set twice.");
                  }
                  _loc8_++;
                  sParam1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.extraRewardCost cannot be set twice.");
                  }
                  _loc14_++;
                  extraRewardCost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  _loc10_ = new SimpleTaskRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  generalReward.push(_loc10_);
                  break;
               case 11:
                  _loc11_ = new SimpleTaskRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  extraReward.push(_loc11_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

