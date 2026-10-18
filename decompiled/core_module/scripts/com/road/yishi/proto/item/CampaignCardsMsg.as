package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignCardsMsg extends Message implements IExternalizable
   {
      
      private var scene_type$field:String;
      
      private var card_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_card_count$field:int;
      
      private var price$field:int;
      
      [ArrayElementType("com.road.yishi.proto.item.ItemInfoMsg")]
      public var dropItems:Array = [];
      
      public function CampaignCardsMsg()
      {
         super();
      }
      
      public function removeSceneType() : void
      {
         scene_type$field = null;
      }
      
      public function get hasSceneType() : Boolean
      {
         return scene_type$field != null;
      }
      
      public function set sceneType(param1:String) : void
      {
         scene_type$field = param1;
      }
      
      public function get sceneType() : String
      {
         return scene_type$field;
      }
      
      public function removeCardCount() : void
      {
         hasField$0 &= 4294967294;
         card_count$field = new int();
      }
      
      public function get hasCardCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set cardCount(param1:int) : void
      {
         hasField$0 |= 1;
         card_count$field = param1;
      }
      
      public function get cardCount() : int
      {
         return card_count$field;
      }
      
      public function removePayCardCount() : void
      {
         hasField$0 &= 4294967293;
         pay_card_count$field = new int();
      }
      
      public function get hasPayCardCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payCardCount(param1:int) : void
      {
         hasField$0 |= 2;
         pay_card_count$field = param1;
      }
      
      public function get payCardCount() : int
      {
         return pay_card_count$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967291;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 4;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSceneType)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,scene_type$field);
         }
         if(hasCardCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,card_count$field);
         }
         if(hasPayCardCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_card_count$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         _loc2_ = 0;
         while(_loc2_ < dropItems.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,dropItems[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:ItemInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignCardsMsg.sceneType cannot be set twice.");
                  }
                  _loc4_++;
                  sceneType = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignCardsMsg.cardCount cannot be set twice.");
                  }
                  _loc8_++;
                  cardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignCardsMsg.payCardCount cannot be set twice.");
                  }
                  _loc6_++;
                  payCardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignCardsMsg.price cannot be set twice.");
                  }
                  _loc3_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc7_ = new ItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  dropItems.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

