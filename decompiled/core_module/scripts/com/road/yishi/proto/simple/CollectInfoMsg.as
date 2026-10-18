package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CollectInfoMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var intParam1$field:int;
      
      private var intParam2$field:int;
      
      private var intParam3$field:int;
      
      private var intParam4$field:int;
      
      private var strParam1$field:String;
      
      private var strParam2$field:String;
      
      private var strParam3$field:String;
      
      private var strParam4$field:String;
      
      private var browser$field:String;
      
      private var flashVersion$field:String;
      
      private var screen$field:String;
      
      private var sys$field:String;
      
      private var is64Bit$field:Boolean;
      
      private var stage3D$field:String;
      
      private var note_book$field:String;
      
      private var memory$field:String;
      
      private var cpu$field:String;
      
      private var display0$field:String;
      
      private var GPUVersion0$field:String;
      
      private var GPUDate0$field:String;
      
      private var display1$field:String;
      
      private var GPUVersion1$field:String;
      
      private var GPUDate1$field:String;
      
      public function CollectInfoMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeIntParam1() : void
      {
         hasField$0 &= 4294967293;
         intParam1$field = new int();
      }
      
      public function get hasIntParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set intParam1(param1:int) : void
      {
         hasField$0 |= 2;
         intParam1$field = param1;
      }
      
      public function get intParam1() : int
      {
         return intParam1$field;
      }
      
      public function removeIntParam2() : void
      {
         hasField$0 &= 4294967291;
         intParam2$field = new int();
      }
      
      public function get hasIntParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set intParam2(param1:int) : void
      {
         hasField$0 |= 4;
         intParam2$field = param1;
      }
      
      public function get intParam2() : int
      {
         return intParam2$field;
      }
      
      public function removeIntParam3() : void
      {
         hasField$0 &= 4294967287;
         intParam3$field = new int();
      }
      
      public function get hasIntParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set intParam3(param1:int) : void
      {
         hasField$0 |= 8;
         intParam3$field = param1;
      }
      
      public function get intParam3() : int
      {
         return intParam3$field;
      }
      
      public function removeIntParam4() : void
      {
         hasField$0 &= 4294967279;
         intParam4$field = new int();
      }
      
      public function get hasIntParam4() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set intParam4(param1:int) : void
      {
         hasField$0 |= 16;
         intParam4$field = param1;
      }
      
      public function get intParam4() : int
      {
         return intParam4$field;
      }
      
      public function removeStrParam1() : void
      {
         strParam1$field = null;
      }
      
      public function get hasStrParam1() : Boolean
      {
         return strParam1$field != null;
      }
      
      public function set strParam1(param1:String) : void
      {
         strParam1$field = param1;
      }
      
      public function get strParam1() : String
      {
         return strParam1$field;
      }
      
      public function removeStrParam2() : void
      {
         strParam2$field = null;
      }
      
      public function get hasStrParam2() : Boolean
      {
         return strParam2$field != null;
      }
      
      public function set strParam2(param1:String) : void
      {
         strParam2$field = param1;
      }
      
      public function get strParam2() : String
      {
         return strParam2$field;
      }
      
      public function removeStrParam3() : void
      {
         strParam3$field = null;
      }
      
      public function get hasStrParam3() : Boolean
      {
         return strParam3$field != null;
      }
      
      public function set strParam3(param1:String) : void
      {
         strParam3$field = param1;
      }
      
      public function get strParam3() : String
      {
         return strParam3$field;
      }
      
      public function removeStrParam4() : void
      {
         strParam4$field = null;
      }
      
      public function get hasStrParam4() : Boolean
      {
         return strParam4$field != null;
      }
      
      public function set strParam4(param1:String) : void
      {
         strParam4$field = param1;
      }
      
      public function get strParam4() : String
      {
         return strParam4$field;
      }
      
      public function removeBrowser() : void
      {
         browser$field = null;
      }
      
      public function get hasBrowser() : Boolean
      {
         return browser$field != null;
      }
      
      public function set browser(param1:String) : void
      {
         browser$field = param1;
      }
      
      public function get browser() : String
      {
         return browser$field;
      }
      
      public function removeFlashVersion() : void
      {
         flashVersion$field = null;
      }
      
      public function get hasFlashVersion() : Boolean
      {
         return flashVersion$field != null;
      }
      
      public function set flashVersion(param1:String) : void
      {
         flashVersion$field = param1;
      }
      
      public function get flashVersion() : String
      {
         return flashVersion$field;
      }
      
      public function removeScreen() : void
      {
         screen$field = null;
      }
      
      public function get hasScreen() : Boolean
      {
         return screen$field != null;
      }
      
      public function set screen(param1:String) : void
      {
         screen$field = param1;
      }
      
      public function get screen() : String
      {
         return screen$field;
      }
      
      public function removeSys() : void
      {
         sys$field = null;
      }
      
      public function get hasSys() : Boolean
      {
         return sys$field != null;
      }
      
      public function set sys(param1:String) : void
      {
         sys$field = param1;
      }
      
      public function get sys() : String
      {
         return sys$field;
      }
      
      public function removeIs64Bit() : void
      {
         hasField$0 &= 4294967263;
         is64Bit$field = new Boolean();
      }
      
      public function get hasIs64Bit() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set is64Bit(param1:Boolean) : void
      {
         hasField$0 |= 32;
         is64Bit$field = param1;
      }
      
      public function get is64Bit() : Boolean
      {
         return is64Bit$field;
      }
      
      public function removeStage3D() : void
      {
         stage3D$field = null;
      }
      
      public function get hasStage3D() : Boolean
      {
         return stage3D$field != null;
      }
      
      public function set stage3D(param1:String) : void
      {
         stage3D$field = param1;
      }
      
      public function get stage3D() : String
      {
         return stage3D$field;
      }
      
      public function removeNoteBook() : void
      {
         note_book$field = null;
      }
      
      public function get hasNoteBook() : Boolean
      {
         return note_book$field != null;
      }
      
      public function set noteBook(param1:String) : void
      {
         note_book$field = param1;
      }
      
      public function get noteBook() : String
      {
         return note_book$field;
      }
      
      public function removeMemory() : void
      {
         memory$field = null;
      }
      
      public function get hasMemory() : Boolean
      {
         return memory$field != null;
      }
      
      public function set memory(param1:String) : void
      {
         memory$field = param1;
      }
      
      public function get memory() : String
      {
         return memory$field;
      }
      
      public function removeCpu() : void
      {
         cpu$field = null;
      }
      
      public function get hasCpu() : Boolean
      {
         return cpu$field != null;
      }
      
      public function set cpu(param1:String) : void
      {
         cpu$field = param1;
      }
      
      public function get cpu() : String
      {
         return cpu$field;
      }
      
      public function removeDisplay0() : void
      {
         display0$field = null;
      }
      
      public function get hasDisplay0() : Boolean
      {
         return display0$field != null;
      }
      
      public function set display0(param1:String) : void
      {
         display0$field = param1;
      }
      
      public function get display0() : String
      {
         return display0$field;
      }
      
      public function removeGPUVersion0() : void
      {
         GPUVersion0$field = null;
      }
      
      public function get hasGPUVersion0() : Boolean
      {
         return GPUVersion0$field != null;
      }
      
      public function set gPUVersion0(param1:String) : void
      {
         GPUVersion0$field = param1;
      }
      
      public function get gPUVersion0() : String
      {
         return GPUVersion0$field;
      }
      
      public function removeGPUDate0() : void
      {
         GPUDate0$field = null;
      }
      
      public function get hasGPUDate0() : Boolean
      {
         return GPUDate0$field != null;
      }
      
      public function set gPUDate0(param1:String) : void
      {
         GPUDate0$field = param1;
      }
      
      public function get gPUDate0() : String
      {
         return GPUDate0$field;
      }
      
      public function removeDisplay1() : void
      {
         display1$field = null;
      }
      
      public function get hasDisplay1() : Boolean
      {
         return display1$field != null;
      }
      
      public function set display1(param1:String) : void
      {
         display1$field = param1;
      }
      
      public function get display1() : String
      {
         return display1$field;
      }
      
      public function removeGPUVersion1() : void
      {
         GPUVersion1$field = null;
      }
      
      public function get hasGPUVersion1() : Boolean
      {
         return GPUVersion1$field != null;
      }
      
      public function set gPUVersion1(param1:String) : void
      {
         GPUVersion1$field = param1;
      }
      
      public function get gPUVersion1() : String
      {
         return GPUVersion1$field;
      }
      
      public function removeGPUDate1() : void
      {
         GPUDate1$field = null;
      }
      
      public function get hasGPUDate1() : Boolean
      {
         return GPUDate1$field != null;
      }
      
      public function set gPUDate1(param1:String) : void
      {
         GPUDate1$field = param1;
      }
      
      public function get gPUDate1() : String
      {
         return GPUDate1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasIntParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,intParam1$field);
         }
         if(hasIntParam2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,intParam2$field);
         }
         if(hasIntParam3)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,intParam3$field);
         }
         if(hasIntParam4)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,intParam4$field);
         }
         if(hasStrParam1)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,strParam1$field);
         }
         if(hasStrParam2)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,strParam2$field);
         }
         if(hasStrParam3)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,strParam3$field);
         }
         if(hasStrParam4)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,strParam4$field);
         }
         if(hasBrowser)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,browser$field);
         }
         if(hasFlashVersion)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,flashVersion$field);
         }
         if(hasScreen)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,screen$field);
         }
         if(hasSys)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,sys$field);
         }
         if(hasIs64Bit)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,is64Bit$field);
         }
         if(hasStage3D)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,stage3D$field);
         }
         if(hasNoteBook)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,note_book$field);
         }
         if(hasMemory)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,memory$field);
         }
         if(hasCpu)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,cpu$field);
         }
         if(hasDisplay0)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,display0$field);
         }
         if(hasGPUVersion0)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,GPUVersion0$field);
         }
         if(hasGPUDate0)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,GPUDate0$field);
         }
         if(hasDisplay1)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,display1$field);
         }
         if(hasGPUVersion1)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,GPUVersion1$field);
         }
         if(hasGPUDate1)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_STRING(param1,GPUDate1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc21_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc23_:uint = 0;
         var _loc27_:uint = 0;
         var _loc20_:uint = 0;
         var _loc6_:uint = 0;
         var _loc25_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc22_:uint = 0;
         var _loc24_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc26_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.type cannot be set twice.");
                  }
                  _loc21_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.intParam1 cannot be set twice.");
                  }
                  _loc3_++;
                  intParam1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.intParam2 cannot be set twice.");
                  }
                  _loc14_++;
                  intParam2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.intParam3 cannot be set twice.");
                  }
                  _loc8_++;
                  intParam3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.intParam4 cannot be set twice.");
                  }
                  _loc23_++;
                  intParam4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.strParam1 cannot be set twice.");
                  }
                  _loc27_++;
                  strParam1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.strParam2 cannot be set twice.");
                  }
                  _loc20_++;
                  strParam2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.strParam3 cannot be set twice.");
                  }
                  _loc6_++;
                  strParam3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.strParam4 cannot be set twice.");
                  }
                  _loc25_++;
                  strParam4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.browser cannot be set twice.");
                  }
                  _loc11_++;
                  browser = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.flashVersion cannot be set twice.");
                  }
                  _loc12_++;
                  flashVersion = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.screen cannot be set twice.");
                  }
                  _loc16_++;
                  screen = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.sys cannot be set twice.");
                  }
                  _loc13_++;
                  sys = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.is64Bit cannot be set twice.");
                  }
                  _loc22_++;
                  is64Bit = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.stage3D cannot be set twice.");
                  }
                  _loc24_++;
                  stage3D = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.noteBook cannot be set twice.");
                  }
                  _loc4_++;
                  noteBook = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.memory cannot be set twice.");
                  }
                  _loc10_++;
                  memory = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.cpu cannot be set twice.");
                  }
                  _loc15_++;
                  cpu = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.display0 cannot be set twice.");
                  }
                  _loc9_++;
                  display0 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.gPUVersion0 cannot be set twice.");
                  }
                  _loc7_++;
                  gPUVersion0 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.gPUDate0 cannot be set twice.");
                  }
                  _loc18_++;
                  gPUDate0 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.display1 cannot be set twice.");
                  }
                  _loc19_++;
                  display1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.gPUVersion1 cannot be set twice.");
                  }
                  _loc26_++;
                  gPUVersion1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CollectInfoMsg.gPUDate1 cannot be set twice.");
                  }
                  _loc5_++;
                  gPUDate1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

