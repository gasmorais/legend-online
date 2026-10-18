package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpRecordMsg extends Message implements IExternalizable
   {
      
      private var recordDate$field:String;
      
      private var result$field:int;
      
      private var hasField$0:uint = 0;
      
      private var group$field:int;
      
      private var name$field:String;
      
      private var serverName$field:String;
      
      private var addScore$field:int;
      
      private var rivalGroup$field:int;
      
      private var rivalName$field:String;
      
      private var rivalServerName$field:String;
      
      private var rivalAddScore$field:int;
      
      public function ChessPvpRecordMsg()
      {
         super();
      }
      
      public function removeRecordDate() : void
      {
         recordDate$field = null;
      }
      
      public function get hasRecordDate() : Boolean
      {
         return recordDate$field != null;
      }
      
      public function set recordDate(param1:String) : void
      {
         recordDate$field = param1;
      }
      
      public function get recordDate() : String
      {
         return recordDate$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeGroup() : void
      {
         hasField$0 &= 4294967293;
         group$field = new int();
      }
      
      public function get hasGroup() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set group(param1:int) : void
      {
         hasField$0 |= 2;
         group$field = param1;
      }
      
      public function get group() : int
      {
         return group$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
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
      
      public function removeAddScore() : void
      {
         hasField$0 &= 4294967291;
         addScore$field = new int();
      }
      
      public function get hasAddScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set addScore(param1:int) : void
      {
         hasField$0 |= 4;
         addScore$field = param1;
      }
      
      public function get addScore() : int
      {
         return addScore$field;
      }
      
      public function removeRivalGroup() : void
      {
         hasField$0 &= 4294967287;
         rivalGroup$field = new int();
      }
      
      public function get hasRivalGroup() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rivalGroup(param1:int) : void
      {
         hasField$0 |= 8;
         rivalGroup$field = param1;
      }
      
      public function get rivalGroup() : int
      {
         return rivalGroup$field;
      }
      
      public function removeRivalName() : void
      {
         rivalName$field = null;
      }
      
      public function get hasRivalName() : Boolean
      {
         return rivalName$field != null;
      }
      
      public function set rivalName(param1:String) : void
      {
         rivalName$field = param1;
      }
      
      public function get rivalName() : String
      {
         return rivalName$field;
      }
      
      public function removeRivalServerName() : void
      {
         rivalServerName$field = null;
      }
      
      public function get hasRivalServerName() : Boolean
      {
         return rivalServerName$field != null;
      }
      
      public function set rivalServerName(param1:String) : void
      {
         rivalServerName$field = param1;
      }
      
      public function get rivalServerName() : String
      {
         return rivalServerName$field;
      }
      
      public function removeRivalAddScore() : void
      {
         hasField$0 &= 4294967279;
         rivalAddScore$field = new int();
      }
      
      public function get hasRivalAddScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rivalAddScore(param1:int) : void
      {
         hasField$0 |= 16;
         rivalAddScore$field = param1;
      }
      
      public function get rivalAddScore() : int
      {
         return rivalAddScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRecordDate)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,recordDate$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasGroup)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,group$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasAddScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,addScore$field);
         }
         if(hasRivalGroup)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,rivalGroup$field);
         }
         if(hasRivalName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,rivalName$field);
         }
         if(hasRivalServerName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rivalServerName$field);
         }
         if(hasRivalAddScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,rivalAddScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.recordDate cannot be set twice.");
                  }
                  _loc5_++;
                  recordDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.group cannot be set twice.");
                  }
                  _loc11_++;
                  group = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.name cannot be set twice.");
                  }
                  _loc8_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.addScore cannot be set twice.");
                  }
                  _loc12_++;
                  addScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.rivalGroup cannot be set twice.");
                  }
                  _loc7_++;
                  rivalGroup = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.rivalName cannot be set twice.");
                  }
                  _loc10_++;
                  rivalName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.rivalServerName cannot be set twice.");
                  }
                  _loc3_++;
                  rivalServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRecordMsg.rivalAddScore cannot be set twice.");
                  }
                  _loc4_++;
                  rivalAddScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

