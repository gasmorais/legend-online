package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignNpcMoveMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var start_x$field:int;
      
      private var start_y$field:int;
      
      private var end_x$field:int;
      
      private var end_y$field:int;
      
      private var show_time$field:String;
      
      private var uu_id$field:String;
      
      private var center_x$field:int;
      
      private var center_y$field:int;
      
      private var isMove$field:Boolean;
      
      public function CampaignNpcMoveMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeStartX() : void
      {
         hasField$0 &= 4294967293;
         start_x$field = new int();
      }
      
      public function get hasStartX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set startX(param1:int) : void
      {
         hasField$0 |= 2;
         start_x$field = param1;
      }
      
      public function get startX() : int
      {
         return start_x$field;
      }
      
      public function removeStartY() : void
      {
         hasField$0 &= 4294967291;
         start_y$field = new int();
      }
      
      public function get hasStartY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set startY(param1:int) : void
      {
         hasField$0 |= 4;
         start_y$field = param1;
      }
      
      public function get startY() : int
      {
         return start_y$field;
      }
      
      public function removeEndX() : void
      {
         hasField$0 &= 4294967287;
         end_x$field = new int();
      }
      
      public function get hasEndX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endX(param1:int) : void
      {
         hasField$0 |= 8;
         end_x$field = param1;
      }
      
      public function get endX() : int
      {
         return end_x$field;
      }
      
      public function removeEndY() : void
      {
         hasField$0 &= 4294967279;
         end_y$field = new int();
      }
      
      public function get hasEndY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set endY(param1:int) : void
      {
         hasField$0 |= 16;
         end_y$field = param1;
      }
      
      public function get endY() : int
      {
         return end_y$field;
      }
      
      public function removeShowTime() : void
      {
         show_time$field = null;
      }
      
      public function get hasShowTime() : Boolean
      {
         return show_time$field != null;
      }
      
      public function set showTime(param1:String) : void
      {
         show_time$field = param1;
      }
      
      public function get showTime() : String
      {
         return show_time$field;
      }
      
      public function removeUuId() : void
      {
         uu_id$field = null;
      }
      
      public function get hasUuId() : Boolean
      {
         return uu_id$field != null;
      }
      
      public function set uuId(param1:String) : void
      {
         uu_id$field = param1;
      }
      
      public function get uuId() : String
      {
         return uu_id$field;
      }
      
      public function removeCenterX() : void
      {
         hasField$0 &= 4294967263;
         center_x$field = new int();
      }
      
      public function get hasCenterX() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set centerX(param1:int) : void
      {
         hasField$0 |= 32;
         center_x$field = param1;
      }
      
      public function get centerX() : int
      {
         return center_x$field;
      }
      
      public function removeCenterY() : void
      {
         hasField$0 &= 4294967231;
         center_y$field = new int();
      }
      
      public function get hasCenterY() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set centerY(param1:int) : void
      {
         hasField$0 |= 64;
         center_y$field = param1;
      }
      
      public function get centerY() : int
      {
         return center_y$field;
      }
      
      public function removeIsMove() : void
      {
         hasField$0 &= 4294967167;
         isMove$field = new Boolean();
      }
      
      public function get hasIsMove() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isMove(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isMove$field = param1;
      }
      
      public function get isMove() : Boolean
      {
         return isMove$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasStartX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,start_x$field);
         }
         if(hasStartY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,start_y$field);
         }
         if(hasEndX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,end_x$field);
         }
         if(hasEndY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,end_y$field);
         }
         if(hasShowTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,show_time$field);
         }
         if(hasUuId)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,uu_id$field);
         }
         if(hasCenterX)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,center_x$field);
         }
         if(hasCenterY)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,center_y$field);
         }
         if(hasIsMove)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isMove$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.nodeId cannot be set twice.");
                  }
                  _loc6_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.startX cannot be set twice.");
                  }
                  _loc7_++;
                  startX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.startY cannot be set twice.");
                  }
                  _loc10_++;
                  startY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.endX cannot be set twice.");
                  }
                  _loc4_++;
                  endX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.endY cannot be set twice.");
                  }
                  _loc11_++;
                  endY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.showTime cannot be set twice.");
                  }
                  _loc5_++;
                  showTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.uuId cannot be set twice.");
                  }
                  _loc13_++;
                  uuId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.centerX cannot be set twice.");
                  }
                  _loc3_++;
                  centerX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.centerY cannot be set twice.");
                  }
                  _loc8_++;
                  centerY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNpcMoveMsg.isMove cannot be set twice.");
                  }
                  _loc9_++;
                  isMove = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

