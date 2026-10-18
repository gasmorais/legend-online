package com.road.yishi.proto.consortiapve
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaPvePlayerMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var headId$field:int;
      
      private var nickName$field:String;
      
      private var fightPower$field:int;
      
      private var attackCount$field:int;
      
      private var totalDamage$field:Int64;
      
      public function ConsortiaPvePlayerMsg()
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
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967293;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 2;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967291;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 4;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967287;
         attackCount$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 8;
         attackCount$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attackCount$field;
      }
      
      public function removeTotalDamage() : void
      {
         totalDamage$field = null;
      }
      
      public function get hasTotalDamage() : Boolean
      {
         return totalDamage$field != null;
      }
      
      public function set totalDamage(param1:Int64) : void
      {
         totalDamage$field = param1;
      }
      
      public function get totalDamage() : Int64
      {
         return totalDamage$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,attackCount$field);
         }
         if(hasTotalDamage)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,totalDamage$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPvePlayerMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPvePlayerMsg.headId cannot be set twice.");
                  }
                  _loc6_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPvePlayerMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPvePlayerMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPvePlayerMsg.attackCount cannot be set twice.");
                  }
                  _loc5_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPvePlayerMsg.totalDamage cannot be set twice.");
                  }
                  _loc9_++;
                  totalDamage = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

