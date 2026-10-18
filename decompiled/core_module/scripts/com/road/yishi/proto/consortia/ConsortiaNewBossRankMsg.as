package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaNewBossRankMsg extends Message implements IExternalizable
   {
      
      private var rank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userid$field:int;
      
      private var nick_name$field:String;
      
      private var damage$field:Int64;
      
      public function ConsortiaNewBossRankMsg()
      {
         super();
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967294;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 1;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
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
      
      public function removeDamage() : void
      {
         damage$field = null;
      }
      
      public function get hasDamage() : Boolean
      {
         return damage$field != null;
      }
      
      public function set damage(param1:Int64) : void
      {
         damage$field = param1;
      }
      
      public function get damage() : Int64
      {
         return damage$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasUserid)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userid$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasDamage)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,damage$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossRankMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossRankMsg.userid cannot be set twice.");
                  }
                  _loc3_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossRankMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossRankMsg.damage cannot be set twice.");
                  }
                  _loc6_++;
                  damage = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

