package com.road.yishi.proto.perkinlab
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PerkinLabLogMsg extends Message implements IExternalizable
   {
      
      private var time$field:String;
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var keng_size$field:int;
      
      private var win$field:Boolean;
      
      private var rival_name$field:String;
      
      private var rob_reward$field:String;
      
      public function PerkinLabLogMsg()
      {
         super();
      }
      
      public function removeTime() : void
      {
         time$field = null;
      }
      
      public function get hasTime() : Boolean
      {
         return time$field != null;
      }
      
      public function set time(param1:String) : void
      {
         time$field = param1;
      }
      
      public function get time() : String
      {
         return time$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeKengSize() : void
      {
         hasField$0 &= 4294967293;
         keng_size$field = new int();
      }
      
      public function get hasKengSize() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set kengSize(param1:int) : void
      {
         hasField$0 |= 2;
         keng_size$field = param1;
      }
      
      public function get kengSize() : int
      {
         return keng_size$field;
      }
      
      public function removeWin() : void
      {
         hasField$0 &= 4294967291;
         win$field = new Boolean();
      }
      
      public function get hasWin() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set win(param1:Boolean) : void
      {
         hasField$0 |= 4;
         win$field = param1;
      }
      
      public function get win() : Boolean
      {
         return win$field;
      }
      
      public function removeRivalName() : void
      {
         rival_name$field = null;
      }
      
      public function get hasRivalName() : Boolean
      {
         return rival_name$field != null;
      }
      
      public function set rivalName(param1:String) : void
      {
         rival_name$field = param1;
      }
      
      public function get rivalName() : String
      {
         return rival_name$field;
      }
      
      public function removeRobReward() : void
      {
         rob_reward$field = null;
      }
      
      public function get hasRobReward() : Boolean
      {
         return rob_reward$field != null;
      }
      
      public function set robReward(param1:String) : void
      {
         rob_reward$field = param1;
      }
      
      public function get robReward() : String
      {
         return rob_reward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,time$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasKengSize)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,keng_size$field);
         }
         if(hasWin)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,win$field);
         }
         if(hasRivalName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,rival_name$field);
         }
         if(hasRobReward)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,rob_reward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabLogMsg.time cannot be set twice.");
                  }
                  _loc8_++;
                  time = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabLogMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabLogMsg.kengSize cannot be set twice.");
                  }
                  _loc9_++;
                  kengSize = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabLogMsg.win cannot be set twice.");
                  }
                  _loc5_++;
                  win = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabLogMsg.rivalName cannot be set twice.");
                  }
                  _loc3_++;
                  rivalName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabLogMsg.robReward cannot be set twice.");
                  }
                  _loc4_++;
                  robReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

