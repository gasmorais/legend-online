package yishi.service.managers
{
   import battle.BattleManager;
   import battle.transaction.VictoryFailTransaction;
   import chat.ChatManager;
   import com.pickgliss.utils.StringUtils;
   import com.road.yishi.proto.army.MapUpdatedMsg;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import logging.LoggerSys;
   import yishi.comm.ByteSocket;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.comm.SocketEvent;
   import yishi.datas.UserInfo;
   import yishi.datas.consant.TraceProtoNameUtilII;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.CoreTransactionManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.CallInterfaceUtil;
   
   public class SocketManager extends EventDispatcher
   {
      
      private static var _instance:SocketManager;
      
      private static var _baseSocket:ByteSocket;
      
      private static const UPDATE_CASTLE:int = 2;
      
      private static const UPDATE_WILDLAND:int = 1;
      
      private static const UPDATE_ARMY:int = 3;
      
      public var acceptData:Boolean = false;
      
      public function SocketManager()
      {
         super();
         _baseSocket = new ByteSocket(true);
         _baseSocket.addEventListener("close",__socketClose);
         _baseSocket.addEventListener("error",__socketError);
         _baseSocket.addEventListener("data",__chatSocketData);
         _baseSocket.addEventListener("connect",__chatSocketConnected);
      }
      
      public static function get instance() : SocketManager
      {
         if(!_instance)
         {
            _instance = new SocketManager();
         }
         return _instance;
      }
      
      public function get socket() : ByteSocket
      {
         return _baseSocket;
      }
      
      private function __socketError(param1:ErrorEvent) : void
      {
         this.dispatchEvent(new ErrorEvent("error"));
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         var _loc3_:String = PlayerManager.instance.currentPlayerModel.userInfo.user;
         LoggerSys.info("uid : " + _loc2_ + " user : " + _loc3_ + " __socketError : " + param1.text);
      }
      
      private function __socketClose(param1:Event) : void
      {
         var _loc2_:Array = userInfo.site.split("_");
         if(_loc2_[0] == "duowan")
         {
            CallInterfaceUtil.cannDuowanPlayerNotify(userInfo.user,userInfo.site,3,int(_loc2_[1]));
         }
         this.dispatchEvent(new Event("close"));
      }
      
      private function __chatSocketConnected(param1:Event) : void
      {
         PackageOut.clientId = userInfo.userId;
         SocketSendManager.instance.loginCmd();
         dispatchEvent(new Event("connect"));
      }
      
      private function get userInfo() : UserInfo
      {
         return PlayerManager.instance.currentPlayerModel.userInfo;
      }
      
      private function __chatSocketData(param1:SocketEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:String = null;
         var _loc2_:Boolean = false;
         var _loc5_:PackageIn = param1.data as PackageIn;
         if(_loc5_.code.toString(16) != "11f5" && _loc5_.code.toString(16) != "6d" && _loc5_.code.toString(16) != "108a" && _loc5_.code.toString(16) != "11ff" && _loc5_.code.toString(16) != "11f2")
         {
            _loc3_ = "0x" + StringUtils.padLeft(_loc5_.code.toString(16),"0",4);
            if(_loc3_ != "0x1210")
            {
               trace("receive pkg.code : 【" + _loc3_ + "】 " + TraceProtoNameUtilII.Instance.getAcceptProtoName(_loc3_));
            }
         }
         if(!acceptData)
         {
            switch(_loc5_.code - 3)
            {
               case 0:
                  _loc2_ = true;
            }
            if(!_loc2_)
            {
               return;
            }
         }
         switch(_loc5_.code)
         {
            case 140:
               mapDataSync(_loc5_);
               break;
            case 143:
               dispatchEvent(new SLGSocketEvent("U_PLAY_MOVIE",_loc5_));
               if(!ChatManager.instance.model)
               {
                  return;
               }
               _loc4_ = getTimer() - ChatManager.instance.model.getProtocolTimeByID(_loc5_.extend1);
               if(_loc4_ >= 3)
               {
               }
               ChatManager.instance.model.removeReceiveProtocol(_loc5_.extend1);
               break;
            case 154:
               VictoryFailTransaction.handle(_loc5_);
               if(!ChatManager.instance.model)
               {
                  return;
               }
               _loc4_ = getTimer() - ChatManager.instance.model.getProtocolTimeByID(_loc5_.extend1);
               if(_loc4_ >= 3)
               {
               }
               ChatManager.instance.model.removeReceiveProtocol(_loc5_.extend1);
               break;
            case 171:
               BattleManager.getInstance().plotHandler.handler(_loc5_);
               break;
            case 157:
               CoreTransactionManager.getInstance().handlerPackage(_loc5_);
               break;
            case 4102:
            case 153:
            case 156:
            case 159:
            case 72:
            case 69:
            case 77:
            case 4149:
            case 4361:
            case 4600:
            case 4752:
            case 4793:
            case 4795:
            case 4849:
            case 4589:
            case 4311:
            case 4591:
               dispatchEvent(new SLGSocketEvent("GAME_CMD",_loc5_));
               break;
            case 4612:
               dispatchEvent(new SLGSocketEvent("SLGSocketEvent" + 4612,_loc5_));
               break;
            default:
               dispatchEvent(new SLGSocketEvent("SLGSocketEvent" + _loc5_.code,_loc5_));
         }
      }
      
      private function mapDataSync(param1:PackageIn) : void
      {
         var _loc2_:MapUpdatedMsg = new MapUpdatedMsg();
         _loc2_ = param1.readBody(_loc2_) as MapUpdatedMsg;
         switch(_loc2_.updatedType - 1)
         {
            case 0:
               this.dispatchEvent(new SLGSocketEvent("UPDATE_WILDLAND",_loc2_.wildLand));
               break;
            case 1:
               this.dispatchEvent(new SLGSocketEvent("UPDATE_CASTLE",_loc2_.baseCastle));
               break;
            case 2:
               this.dispatchEvent(new SLGSocketEvent("UPDTAE_ARMY",_loc2_.army));
         }
      }
      
      public function listener(param1:uint, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.addEventListener("SLGSocketEvent" + param1,param2,param3,param4,param5);
      }
      
      public function unlistener(param1:uint, param2:Function, param3:Boolean = false) : void
      {
         this.removeEventListener("SLGSocketEvent" + param1,param2,param3);
      }
   }
}

