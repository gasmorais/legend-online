package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveRankPB extends Message implements IExternalizable
   {
      
      private var user_name$field:String;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var rank$field:int;
      
      private var active_id$field:String;
      
      private var site$field:String;
      
      private var nick_name$field:String;
      
      public function ActiveRankPB()
      {
         super();
      }
      
      public function removeUserName() : void
      {
         hasField$0 &= 4294967294;
         user_name$field = new String();
      }
      
      public function get hasUserName() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userName(param1:String) : void
      {
         hasField$0 |= 1;
         user_name$field = param1;
      }
      
      public function get userName() : String
      {
         return user_name$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967291;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 4;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeActiveId() : void
      {
         hasField$0 &= 4294967287;
         active_id$field = new String();
      }
      
      public function get hasActiveId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set activeId(param1:String) : void
      {
         hasField$0 |= 8;
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      public function removeSite() : void
      {
         hasField$0 &= 4294967279;
         site$field = new String();
      }
      
      public function get hasSite() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set site(param1:String) : void
      {
         hasField$0 |= 16;
         site$field = param1;
      }
      
      public function get site() : String
      {
         return site$field;
      }
      
      public function removeNickName() : void
      {
         hasField$0 &= 4294967263;
         nick_name$field = new String();
      }
      
      public function get hasNickName() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set nickName(param1:String) : void
      {
         hasField$0 |= 32;
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,user_name$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRankPB.userName cannot be set twice.");
                  }
                  _loc7_++;
                  userName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRankPB.score cannot be set twice.");
                  }
                  _loc9_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRankPB.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRankPB.activeId cannot be set twice.");
                  }
                  _loc4_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRankPB.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRankPB.nickName cannot be set twice.");
                  }
                  _loc6_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

