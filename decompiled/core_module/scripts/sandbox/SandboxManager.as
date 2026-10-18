package sandbox
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CoreTransactionManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SandboxManager
   {
      
      private static var _instance:SandboxManager;
      
      public static var loginToSandboxFlag:Boolean;
      
      public static const TYPE_DAY_LIGHT:int = 1;
      
      public static const OP_ENTER:int = 0;
      
      public static const OP_LEAVE:int = 1;
      
      public static const OP_TEAM_CONF:int = 9;
      
      public static const OP_TOP_CLICK:int = 10;
      
      public static const OP_JION:int = 11;
      
      public var exit:Boolean = true;
      
      private var _type:int = 0;
      
      private var _openDic:Dictionary;
      
      public function SandboxManager()
      {
         super();
         _openDic = new Dictionary(true);
      }
      
      public static function get instance() : SandboxManager
      {
         if(!_instance)
         {
            _instance = new SandboxManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4856,__sandboxInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4859,__sandboxStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4860,_activeStateHandler);
      }
      
      private function _activeStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         TopToolsBar.instance.dayLightState = _loc2_.param1;
      }
      
      private function __sandboxStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:String = null;
         var _loc3_:String = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as PropertyMsg;
         var _loc12_:Boolean = _loc2_.param8;
         var _loc6_:Boolean = _loc2_.param7;
         var _loc4_:int = _loc2_.param1;
         var _loc11_:String = _loc2_.param4;
         if(thane.consortiaID != 0)
         {
            if(_loc6_)
            {
               if(_loc12_)
               {
                  enter();
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.daylight.jionTip2"));
               }
            }
            else if(_loc12_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.daylight.jionTip4",_loc11_));
            }
            else if(_loc4_ == 1)
            {
               _loc10_ = TempleteManager.instance.getConfigValue("daylight_signin_offer");
               _loc5_ = FrameControllerManager.instance.consortiaController.model.consortiaInfo.offer;
               if(_loc5_ >= _loc10_)
               {
                  _loc9_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc3_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc13_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc8_ = LanguageMgr.GetTranslation("sandbox.daylight.jionTip1",_loc10_);
                  SimpleAlertHelper.instance.data = [confirmFun];
                  SimpleAlertHelper.instance.popAlerFrame(_loc13_,_loc8_,_loc9_,_loc3_,true);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.daylight.jionTip0",_loc10_));
               }
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.daylight.jionTip2"));
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.daylight.jionTip3"));
         }
      }
      
      private function confirmFun(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            jion();
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __sandboxInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param2 == 0)
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,"SANDBOX_SCENE",addQueue);
         }
         else if(_loc2_.param2 == 1)
         {
            init(_loc2_.param1);
         }
      }
      
      private function addQueue(param1:PackageIn) : void
      {
         if(SandboxManager.instance.exit)
         {
            return;
         }
         CoreTransactionManager.getInstance().currentTimeAddQueue(param1);
      }
      
      private function init(param1:int) : void
      {
         exit = false;
         _type = param1;
         _openDic[_type] = true;
         if(isDayLight)
         {
         }
         SceneManager.instance.setScene("SANDBOX_SCENE");
      }
      
      public function uninit() : void
      {
         exit = true;
         _openDic[_type] = false;
         if(isDayLight)
         {
            FrameControllerManager.instance.dayLightControler.model.dispose();
         }
         SwitchPageHelp.returnToSpace();
         _type = 0;
      }
      
      public function get isDayLight() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_type == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function requestState() : void
      {
         if(thane.consortiaID == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.daylight.jionTip3"));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param10 = 1;
         _loc1_.param11 = 10;
         sendProtoBuffer(_loc1_,_loc2_);
      }
      
      private function enter() : void
      {
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param10 = 1;
         _loc1_.param11 = 0;
         sendProtoBuffer(_loc1_,_loc2_);
      }
      
      private function jion() : void
      {
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param10 = 1;
         _loc1_.param11 = 11;
         sendProtoBuffer(_loc1_,_loc2_);
      }
      
      public function leave(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9670);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param10 = param1;
         _loc2_.param11 = 1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      private function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
   }
}

