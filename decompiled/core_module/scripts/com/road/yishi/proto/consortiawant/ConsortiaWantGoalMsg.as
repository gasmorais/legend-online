package com.road.yishi.proto.consortiawant
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWantGoalMsg extends Message implements IExternalizable
   {
      
      private var Id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var starLevel$field:int;
      
      private var score$field:int;
      
      private var nickName$field:String;
      
      private var consortiaName$field:String;
      
      private var fashion$field:String;
      
      private var isHiden$field:Boolean;
      
      private var job$field:int;
      
      public function ConsortiaWantGoalMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         Id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         Id$field = param1;
      }
      
      public function get id() : int
      {
         return Id$field;
      }
      
      public function removeStarLevel() : void
      {
         hasField$0 &= 4294967293;
         starLevel$field = new int();
      }
      
      public function get hasStarLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set starLevel(param1:int) : void
      {
         hasField$0 |= 2;
         starLevel$field = param1;
      }
      
      public function get starLevel() : int
      {
         return starLevel$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
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
      
      public function removeConsortiaName() : void
      {
         consortiaName$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortiaName$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortiaName$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortiaName$field;
      }
      
      public function removeFashion() : void
      {
         fashion$field = null;
      }
      
      public function get hasFashion() : Boolean
      {
         return fashion$field != null;
      }
      
      public function set fashion(param1:String) : void
      {
         fashion$field = param1;
      }
      
      public function get fashion() : String
      {
         return fashion$field;
      }
      
      public function removeIsHiden() : void
      {
         hasField$0 &= 4294967287;
         isHiden$field = new Boolean();
      }
      
      public function get hasIsHiden() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isHiden(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isHiden$field = param1;
      }
      
      public function get isHiden() : Boolean
      {
         return isHiden$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967279;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 16;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,Id$field);
         }
         if(hasStarLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,starLevel$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasFashion)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,fashion$field);
         }
         if(hasIsHiden)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isHiden$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.id cannot be set twice.");
                  }
                  _loc8_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.starLevel cannot be set twice.");
                  }
                  _loc5_++;
                  starLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.score cannot be set twice.");
                  }
                  _loc10_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.consortiaName cannot be set twice.");
                  }
                  _loc3_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.fashion cannot be set twice.");
                  }
                  _loc11_++;
                  fashion = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.isHiden cannot be set twice.");
                  }
                  _loc9_++;
                  isHiden = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantGoalMsg.job cannot be set twice.");
                  }
                  _loc6_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

