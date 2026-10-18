package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaAltarOpenRspMsg extends Message implements IExternalizable
   {
      
      private var consortia_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chairman_id$field:int;
      
      private var chairman_name$field:String;
      
      private var result$field:int;
      
      private var altar_date$field:String;
      
      private var pop$field:Boolean;
      
      public function ConsortiaAltarOpenRspMsg()
      {
         super();
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeChairmanId() : void
      {
         hasField$0 &= 4294967293;
         chairman_id$field = new int();
      }
      
      public function get hasChairmanId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chairmanId(param1:int) : void
      {
         hasField$0 |= 2;
         chairman_id$field = param1;
      }
      
      public function get chairmanId() : int
      {
         return chairman_id$field;
      }
      
      public function removeChairmanName() : void
      {
         chairman_name$field = null;
      }
      
      public function get hasChairmanName() : Boolean
      {
         return chairman_name$field != null;
      }
      
      public function set chairmanName(param1:String) : void
      {
         chairman_name$field = param1;
      }
      
      public function get chairmanName() : String
      {
         return chairman_name$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeAltarDate() : void
      {
         altar_date$field = null;
      }
      
      public function get hasAltarDate() : Boolean
      {
         return altar_date$field != null;
      }
      
      public function set altarDate(param1:String) : void
      {
         altar_date$field = param1;
      }
      
      public function get altarDate() : String
      {
         return altar_date$field;
      }
      
      public function removePop() : void
      {
         hasField$0 &= 4294967287;
         pop$field = new Boolean();
      }
      
      public function get hasPop() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pop(param1:Boolean) : void
      {
         hasField$0 |= 8;
         pop$field = param1;
      }
      
      public function get pop() : Boolean
      {
         return pop$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasChairmanId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chairman_id$field);
         }
         if(hasChairmanName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,chairman_name$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasAltarDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,altar_date$field);
         }
         if(hasPop)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,pop$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenRspMsg.consortiaId cannot be set twice.");
                  }
                  _loc3_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenRspMsg.chairmanId cannot be set twice.");
                  }
                  _loc4_++;
                  chairmanId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenRspMsg.chairmanName cannot be set twice.");
                  }
                  _loc8_++;
                  chairmanName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenRspMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenRspMsg.altarDate cannot be set twice.");
                  }
                  _loc5_++;
                  altarDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenRspMsg.pop cannot be set twice.");
                  }
                  _loc9_++;
                  pop = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

