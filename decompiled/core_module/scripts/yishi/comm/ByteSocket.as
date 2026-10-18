package yishi.comm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.WritingBuffer;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.utils.StringUtils;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import yishi.comm.check.PackageCheckController;
   import yishi.datas.consant.TraceProtoNameUtilII;
   
   [Event(name="connect",type="flash.events.Event")]
   [Event(name="close",type="flash.events.Event")]
   [Event(name="error",type="flash.events.ErrorEvent")]
   [Event(name="data",type="SocketEvent")]
   public class ByteSocket extends EventDispatcher
   {
      
      public static var RECEIVE_KEY:ByteArray;
      
      public static var SEND_KEY:ByteArray;
      
      private static var KEY:Array = [174,191,86,120,171,205,239,241];
      
      private var _debug:Boolean;
      
      private var _socket:Socket;
      
      private var _ip:String;
      
      private var _port:Number;
      
      private var _send_fsm:FSM;
      
      private var _receive_fsm:FSM;
      
      private var _encrypted:Boolean;
      
      private var _sendCampaignPkgCount:int = 0;
      
      private var _sendVehiclePkgCount:int = 0;
      
      private var _snowPkgCount:int = 0;
      
      private var _check:PackageCheckController;
      
      private var _readBuffer:ByteArray;
      
      private var _readOffset:int;
      
      private var _writeOffset:int;
      
      private var _headerTemp:ByteArray;
      
      private var pkgNumber:int = 0;
      
      public function ByteSocket(param1:Boolean = true, param2:Boolean = false)
      {
         super();
         _readBuffer = new ByteArray();
         _send_fsm = new FSM(2059198199,1501);
         _receive_fsm = new FSM(2059198199,1501);
         _headerTemp = new ByteArray();
         _encrypted = param1;
         _debug = param2;
         setKey(KEY);
         _check = new PackageCheckController(this);
      }
      
      public function setKey(param1:Array) : void
      {
         var _loc2_:int = 0;
         RECEIVE_KEY = new ByteArray();
         SEND_KEY = new ByteArray();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            RECEIVE_KEY.writeByte(param1[_loc2_]);
            SEND_KEY.writeByte(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function resetKey() : void
      {
         setKey(KEY);
      }
      
      public function setFsm(param1:int, param2:int) : void
      {
         _send_fsm.setup(param1,param2);
         _receive_fsm.setup(param1,param2);
      }
      
      public function connect(param1:String, param2:Number) : void
      {
         try
         {
            if(_socket)
            {
               close(false);
            }
            _socket = new Socket();
            addEvent(_socket);
            _ip = param1;
            _port = param2;
            _readBuffer.position = 0;
            _readOffset = 0;
            _writeOffset = 0;
            _socket.connect(param1,param2);
         }
         catch(err:Error)
         {
            dispatchEvent(new ErrorEvent("error",false,false,err.message));
         }
      }
      
      private function addEvent(param1:Socket) : void
      {
         param1.addEventListener("connect",this.handleConnect);
         param1.addEventListener("close",this.handleClose);
         param1.addEventListener("socketData",handleIncoming);
         param1.addEventListener("ioError",handleIoError);
         param1.addEventListener("securityError",handleIoError);
      }
      
      private function removeEvent(param1:Socket) : void
      {
         param1.removeEventListener("connect",this.handleConnect);
         param1.removeEventListener("close",this.handleClose);
         param1.removeEventListener("socketData",handleIncoming);
         param1.removeEventListener("ioError",handleIoError);
         param1.removeEventListener("securityError",handleIoError);
      }
      
      public function get connected() : Boolean
      {
         return _socket && _socket.connected;
      }
      
      public function isSame(param1:String, param2:int) : Boolean
      {
         return _ip == param1 && param2 == _port;
      }
      
      public function send(param1:PackageOut, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         switch(param1.code)
         {
            case 8196:
            case 8549:
            case 5125:
            case 8255:
            case 8548:
            case 5121:
            case 5033:
            case 5124:
            case 25202:
            case 25203:
            case 9669:
               _sendCampaignPkgCount = _sendCampaignPkgCount + 1;
               if(param2 != _sendCampaignPkgCount)
               {
                  _socket.close();
                  return;
               }
               break;
            case 8616:
            case 8617:
            case 8615:
               _sendVehiclePkgCount = _sendVehiclePkgCount + 1;
               if(param2 != _sendVehiclePkgCount)
               {
                  _socket.close();
                  return;
               }
               break;
            case 25217:
            case 25216:
            case 25218:
               _snowPkgCount = _snowPkgCount + 1;
               if(param2 != _snowPkgCount)
               {
                  _socket.close();
                  return;
               }
         }
         if(_socket && _socket.connected)
         {
            _check.addPackage(param1);
            param1.pack();
            if(_debug)
            {
            }
            if(_encrypted)
            {
               _loc3_ = 0;
               while(_loc3_ < param1.length)
               {
                  if(_loc3_ > 0)
                  {
                     SEND_KEY[_loc3_ % 8] = SEND_KEY[_loc3_ % 8] + param1[_loc3_ - 1] ^ _loc3_;
                     param1[_loc3_] = (param1[_loc3_] ^ SEND_KEY[_loc3_ % 8]) + param1[_loc3_ - 1];
                  }
                  else
                  {
                     param1[0] ^= SEND_KEY[0];
                  }
                  _loc3_++;
               }
               _socket.writeBytes(param1,0,param1.length);
            }
            else
            {
               _socket.writeBytes(param1,0,param1.length);
            }
            _socket.flush();
         }
      }
      
      public function sendProtobuffer(param1:PackageOut, param2:Message, param3:int = 0) : void
      {
         var _loc6_:WritingBuffer = null;
         var _loc5_:String = null;
         var _loc4_:String = "";
         if(param2)
         {
            _loc6_ = new WritingBuffer();
            param2.writeExternal(_loc6_);
            param1.writeBytes(_loc6_,0,_loc6_.length);
            if(param2.hasOwnProperty("opType"))
            {
               _loc4_ = "【" + param2["opType"] + "】";
            }
            else if(param2.hasOwnProperty("op"))
            {
               _loc4_ = "【" + param2["op"] + "】";
            }
         }
         if(DisplayLoader.isDebug)
         {
            _loc5_ = "0x" + StringUtils.padLeft(param1.code.toString(16),"0",4);
            trace("send pkg.code : 【" + _loc5_ + "】 " + TraceProtoNameUtilII.Instance.getSendProtoName(_loc5_));
         }
         send(param1,param3);
      }
      
      public function sendString(param1:String) : void
      {
         if(_socket.connected)
         {
            _socket.writeUTF(param1);
            _socket.flush();
         }
      }
      
      public function close(param1:Boolean = true) : void
      {
         removeEvent(_socket);
         if(_socket.connected)
         {
            try
            {
               _socket.close();
            }
            catch(e:Error)
            {
            }
         }
         if(param1)
         {
            dispatchEvent(new Event("close"));
         }
      }
      
      private function handleConnect(param1:Event) : void
      {
         try
         {
            _send_fsm.reset();
            _receive_fsm.reset();
            _send_fsm.setup(2059198199,1501);
            _receive_fsm.setup(2059198199,1501);
            dispatchEvent(new Event("connect"));
         }
         catch(e:Error)
         {
         }
      }
      
      private function handleClose(param1:Event) : void
      {
         try
         {
            trace(param1.toString());
            removeEvent(_socket);
            dispatchEvent(new Event("close"));
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function handleIoError(param1:ErrorEvent) : void
      {
         try
         {
            dispatchEvent(new ErrorEvent("error",false,false,param1.text));
         }
         catch(e:Error)
         {
         }
      }
      
      private function handleIncoming(param1:ProgressEvent) : void
      {
         var _loc2_:int = 0;
         if(_socket.bytesAvailable > 0)
         {
            _loc2_ = int(_socket.bytesAvailable);
            _socket.readBytes(_readBuffer,_writeOffset,_socket.bytesAvailable);
            _writeOffset += _loc2_;
            if(_writeOffset > 1)
            {
               _readBuffer.position = 0;
               _readOffset = 0;
               if(_readBuffer.bytesAvailable >= 20)
               {
                  readPackage();
               }
            }
         }
      }
      
      private function readPackage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PackageIn = null;
         var _loc3_:int = _writeOffset - _readOffset;
         do
         {
            _loc1_ = 0;
            while(_readOffset + 4 < _writeOffset)
            {
               _headerTemp.position = 0;
               _headerTemp.writeByte(_readBuffer[_readOffset]);
               _headerTemp.writeByte(_readBuffer[_readOffset + 1]);
               _headerTemp.writeByte(_readBuffer[_readOffset + 2]);
               _headerTemp.writeByte(_readBuffer[_readOffset + 3]);
               if(_encrypted)
               {
                  _headerTemp = decrptBytes(_headerTemp,4,copyByteArray(RECEIVE_KEY));
               }
               _headerTemp.position = 0;
               if(_headerTemp.readShort() == 29099)
               {
                  _loc1_ = int(_headerTemp.readUnsignedShort());
                  break;
               }
               _readOffset = _readOffset + 1;
            }
            _loc3_ = _writeOffset - _readOffset;
            if(!(_loc3_ >= _loc1_ && _loc1_ != 0))
            {
               break;
            }
            _readBuffer.position = _readOffset;
            _loc2_ = new PackageIn();
            if(_encrypted)
            {
               _loc2_.loadE(_readBuffer,_loc1_,RECEIVE_KEY);
            }
            else
            {
               _loc2_.load(_readBuffer,_loc1_);
            }
            _readOffset += _loc1_;
            _loc3_ = _writeOffset - _readOffset;
            handlePackage(_loc2_);
         }
         while(_loc3_ >= 20);
         _readBuffer.position = 0;
         if(_loc3_ > 0)
         {
            _readBuffer.writeBytes(_readBuffer,_readOffset,_loc3_);
         }
         _readOffset = 0;
         _writeOffset = _loc3_;
      }
      
      private function copyByteArray(param1:ByteArray) : ByteArray
      {
         var _loc3_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeByte(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function decrptBytes(param1:ByteArray, param2:int, param3:ByteArray) : ByteArray
      {
         var _loc5_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc4_.writeByte(param1[_loc5_]);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            if(_loc5_ > 0)
            {
               param3[_loc5_ % 8] = param3[_loc5_ % 8] + param1[_loc5_ - 1] ^ _loc5_;
               _loc4_[_loc5_] = param1[_loc5_] - param1[_loc5_ - 1] ^ param3[_loc5_ % 8];
            }
            else
            {
               _loc4_[0] = param1[0] ^ param3[0];
            }
            _loc5_++;
         }
         param1.clear();
         return _loc4_;
      }
      
      private function tracePkg(param1:ByteArray, param2:String, param3:int = -1) : void
      {
         var _loc5_:int = 0;
         var _loc4_:String = param2;
         var _loc6_:int = int(param3 < 0 ? param1.length : param3);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ += String(param1[_loc5_]) + ", ";
            _loc5_++;
         }
      }
      
      private function traceArr(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "[";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1[_loc3_] + " ";
            _loc3_++;
         }
         _loc2_ += "]";
      }
      
      private function handlePackage(param1:PackageIn) : void
      {
         if(_debug)
         {
         }
         try
         {
            if(param1.checkSum == param1.calculateCheckSum())
            {
               param1.position = 20;
               dispatchEvent(new SocketEvent("data",param1));
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public function dispose() : void
      {
         if(_socket.connected)
         {
            try
            {
               _socket.close();
            }
            catch(e:Error)
            {
            }
         }
         _socket = null;
      }
   }
}

class FSM
{
   
   private var _state:int;
   
   private var _adder:int;
   
   private var _multiper:int;
   
   public function FSM(param1:int, param2:int)
   {
      super();
      setup(param1,param2);
   }
   
   public function getState() : int
   {
      return _state;
   }
   
   public function reset() : void
   {
      _state = 0;
   }
   
   public function setup(param1:int, param2:int) : void
   {
      _adder = param1;
      _multiper = param2;
      updateState();
   }
   
   public function updateState() : int
   {
      _state = (~_state + _adder) * _multiper;
      _state ^= _state >> 16;
      return _state;
   }
}
