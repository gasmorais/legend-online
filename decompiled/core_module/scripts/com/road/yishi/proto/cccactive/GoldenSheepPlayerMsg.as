package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldenSheepPlayerMsg extends Message implements IExternalizable
   {
      
      private var nick_name$field:String;
      
      private var money$field:int;
      
      private var hasField$0:uint = 0;
      
      private var is_best$field:Boolean;
      
      public function GoldenSheepPlayerMsg()
      {
         super();
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeMoney() : void
      {
         hasField$0 &= 4294967294;
         money$field = new int();
      }
      
      public function get hasMoney() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set money(param1:int) : void
      {
         hasField$0 |= 1;
         money$field = param1;
      }
      
      public function get money() : int
      {
         return money$field;
      }
      
      public function removeIsBest() : void
      {
         hasField$0 &= 4294967293;
         is_best$field = new Boolean();
      }
      
      public function get hasIsBest() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isBest(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_best$field = param1;
      }
      
      public function get isBest() : Boolean
      {
         return is_best$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasMoney)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,money$field);
         }
         if(hasIsBest)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_best$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepPlayerMsg.money cannot be set twice.");
                  }
                  _loc5_++;
                  money = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepPlayerMsg.isBest cannot be set twice.");
                  }
                  _loc3_++;
                  isBest = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

