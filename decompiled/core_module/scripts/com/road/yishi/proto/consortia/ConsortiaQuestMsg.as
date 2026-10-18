package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaQuestMsg extends Message implements IExternalizable
   {
      
      private var quest_site$field:ByteArray;
      
      [ArrayElementType("com.road.yishi.proto.consortia.ConsortiaConditionMsg")]
      public var conditionList:Array = [];
      
      public function ConsortiaQuestMsg()
      {
         super();
      }
      
      public function removeQuestSite() : void
      {
         quest_site$field = null;
      }
      
      public function get hasQuestSite() : Boolean
      {
         return quest_site$field != null;
      }
      
      public function set questSite(param1:ByteArray) : void
      {
         quest_site$field = param1;
      }
      
      public function get questSite() : ByteArray
      {
         return quest_site$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasQuestSite)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_BYTES(param1,quest_site$field);
         }
         _loc2_ = 0;
         while(_loc2_ < conditionList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,conditionList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:ConsortiaConditionMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaQuestMsg.questSite cannot be set twice.");
                  }
                  _loc3_++;
                  questSite = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 1:
                  _loc4_ = new ConsortiaConditionMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  conditionList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

