package com.road.yishi.proto.retrieve
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RetrieveInfo extends Message implements IExternalizable
   {
      
      private var temp_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var temp_name$field:String;
      
      private var total_gold$field:int;
      
      private var total_point$field:int;
      
      private var retrieve_count$field:int;
      
      private var items$field:String;
      
      private var type$field:int;
      
      public function RetrieveInfo()
      {
         super();
      }
      
      public function removeTempType() : void
      {
         hasField$0 &= 4294967294;
         temp_type$field = new int();
      }
      
      public function get hasTempType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tempType(param1:int) : void
      {
         hasField$0 |= 1;
         temp_type$field = param1;
      }
      
      public function get tempType() : int
      {
         return temp_type$field;
      }
      
      public function removeTempName() : void
      {
         temp_name$field = null;
      }
      
      public function get hasTempName() : Boolean
      {
         return temp_name$field != null;
      }
      
      public function set tempName(param1:String) : void
      {
         temp_name$field = param1;
      }
      
      public function get tempName() : String
      {
         return temp_name$field;
      }
      
      public function removeTotalGold() : void
      {
         hasField$0 &= 4294967293;
         total_gold$field = new int();
      }
      
      public function get hasTotalGold() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalGold(param1:int) : void
      {
         hasField$0 |= 2;
         total_gold$field = param1;
      }
      
      public function get totalGold() : int
      {
         return total_gold$field;
      }
      
      public function removeTotalPoint() : void
      {
         hasField$0 &= 4294967291;
         total_point$field = new int();
      }
      
      public function get hasTotalPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalPoint(param1:int) : void
      {
         hasField$0 |= 4;
         total_point$field = param1;
      }
      
      public function get totalPoint() : int
      {
         return total_point$field;
      }
      
      public function removeRetrieveCount() : void
      {
         hasField$0 &= 4294967287;
         retrieve_count$field = new int();
      }
      
      public function get hasRetrieveCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set retrieveCount(param1:int) : void
      {
         hasField$0 |= 8;
         retrieve_count$field = param1;
      }
      
      public function get retrieveCount() : int
      {
         return retrieve_count$field;
      }
      
      public function removeItems() : void
      {
         items$field = null;
      }
      
      public function get hasItems() : Boolean
      {
         return items$field != null;
      }
      
      public function set items(param1:String) : void
      {
         items$field = param1;
      }
      
      public function get items() : String
      {
         return items$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTempType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,temp_type$field);
         }
         if(hasTempName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,temp_name$field);
         }
         if(hasTotalGold)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,total_gold$field);
         }
         if(hasTotalPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,total_point$field);
         }
         if(hasRetrieveCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,retrieve_count$field);
         }
         if(hasItems)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,items$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.tempType cannot be set twice.");
                  }
                  _loc6_++;
                  tempType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.tempName cannot be set twice.");
                  }
                  _loc4_++;
                  tempName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.totalGold cannot be set twice.");
                  }
                  _loc7_++;
                  totalGold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.totalPoint cannot be set twice.");
                  }
                  _loc3_++;
                  totalPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.retrieveCount cannot be set twice.");
                  }
                  _loc5_++;
                  retrieveCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.items cannot be set twice.");
                  }
                  _loc10_++;
                  items = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfo.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

