package com.road.yishi.proto.eclipticpalace
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EclipticPalaceMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var recover_count_down$field:int;
      
      private var current_spirit$field:int;
      
      private var current_layer$field:int;
      
      private var decline_count_down$field:int;
      
      private var selected_route$field:int;
      
      private var route1$field:EclipticPalaceRouteMsg;
      
      private var route2$field:EclipticPalaceRouteMsg;
      
      private var route3$field:EclipticPalaceRouteMsg;
      
      private var pop_event$field:Boolean;
      
      public function EclipticPalaceMsg()
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
      
      public function removeRecoverCountDown() : void
      {
         hasField$0 &= 4294967293;
         recover_count_down$field = new int();
      }
      
      public function get hasRecoverCountDown() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set recoverCountDown(param1:int) : void
      {
         hasField$0 |= 2;
         recover_count_down$field = param1;
      }
      
      public function get recoverCountDown() : int
      {
         return recover_count_down$field;
      }
      
      public function removeCurrentSpirit() : void
      {
         hasField$0 &= 4294967291;
         current_spirit$field = new int();
      }
      
      public function get hasCurrentSpirit() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentSpirit(param1:int) : void
      {
         hasField$0 |= 4;
         current_spirit$field = param1;
      }
      
      public function get currentSpirit() : int
      {
         return current_spirit$field;
      }
      
      public function removeCurrentLayer() : void
      {
         hasField$0 &= 4294967287;
         current_layer$field = new int();
      }
      
      public function get hasCurrentLayer() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currentLayer(param1:int) : void
      {
         hasField$0 |= 8;
         current_layer$field = param1;
      }
      
      public function get currentLayer() : int
      {
         return current_layer$field;
      }
      
      public function removeDeclineCountDown() : void
      {
         hasField$0 &= 4294967279;
         decline_count_down$field = new int();
      }
      
      public function get hasDeclineCountDown() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set declineCountDown(param1:int) : void
      {
         hasField$0 |= 16;
         decline_count_down$field = param1;
      }
      
      public function get declineCountDown() : int
      {
         return decline_count_down$field;
      }
      
      public function removeSelectedRoute() : void
      {
         hasField$0 &= 4294967263;
         selected_route$field = new int();
      }
      
      public function get hasSelectedRoute() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set selectedRoute(param1:int) : void
      {
         hasField$0 |= 32;
         selected_route$field = param1;
      }
      
      public function get selectedRoute() : int
      {
         return selected_route$field;
      }
      
      public function removeRoute1() : void
      {
         route1$field = null;
      }
      
      public function get hasRoute1() : Boolean
      {
         return route1$field != null;
      }
      
      public function set route1(param1:EclipticPalaceRouteMsg) : void
      {
         route1$field = param1;
      }
      
      public function get route1() : EclipticPalaceRouteMsg
      {
         return route1$field;
      }
      
      public function removeRoute2() : void
      {
         route2$field = null;
      }
      
      public function get hasRoute2() : Boolean
      {
         return route2$field != null;
      }
      
      public function set route2(param1:EclipticPalaceRouteMsg) : void
      {
         route2$field = param1;
      }
      
      public function get route2() : EclipticPalaceRouteMsg
      {
         return route2$field;
      }
      
      public function removeRoute3() : void
      {
         route3$field = null;
      }
      
      public function get hasRoute3() : Boolean
      {
         return route3$field != null;
      }
      
      public function set route3(param1:EclipticPalaceRouteMsg) : void
      {
         route3$field = param1;
      }
      
      public function get route3() : EclipticPalaceRouteMsg
      {
         return route3$field;
      }
      
      public function removePopEvent() : void
      {
         hasField$0 &= 4294967231;
         pop_event$field = new Boolean();
      }
      
      public function get hasPopEvent() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set popEvent(param1:Boolean) : void
      {
         hasField$0 |= 64;
         pop_event$field = param1;
      }
      
      public function get popEvent() : Boolean
      {
         return pop_event$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasRecoverCountDown)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,recover_count_down$field);
         }
         if(hasCurrentSpirit)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,current_spirit$field);
         }
         if(hasCurrentLayer)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,current_layer$field);
         }
         if(hasDeclineCountDown)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,decline_count_down$field);
         }
         if(hasSelectedRoute)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,selected_route$field);
         }
         if(hasRoute1)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,route1$field);
         }
         if(hasRoute2)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,route2$field);
         }
         if(hasRoute3)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,route3$field);
         }
         if(hasPopEvent)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,pop_event$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.op cannot be set twice.");
                  }
                  _loc12_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.recoverCountDown cannot be set twice.");
                  }
                  _loc3_++;
                  recoverCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.currentSpirit cannot be set twice.");
                  }
                  _loc9_++;
                  currentSpirit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.currentLayer cannot be set twice.");
                  }
                  _loc10_++;
                  currentLayer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.declineCountDown cannot be set twice.");
                  }
                  _loc13_++;
                  declineCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.selectedRoute cannot be set twice.");
                  }
                  _loc4_++;
                  selectedRoute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.route1 cannot be set twice.");
                  }
                  _loc5_++;
                  route1 = new EclipticPalaceRouteMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,route1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.route2 cannot be set twice.");
                  }
                  _loc6_++;
                  route2 = new EclipticPalaceRouteMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,route2);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.route3 cannot be set twice.");
                  }
                  _loc8_++;
                  route3 = new EclipticPalaceRouteMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,route3);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceMsg.popEvent cannot be set twice.");
                  }
                  _loc7_++;
                  popEvent = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

