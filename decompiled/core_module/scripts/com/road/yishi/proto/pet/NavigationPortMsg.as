package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NavigationPortMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var cd$field:Int64;
      
      private var shippingBoatId$field:String;
      
      private var taskId1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var taskId2$field:int;
      
      private var taskId3$field:int;
      
      private var taskId4$field:int;
      
      private var taskId5$field:int;
      
      private var taskId6$field:int;
      
      private var taskNum1$field:int;
      
      private var taskNum2$field:int;
      
      private var taskNum3$field:int;
      
      private var taskNum4$field:int;
      
      private var taskNum5$field:int;
      
      private var taskNum6$field:int;
      
      private var selectedTask1$field:Boolean;
      
      private var selectedTask2$field:Boolean;
      
      private var selectedTask3$field:Boolean;
      
      private var selectedTask4$field:Boolean;
      
      private var selectedTask5$field:Boolean;
      
      private var selectedTask6$field:Boolean;
      
      private var payBusinessNum$field:int;
      
      private var grades$field:int;
      
      public function NavigationPortMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         id$field = null;
      }
      
      public function get hasId() : Boolean
      {
         return id$field != null;
      }
      
      public function set id(param1:String) : void
      {
         id$field = param1;
      }
      
      public function get id() : String
      {
         return id$field;
      }
      
      public function removeCd() : void
      {
         cd$field = null;
      }
      
      public function get hasCd() : Boolean
      {
         return cd$field != null;
      }
      
      public function set cd(param1:Int64) : void
      {
         cd$field = param1;
      }
      
      public function get cd() : Int64
      {
         return cd$field;
      }
      
      public function removeShippingBoatId() : void
      {
         shippingBoatId$field = null;
      }
      
      public function get hasShippingBoatId() : Boolean
      {
         return shippingBoatId$field != null;
      }
      
      public function set shippingBoatId(param1:String) : void
      {
         shippingBoatId$field = param1;
      }
      
      public function get shippingBoatId() : String
      {
         return shippingBoatId$field;
      }
      
      public function removeTaskId1() : void
      {
         hasField$0 &= 4294967294;
         taskId1$field = new int();
      }
      
      public function get hasTaskId1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set taskId1(param1:int) : void
      {
         hasField$0 |= 1;
         taskId1$field = param1;
      }
      
      public function get taskId1() : int
      {
         return taskId1$field;
      }
      
      public function removeTaskId2() : void
      {
         hasField$0 &= 4294967293;
         taskId2$field = new int();
      }
      
      public function get hasTaskId2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set taskId2(param1:int) : void
      {
         hasField$0 |= 2;
         taskId2$field = param1;
      }
      
      public function get taskId2() : int
      {
         return taskId2$field;
      }
      
      public function removeTaskId3() : void
      {
         hasField$0 &= 4294967291;
         taskId3$field = new int();
      }
      
      public function get hasTaskId3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set taskId3(param1:int) : void
      {
         hasField$0 |= 4;
         taskId3$field = param1;
      }
      
      public function get taskId3() : int
      {
         return taskId3$field;
      }
      
      public function removeTaskId4() : void
      {
         hasField$0 &= 4294967287;
         taskId4$field = new int();
      }
      
      public function get hasTaskId4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set taskId4(param1:int) : void
      {
         hasField$0 |= 8;
         taskId4$field = param1;
      }
      
      public function get taskId4() : int
      {
         return taskId4$field;
      }
      
      public function removeTaskId5() : void
      {
         hasField$0 &= 4294967279;
         taskId5$field = new int();
      }
      
      public function get hasTaskId5() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set taskId5(param1:int) : void
      {
         hasField$0 |= 16;
         taskId5$field = param1;
      }
      
      public function get taskId5() : int
      {
         return taskId5$field;
      }
      
      public function removeTaskId6() : void
      {
         hasField$0 &= 4294967263;
         taskId6$field = new int();
      }
      
      public function get hasTaskId6() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set taskId6(param1:int) : void
      {
         hasField$0 |= 32;
         taskId6$field = param1;
      }
      
      public function get taskId6() : int
      {
         return taskId6$field;
      }
      
      public function removeTaskNum1() : void
      {
         hasField$0 &= 4294967231;
         taskNum1$field = new int();
      }
      
      public function get hasTaskNum1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set taskNum1(param1:int) : void
      {
         hasField$0 |= 64;
         taskNum1$field = param1;
      }
      
      public function get taskNum1() : int
      {
         return taskNum1$field;
      }
      
      public function removeTaskNum2() : void
      {
         hasField$0 &= 4294967167;
         taskNum2$field = new int();
      }
      
      public function get hasTaskNum2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set taskNum2(param1:int) : void
      {
         hasField$0 |= 128;
         taskNum2$field = param1;
      }
      
      public function get taskNum2() : int
      {
         return taskNum2$field;
      }
      
      public function removeTaskNum3() : void
      {
         hasField$0 &= 4294967039;
         taskNum3$field = new int();
      }
      
      public function get hasTaskNum3() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set taskNum3(param1:int) : void
      {
         hasField$0 |= 256;
         taskNum3$field = param1;
      }
      
      public function get taskNum3() : int
      {
         return taskNum3$field;
      }
      
      public function removeTaskNum4() : void
      {
         hasField$0 &= 4294966783;
         taskNum4$field = new int();
      }
      
      public function get hasTaskNum4() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set taskNum4(param1:int) : void
      {
         hasField$0 |= 512;
         taskNum4$field = param1;
      }
      
      public function get taskNum4() : int
      {
         return taskNum4$field;
      }
      
      public function removeTaskNum5() : void
      {
         hasField$0 &= 4294966271;
         taskNum5$field = new int();
      }
      
      public function get hasTaskNum5() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set taskNum5(param1:int) : void
      {
         hasField$0 |= 1024;
         taskNum5$field = param1;
      }
      
      public function get taskNum5() : int
      {
         return taskNum5$field;
      }
      
      public function removeTaskNum6() : void
      {
         hasField$0 &= 4294965247;
         taskNum6$field = new int();
      }
      
      public function get hasTaskNum6() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set taskNum6(param1:int) : void
      {
         hasField$0 |= 2048;
         taskNum6$field = param1;
      }
      
      public function get taskNum6() : int
      {
         return taskNum6$field;
      }
      
      public function removeSelectedTask1() : void
      {
         hasField$0 &= 4294963199;
         selectedTask1$field = new Boolean();
      }
      
      public function get hasSelectedTask1() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set selectedTask1(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         selectedTask1$field = param1;
      }
      
      public function get selectedTask1() : Boolean
      {
         return selectedTask1$field;
      }
      
      public function removeSelectedTask2() : void
      {
         hasField$0 &= 4294959103;
         selectedTask2$field = new Boolean();
      }
      
      public function get hasSelectedTask2() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set selectedTask2(param1:Boolean) : void
      {
         hasField$0 |= 8192;
         selectedTask2$field = param1;
      }
      
      public function get selectedTask2() : Boolean
      {
         return selectedTask2$field;
      }
      
      public function removeSelectedTask3() : void
      {
         hasField$0 &= 4294950911;
         selectedTask3$field = new Boolean();
      }
      
      public function get hasSelectedTask3() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set selectedTask3(param1:Boolean) : void
      {
         hasField$0 |= 16384;
         selectedTask3$field = param1;
      }
      
      public function get selectedTask3() : Boolean
      {
         return selectedTask3$field;
      }
      
      public function removeSelectedTask4() : void
      {
         hasField$0 &= 4294934527;
         selectedTask4$field = new Boolean();
      }
      
      public function get hasSelectedTask4() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set selectedTask4(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         selectedTask4$field = param1;
      }
      
      public function get selectedTask4() : Boolean
      {
         return selectedTask4$field;
      }
      
      public function removeSelectedTask5() : void
      {
         hasField$0 &= 4294901759;
         selectedTask5$field = new Boolean();
      }
      
      public function get hasSelectedTask5() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set selectedTask5(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         selectedTask5$field = param1;
      }
      
      public function get selectedTask5() : Boolean
      {
         return selectedTask5$field;
      }
      
      public function removeSelectedTask6() : void
      {
         hasField$0 &= 4294836223;
         selectedTask6$field = new Boolean();
      }
      
      public function get hasSelectedTask6() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set selectedTask6(param1:Boolean) : void
      {
         hasField$0 |= 131072;
         selectedTask6$field = param1;
      }
      
      public function get selectedTask6() : Boolean
      {
         return selectedTask6$field;
      }
      
      public function removePayBusinessNum() : void
      {
         hasField$0 &= 4294705151;
         payBusinessNum$field = new int();
      }
      
      public function get hasPayBusinessNum() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set payBusinessNum(param1:int) : void
      {
         hasField$0 |= 262144;
         payBusinessNum$field = param1;
      }
      
      public function get payBusinessNum() : int
      {
         return payBusinessNum$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294443007;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 524288;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,id$field);
         }
         if(hasCd)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,cd$field);
         }
         if(hasShippingBoatId)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,shippingBoatId$field);
         }
         if(hasTaskId1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,taskId1$field);
         }
         if(hasTaskId2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,taskId2$field);
         }
         if(hasTaskId3)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,taskId3$field);
         }
         if(hasTaskId4)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,taskId4$field);
         }
         if(hasTaskId5)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,taskId5$field);
         }
         if(hasTaskId6)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,taskId6$field);
         }
         if(hasTaskNum1)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,taskNum1$field);
         }
         if(hasTaskNum2)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,taskNum2$field);
         }
         if(hasTaskNum3)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,taskNum3$field);
         }
         if(hasTaskNum4)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,taskNum4$field);
         }
         if(hasTaskNum5)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,taskNum5$field);
         }
         if(hasTaskNum6)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,taskNum6$field);
         }
         if(hasSelectedTask1)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,selectedTask1$field);
         }
         if(hasSelectedTask2)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,selectedTask2$field);
         }
         if(hasSelectedTask3)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,selectedTask3$field);
         }
         if(hasSelectedTask4)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_BOOL(param1,selectedTask4$field);
         }
         if(hasSelectedTask5)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_BOOL(param1,selectedTask5$field);
         }
         if(hasSelectedTask6)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_BOOL(param1,selectedTask6$field);
         }
         if(hasPayBusinessNum)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,payBusinessNum$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc18_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc16_:uint = 0;
         var _loc24_:uint = 0;
         var _loc8_:uint = 0;
         var _loc19_:uint = 0;
         var _loc22_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc17_:uint = 0;
         var _loc25_:uint = 0;
         var _loc9_:uint = 0;
         var _loc20_:uint = 0;
         var _loc23_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc21_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc26_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.id cannot be set twice.");
                  }
                  _loc18_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.cd cannot be set twice.");
                  }
                  _loc7_++;
                  cd = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.shippingBoatId cannot be set twice.");
                  }
                  _loc10_++;
                  shippingBoatId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskId1 cannot be set twice.");
                  }
                  _loc16_++;
                  taskId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskId2 cannot be set twice.");
                  }
                  _loc24_++;
                  taskId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskId3 cannot be set twice.");
                  }
                  _loc8_++;
                  taskId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskId4 cannot be set twice.");
                  }
                  _loc19_++;
                  taskId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskId5 cannot be set twice.");
                  }
                  _loc22_++;
                  taskId5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskId6 cannot be set twice.");
                  }
                  _loc14_++;
                  taskId6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskNum1 cannot be set twice.");
                  }
                  _loc5_++;
                  taskNum1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskNum2 cannot be set twice.");
                  }
                  _loc17_++;
                  taskNum2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskNum3 cannot be set twice.");
                  }
                  _loc25_++;
                  taskNum3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskNum4 cannot be set twice.");
                  }
                  _loc9_++;
                  taskNum4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskNum5 cannot be set twice.");
                  }
                  _loc20_++;
                  taskNum5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.taskNum6 cannot be set twice.");
                  }
                  _loc23_++;
                  taskNum6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.selectedTask1 cannot be set twice.");
                  }
                  _loc3_++;
                  selectedTask1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.selectedTask2 cannot be set twice.");
                  }
                  _loc11_++;
                  selectedTask2 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.selectedTask3 cannot be set twice.");
                  }
                  _loc21_++;
                  selectedTask3 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 19:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.selectedTask4 cannot be set twice.");
                  }
                  _loc6_++;
                  selectedTask4 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 20:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.selectedTask5 cannot be set twice.");
                  }
                  _loc12_++;
                  selectedTask5 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 21:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.selectedTask6 cannot be set twice.");
                  }
                  _loc26_++;
                  selectedTask6 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 22:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.payBusinessNum cannot be set twice.");
                  }
                  _loc4_++;
                  payBusinessNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationPortMsg.grades cannot be set twice.");
                  }
                  _loc15_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

