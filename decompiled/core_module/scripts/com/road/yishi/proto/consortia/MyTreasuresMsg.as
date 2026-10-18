package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MyTreasuresMsg extends Message implements IExternalizable
   {
      
      private var treasureId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var openTime$field:String;
      
      private var treasureTemplateId$field:int;
      
      private var helperName$field:String;
      
      private var requestHelpCount$field:int;
      
      private var status$field:int;
      
      public function MyTreasuresMsg()
      {
         super();
      }
      
      public function removeTreasureId() : void
      {
         hasField$0 &= 4294967294;
         treasureId$field = new int();
      }
      
      public function get hasTreasureId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set treasureId(param1:int) : void
      {
         hasField$0 |= 1;
         treasureId$field = param1;
      }
      
      public function get treasureId() : int
      {
         return treasureId$field;
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeTreasureTemplateId() : void
      {
         hasField$0 &= 4294967293;
         treasureTemplateId$field = new int();
      }
      
      public function get hasTreasureTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set treasureTemplateId(param1:int) : void
      {
         hasField$0 |= 2;
         treasureTemplateId$field = param1;
      }
      
      public function get treasureTemplateId() : int
      {
         return treasureTemplateId$field;
      }
      
      public function removeHelperName() : void
      {
         helperName$field = null;
      }
      
      public function get hasHelperName() : Boolean
      {
         return helperName$field != null;
      }
      
      public function set helperName(param1:String) : void
      {
         helperName$field = param1;
      }
      
      public function get helperName() : String
      {
         return helperName$field;
      }
      
      public function removeRequestHelpCount() : void
      {
         hasField$0 &= 4294967291;
         requestHelpCount$field = new int();
      }
      
      public function get hasRequestHelpCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set requestHelpCount(param1:int) : void
      {
         hasField$0 |= 4;
         requestHelpCount$field = param1;
      }
      
      public function get requestHelpCount() : int
      {
         return requestHelpCount$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967287;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 8;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTreasureId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,treasureId$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasTreasureTemplateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,treasureTemplateId$field);
         }
         if(hasHelperName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,helperName$field);
         }
         if(hasRequestHelpCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,requestHelpCount$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
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
                     throw new IOError("Bad data format: MyTreasuresMsg.treasureId cannot be set twice.");
                  }
                  _loc3_++;
                  treasureId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MyTreasuresMsg.openTime cannot be set twice.");
                  }
                  _loc8_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MyTreasuresMsg.treasureTemplateId cannot be set twice.");
                  }
                  _loc4_++;
                  treasureTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MyTreasuresMsg.helperName cannot be set twice.");
                  }
                  _loc6_++;
                  helperName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MyTreasuresMsg.requestHelpCount cannot be set twice.");
                  }
                  _loc5_++;
                  requestHelpCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MyTreasuresMsg.status cannot be set twice.");
                  }
                  _loc9_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

