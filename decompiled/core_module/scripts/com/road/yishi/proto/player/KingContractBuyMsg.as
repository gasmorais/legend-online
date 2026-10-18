package com.road.yishi.proto.player
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class KingContractBuyMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var ids:Array = [];
      
      private var use$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var friendId$field:int;
      
      private var friendname$field:String;
      
      public function KingContractBuyMsg()
      {
         super();
      }
      
      public function removeUse() : void
      {
         hasField$0 &= 4294967294;
         use$field = new Boolean();
      }
      
      public function get hasUse() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set __use(param1:Boolean) : void
      {
         hasField$0 |= 1;
         use$field = param1;
      }
      
      public function get __use() : Boolean
      {
         return use$field;
      }
      
      public function removeFriendId() : void
      {
         hasField$0 &= 4294967293;
         friendId$field = new int();
      }
      
      public function get hasFriendId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set friendId(param1:int) : void
      {
         hasField$0 |= 2;
         friendId$field = param1;
      }
      
      public function get friendId() : int
      {
         return friendId$field;
      }
      
      public function removeFriendname() : void
      {
         friendname$field = null;
      }
      
      public function get hasFriendname() : Boolean
      {
         return friendname$field != null;
      }
      
      public function set friendname(param1:String) : void
      {
         friendname$field = param1;
      }
      
      public function get friendname() : String
      {
         return friendname$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < ids.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,ids[_loc2_]);
            _loc2_++;
         }
         if(hasUse)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,use$field);
         }
         if(hasFriendId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,friendId$field);
         }
         if(hasFriendname)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,friendname$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,ids);
                  }
                  else
                  {
                     ids.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: KingContractBuyMsg.__use cannot be set twice.");
                  }
                  _loc4_++;
                  __use = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: KingContractBuyMsg.friendId cannot be set twice.");
                  }
                  _loc3_++;
                  friendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: KingContractBuyMsg.friendname cannot be set twice.");
                  }
                  _loc5_++;
                  friendname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

