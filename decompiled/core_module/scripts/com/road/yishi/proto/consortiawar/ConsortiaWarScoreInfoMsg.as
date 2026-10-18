package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarScoreInfoMsg extends Message implements IExternalizable
   {
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortiaUid$field:String;
      
      private var consortiaName$field:String;
      
      private var serverName$field:String;
      
      private var score$field:int;
      
      public function ConsortiaWarScoreInfoMsg()
      {
         super();
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967294;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeConsortiaUid() : void
      {
         consortiaUid$field = null;
      }
      
      public function get hasConsortiaUid() : Boolean
      {
         return consortiaUid$field != null;
      }
      
      public function set consortiaUid(param1:String) : void
      {
         consortiaUid$field = param1;
      }
      
      public function get consortiaUid() : String
      {
         return consortiaUid$field;
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
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasConsortiaUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,consortiaUid$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarScoreInfoMsg.order cannot be set twice.");
                  }
                  _loc5_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarScoreInfoMsg.consortiaUid cannot be set twice.");
                  }
                  _loc8_++;
                  consortiaUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarScoreInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarScoreInfoMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarScoreInfoMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

