package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaLinkRspMsg extends Message implements IExternalizable
   {
      
      private var consortia_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortia_name$field:String;
      
      private var creator_name$field:String;
      
      private var levels$field:int;
      
      private var Offer$field:int;
      
      private var current_count$field:int;
      
      private var honor$field:int;
      
      private var description$field:String;
      
      public function ConsortiaLinkRspMsg()
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
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeCreatorName() : void
      {
         creator_name$field = null;
      }
      
      public function get hasCreatorName() : Boolean
      {
         return creator_name$field != null;
      }
      
      public function set creatorName(param1:String) : void
      {
         creator_name$field = param1;
      }
      
      public function get creatorName() : String
      {
         return creator_name$field;
      }
      
      public function removeLevels() : void
      {
         hasField$0 &= 4294967293;
         levels$field = new int();
      }
      
      public function get hasLevels() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set levels(param1:int) : void
      {
         hasField$0 |= 2;
         levels$field = param1;
      }
      
      public function get levels() : int
      {
         return levels$field;
      }
      
      public function removeOffer() : void
      {
         hasField$0 &= 4294967291;
         Offer$field = new int();
      }
      
      public function get hasOffer() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set offer(param1:int) : void
      {
         hasField$0 |= 4;
         Offer$field = param1;
      }
      
      public function get offer() : int
      {
         return Offer$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4294967287;
         current_count$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 8;
         current_count$field = param1;
      }
      
      public function get currentCount() : int
      {
         return current_count$field;
      }
      
      public function removeHonor() : void
      {
         hasField$0 &= 4294967279;
         honor$field = new int();
      }
      
      public function get hasHonor() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set honor(param1:int) : void
      {
         hasField$0 |= 16;
         honor$field = param1;
      }
      
      public function get honor() : int
      {
         return honor$field;
      }
      
      public function removeDescription() : void
      {
         description$field = null;
      }
      
      public function get hasDescription() : Boolean
      {
         return description$field != null;
      }
      
      public function set description(param1:String) : void
      {
         description$field = param1;
      }
      
      public function get description() : String
      {
         return description$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasCreatorName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,creator_name$field);
         }
         if(hasLevels)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,levels$field);
         }
         if(hasOffer)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,Offer$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,current_count$field);
         }
         if(hasHonor)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,honor$field);
         }
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.consortiaId cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.creatorName cannot be set twice.");
                  }
                  _loc8_++;
                  creatorName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.levels cannot be set twice.");
                  }
                  _loc11_++;
                  levels = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.offer cannot be set twice.");
                  }
                  _loc9_++;
                  offer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.currentCount cannot be set twice.");
                  }
                  _loc6_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.honor cannot be set twice.");
                  }
                  _loc3_++;
                  honor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaLinkRspMsg.description cannot be set twice.");
                  }
                  _loc7_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

