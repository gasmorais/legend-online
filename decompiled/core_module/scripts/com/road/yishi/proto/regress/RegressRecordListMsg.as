package com.road.yishi.proto.regress
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RegressRecordListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.regress.RegressRecordMsg")]
      public var info:Array = [];
      
      private var chargeCanTakeCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var takedCount$field:int;
      
      private var canTakeTotalCount$field:int;
      
      private var loginDateCount$field:int;
      
      private var overDate$field:String;
      
      private var states$field:Boolean;
      
      private var targetSite$field:String;
      
      public function RegressRecordListMsg()
      {
         super();
      }
      
      public function removeChargeCanTakeCount() : void
      {
         hasField$0 &= 4294967294;
         chargeCanTakeCount$field = new int();
      }
      
      public function get hasChargeCanTakeCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set chargeCanTakeCount(param1:int) : void
      {
         hasField$0 |= 1;
         chargeCanTakeCount$field = param1;
      }
      
      public function get chargeCanTakeCount() : int
      {
         return chargeCanTakeCount$field;
      }
      
      public function removeTakedCount() : void
      {
         hasField$0 &= 4294967293;
         takedCount$field = new int();
      }
      
      public function get hasTakedCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set takedCount(param1:int) : void
      {
         hasField$0 |= 2;
         takedCount$field = param1;
      }
      
      public function get takedCount() : int
      {
         return takedCount$field;
      }
      
      public function removeCanTakeTotalCount() : void
      {
         hasField$0 &= 4294967291;
         canTakeTotalCount$field = new int();
      }
      
      public function get hasCanTakeTotalCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set canTakeTotalCount(param1:int) : void
      {
         hasField$0 |= 4;
         canTakeTotalCount$field = param1;
      }
      
      public function get canTakeTotalCount() : int
      {
         return canTakeTotalCount$field;
      }
      
      public function removeLoginDateCount() : void
      {
         hasField$0 &= 4294967287;
         loginDateCount$field = new int();
      }
      
      public function get hasLoginDateCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set loginDateCount(param1:int) : void
      {
         hasField$0 |= 8;
         loginDateCount$field = param1;
      }
      
      public function get loginDateCount() : int
      {
         return loginDateCount$field;
      }
      
      public function removeOverDate() : void
      {
         overDate$field = null;
      }
      
      public function get hasOverDate() : Boolean
      {
         return overDate$field != null;
      }
      
      public function set overDate(param1:String) : void
      {
         overDate$field = param1;
      }
      
      public function get overDate() : String
      {
         return overDate$field;
      }
      
      public function removeStates() : void
      {
         hasField$0 &= 4294967279;
         states$field = new Boolean();
      }
      
      public function get hasStates() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set states(param1:Boolean) : void
      {
         hasField$0 |= 16;
         states$field = param1;
      }
      
      public function get states() : Boolean
      {
         return states$field;
      }
      
      public function removeTargetSite() : void
      {
         targetSite$field = null;
      }
      
      public function get hasTargetSite() : Boolean
      {
         return targetSite$field != null;
      }
      
      public function set targetSite(param1:String) : void
      {
         targetSite$field = param1;
      }
      
      public function get targetSite() : String
      {
         return targetSite$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasChargeCanTakeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chargeCanTakeCount$field);
         }
         if(hasTakedCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,takedCount$field);
         }
         if(hasCanTakeTotalCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,canTakeTotalCount$field);
         }
         if(hasLoginDateCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,loginDateCount$field);
         }
         if(hasOverDate)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,overDate$field);
         }
         if(hasStates)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,states$field);
         }
         if(hasTargetSite)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,targetSite$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:RegressRecordMsg = null;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new RegressRecordMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  info.push(_loc6_);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.chargeCanTakeCount cannot be set twice.");
                  }
                  _loc8_++;
                  chargeCanTakeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.takedCount cannot be set twice.");
                  }
                  _loc5_++;
                  takedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.canTakeTotalCount cannot be set twice.");
                  }
                  _loc7_++;
                  canTakeTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.loginDateCount cannot be set twice.");
                  }
                  _loc11_++;
                  loginDateCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.overDate cannot be set twice.");
                  }
                  _loc10_++;
                  overDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.states cannot be set twice.");
                  }
                  _loc3_++;
                  states = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordListMsg.targetSite cannot be set twice.");
                  }
                  _loc4_++;
                  targetSite = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

