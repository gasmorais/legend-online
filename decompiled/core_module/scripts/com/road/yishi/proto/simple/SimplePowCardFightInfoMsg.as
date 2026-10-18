package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimplePowCardFightInfoMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userid$field:int;
      
      private var CampType$field:int;
      
      private var add$field:int;
      
      public function SimplePowCardFightInfoMsg()
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
      
      public function removeUserid() : void
      {
         hasField$0 &= 4294967293;
         userid$field = new int();
      }
      
      public function get hasUserid() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userid(param1:int) : void
      {
         hasField$0 |= 2;
         userid$field = param1;
      }
      
      public function get userid() : int
      {
         return userid$field;
      }
      
      public function removeCampType() : void
      {
         hasField$0 &= 4294967291;
         CampType$field = new int();
      }
      
      public function get hasCampType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set campType(param1:int) : void
      {
         hasField$0 |= 4;
         CampType$field = param1;
      }
      
      public function get campType() : int
      {
         return CampType$field;
      }
      
      public function removeAdd() : void
      {
         hasField$0 &= 4294967287;
         add$field = new int();
      }
      
      public function get hasAdd() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set add(param1:int) : void
      {
         hasField$0 |= 8;
         add$field = param1;
      }
      
      public function get add() : int
      {
         return add$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasUserid)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userid$field);
         }
         if(hasCampType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,CampType$field);
         }
         if(hasAdd)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,add$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePowCardFightInfoMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePowCardFightInfoMsg.userid cannot be set twice.");
                  }
                  _loc3_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePowCardFightInfoMsg.campType cannot be set twice.");
                  }
                  _loc5_++;
                  campType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePowCardFightInfoMsg.add cannot be set twice.");
                  }
                  _loc4_++;
                  add = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

