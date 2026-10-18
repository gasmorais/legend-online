package com.road.yishi.proto.stargazing
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StargazingOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var useItem$field:Boolean;
      
      private var mapIndex$field:int;
      
      private var fragmentIndex$field:int;
      
      private var mapItemId$field:int;
      
      private var infoMsg$field:StargazingInfoMsg;
      
      public function StargazingOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeUseItem() : void
      {
         hasField$0 &= 4294967291;
         useItem$field = new Boolean();
      }
      
      public function get hasUseItem() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set useItem(param1:Boolean) : void
      {
         hasField$0 |= 4;
         useItem$field = param1;
      }
      
      public function get useItem() : Boolean
      {
         return useItem$field;
      }
      
      public function removeMapIndex() : void
      {
         hasField$0 &= 4294967287;
         mapIndex$field = new int();
      }
      
      public function get hasMapIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set mapIndex(param1:int) : void
      {
         hasField$0 |= 8;
         mapIndex$field = param1;
      }
      
      public function get mapIndex() : int
      {
         return mapIndex$field;
      }
      
      public function removeFragmentIndex() : void
      {
         hasField$0 &= 4294967279;
         fragmentIndex$field = new int();
      }
      
      public function get hasFragmentIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fragmentIndex(param1:int) : void
      {
         hasField$0 |= 16;
         fragmentIndex$field = param1;
      }
      
      public function get fragmentIndex() : int
      {
         return fragmentIndex$field;
      }
      
      public function removeMapItemId() : void
      {
         hasField$0 &= 4294967263;
         mapItemId$field = new int();
      }
      
      public function get hasMapItemId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set mapItemId(param1:int) : void
      {
         hasField$0 |= 32;
         mapItemId$field = param1;
      }
      
      public function get mapItemId() : int
      {
         return mapItemId$field;
      }
      
      public function removeInfoMsg() : void
      {
         infoMsg$field = null;
      }
      
      public function get hasInfoMsg() : Boolean
      {
         return infoMsg$field != null;
      }
      
      public function set infoMsg(param1:StargazingInfoMsg) : void
      {
         infoMsg$field = param1;
      }
      
      public function get infoMsg() : StargazingInfoMsg
      {
         return infoMsg$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasUseItem)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,useItem$field);
         }
         if(hasMapIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,mapIndex$field);
         }
         if(hasFragmentIndex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fragmentIndex$field);
         }
         if(hasMapItemId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,mapItemId$field);
         }
         if(hasInfoMsg)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,infoMsg$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.useItem cannot be set twice.");
                  }
                  _loc5_++;
                  useItem = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.mapIndex cannot be set twice.");
                  }
                  _loc6_++;
                  mapIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.fragmentIndex cannot be set twice.");
                  }
                  _loc7_++;
                  fragmentIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.mapItemId cannot be set twice.");
                  }
                  _loc9_++;
                  mapItemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingOpMsg.infoMsg cannot be set twice.");
                  }
                  _loc3_++;
                  infoMsg = new StargazingInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,infoMsg);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

