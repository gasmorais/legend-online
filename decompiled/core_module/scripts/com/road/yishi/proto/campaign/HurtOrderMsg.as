package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HurtOrderMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hurt$field:int;
      
      private var isInAltar$field:Boolean;
      
      public function HurtOrderMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeHurt() : void
      {
         hasField$0 &= 4294967293;
         hurt$field = new int();
      }
      
      public function get hasHurt() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hurt(param1:int) : void
      {
         hasField$0 |= 2;
         hurt$field = param1;
      }
      
      public function get hurt() : int
      {
         return hurt$field;
      }
      
      public function removeIsInAltar() : void
      {
         hasField$0 &= 4294967291;
         isInAltar$field = new Boolean();
      }
      
      public function get hasIsInAltar() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isInAltar(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isInAltar$field = param1;
      }
      
      public function get isInAltar() : Boolean
      {
         return isInAltar$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasHurt)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hurt$field);
         }
         if(hasIsInAltar)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isInAltar$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HurtOrderMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HurtOrderMsg.hurt cannot be set twice.");
                  }
                  _loc3_++;
                  hurt = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HurtOrderMsg.isInAltar cannot be set twice.");
                  }
                  _loc4_++;
                  isInAltar = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

