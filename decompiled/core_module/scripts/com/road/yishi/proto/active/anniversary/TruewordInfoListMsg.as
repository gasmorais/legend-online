package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TruewordInfoListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.TruewordInfoMsg")]
      public var praiseInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.TruewordInfoMsg")]
      public var timesInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.TruewordInfoMsg")]
      public var myInfo:Array = [];
      
      private var createDate$field:String;
      
      private var batch_uid$field:String;
      
      private var total_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var type$field:int;
      
      public function TruewordInfoListMsg()
      {
         super();
      }
      
      public function removeCreateDate() : void
      {
         createDate$field = null;
      }
      
      public function get hasCreateDate() : Boolean
      {
         return createDate$field != null;
      }
      
      public function set createDate(param1:String) : void
      {
         createDate$field = param1;
      }
      
      public function get createDate() : String
      {
         return createDate$field;
      }
      
      public function removeBatchUid() : void
      {
         batch_uid$field = null;
      }
      
      public function get hasBatchUid() : Boolean
      {
         return batch_uid$field != null;
      }
      
      public function set batchUid(param1:String) : void
      {
         batch_uid$field = param1;
      }
      
      public function get batchUid() : String
      {
         return batch_uid$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967294;
         total_count$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 1;
         total_count$field = param1;
      }
      
      public function get totalCount() : int
      {
         return total_count$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967293;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 2;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
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
      
      public function removeType() : void
      {
         hasField$0 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < praiseInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,praiseInfo[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < timesInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,timesInfo[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < myInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,myInfo[_loc2_]);
            _loc2_++;
         }
         if(hasCreateDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,createDate$field);
         }
         if(hasBatchUid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,batch_uid$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,total_count$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc7_:TruewordInfoMsg = null;
         var _loc9_:TruewordInfoMsg = null;
         var _loc6_:TruewordInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new TruewordInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  praiseInfo.push(_loc7_);
                  break;
               case 1:
                  _loc9_ = new TruewordInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  timesInfo.push(_loc9_);
                  break;
               case 2:
                  _loc6_ = new TruewordInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  myInfo.push(_loc6_);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.createDate cannot be set twice.");
                  }
                  _loc10_++;
                  createDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.batchUid cannot be set twice.");
                  }
                  _loc12_++;
                  batchUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.totalCount cannot be set twice.");
                  }
                  _loc3_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoListMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

