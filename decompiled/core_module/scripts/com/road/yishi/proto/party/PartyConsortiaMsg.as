package com.road.yishi.proto.party
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PartyConsortiaMsg extends Message implements IExternalizable
   {
      
      private var serverUid$field:String;
      
      private var serverName$field:String;
      
      private var consortiaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortiaName$field:String;
      
      private var consortiaGrade$field:int;
      
      private var score$field:int;
      
      private var order$field:int;
      
      private var uuid$field:String;
      
      public function PartyConsortiaMsg()
      {
         super();
      }
      
      public function removeServerUid() : void
      {
         serverUid$field = null;
      }
      
      public function get hasServerUid() : Boolean
      {
         return serverUid$field != null;
      }
      
      public function set serverUid(param1:String) : void
      {
         serverUid$field = param1;
      }
      
      public function get serverUid() : String
      {
         return serverUid$field;
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
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortiaId$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortiaId$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortiaId$field;
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
      
      public function removeConsortiaGrade() : void
      {
         hasField$0 &= 4294967293;
         consortiaGrade$field = new int();
      }
      
      public function get hasConsortiaGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consortiaGrade(param1:int) : void
      {
         hasField$0 |= 2;
         consortiaGrade$field = param1;
      }
      
      public function get consortiaGrade() : int
      {
         return consortiaGrade$field;
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
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967287;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 8;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasServerUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,serverUid$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,consortiaId$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasConsortiaGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,consortiaGrade$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.serverUid cannot be set twice.");
                  }
                  _loc9_++;
                  serverUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.consortiaId cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.consortiaName cannot be set twice.");
                  }
                  _loc6_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.consortiaGrade cannot be set twice.");
                  }
                  _loc10_++;
                  consortiaGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.score cannot be set twice.");
                  }
                  _loc11_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.order cannot be set twice.");
                  }
                  _loc7_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsg.uuid cannot be set twice.");
                  }
                  _loc4_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

