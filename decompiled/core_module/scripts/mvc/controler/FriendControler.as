package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.IMManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.friends.IMFrameEvent;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.tips.MessageTipManager;
   
   public class FriendControler extends FrameController
   {
      
      public static const STATIC_ID:int = 130000000;
      
      public var currentPanel:int;
      
      public var frameType:int;
      
      private var _findFriendFrame:Frame;
      
      public function FriendControler()
      {
         super();
      }
      
      public function startFrameByType(param1:int, param2:Object = null) : void
      {
         frameType = param1;
         FrameControllerManager.instance.openControllerByInfo("friends",null,param2);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(frameType == 1)
         {
            return "friends.FriendsFrame";
         }
         if(frameType == 2)
         {
            return "friends.RecommendFriendFrame";
         }
         if(frameType == 3)
         {
            return "core.FriendsInviteFrame";
         }
         if(frameType == 4)
         {
            return "core.IMFrame";
         }
         if(frameType == 5)
         {
            return "friends.RosePresentBackView";
         }
         if(frameType == 6)
         {
            return "friends.IMQuickRosePresentView";
         }
         if(frameType == 7)
         {
            return "core.JoinTeamFrame";
         }
         if(frameType == 8)
         {
            return "friends.RosePresentBackNewView";
         }
         return "";
      }
      
      override protected function createFrame() : void
      {
         var _loc1_:String = frameClassName;
         LayerManager.Instance.clickPos = MainToolBar.instance.getBtnPos(_loc1_);
         switch(frameType - 4)
         {
            case 0:
               _frame = ComponentFactory.Instance.creatComponentByStylename(_loc1_);
               break;
            case 1:
            case 2:
            case 4:
               if(!_data || !_data.frameData)
               {
                  return;
               }
               _frame = ComponentFactory.Instance.creatComponentByStylename(_loc1_,_data.frameData as Array);
               break;
            default:
               _frame = ComponentFactory.Instance.createComponentGroupByStylename(_loc1_,true);
         }
         if(_frame && !_frame.isDie)
         {
            showFrame();
         }
         else
         {
            _frame = null;
         }
         if(_isLoadingLock)
         {
            LoadingSceneView.instance.hide();
         }
         _isLoadingLock = false;
      }
      
      override protected function showFrame() : void
      {
         var _loc2_:ThaneInfo = null;
         var _loc3_:Boolean = false;
         var _loc5_:String = null;
         var _loc1_:String = null;
         var _loc4_:Frame = null;
         super.showFrame();
         if(frameType == 2)
         {
            _frame["show"]();
            _frame["isScaleMove"] = Boolean(_data);
         }
         else if(frameType == 4)
         {
            if(!_data || !_data.frameData)
            {
               return;
            }
            _loc2_ = _data.frameData as ThaneInfo;
            _loc3_ = _loc2_.serviceName != "" && _loc2_.serviceName != null && _loc2_.serviceName != playerInfo.serviceName;
            _loc5_ = _loc3_ ? _loc2_.serviceName + "_" + _loc2_.userId : _loc2_.userId + "";
            _loc1_ = "";
            if(_loc2_.serviceName == playerInfo.serviceName && _loc2_.userId == playerManager.currentPlayerModel.playerInfo.userId)
            {
               _loc1_ = LanguageMgr.GetTranslation("friends.im.IMManager.command01");
               MessageTipManager.instance().show(_loc1_);
               return;
            }
            _loc4_ = imManager.model.openIMFrameDic[_loc5_];
            if((!_loc4_ || !_loc4_.parent) && imManager.showIMFrameNum >= 3)
            {
               _loc1_ = LanguageMgr.GetTranslation("friends.im.IMManager.command02");
               MessageTipManager.instance().show(_loc1_);
               return;
            }
            if(_loc4_)
            {
               _loc4_["show"]();
               _loc4_["chatInputView"].setFocus();
               imManager.cleanMsgListByIdAndType(_loc5_,1);
               return;
            }
            if(!_frame)
            {
               return;
            }
            _frame["data"] = _loc2_;
            _frame.addEventListener("IMFRAME_DISPOSE",__imFrameDisposeHandler);
            _frame["show"]();
            imManager.model.openIMFrameDic.add(_loc5_,_frame);
            imManager.cleanMsgListByIdAndType(_loc5_,1);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      private function __imFrameDisposeHandler(param1:IMFrameEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         param1.currentTarget.removeEventListener("IMFRAME_DISPOSE",__imFrameDisposeHandler);
         var _loc2_:ThaneInfo = param1.data;
         if(_loc2_)
         {
            _loc3_ = _loc2_.serviceName != "" && _loc2_.serviceName != null && _loc2_.serviceName != playerInfo.serviceName;
            _loc4_ = _loc3_ ? _loc2_.serviceName + "_" + _loc2_.userId : _loc2_.userId + "";
            imManager.model.openIMFrameDic.del(_loc4_);
         }
      }
      
      override protected function exitFrame() : void
      {
         if(_findFriendFrame)
         {
            _findFriendFrame.dispose();
            _findFriendFrame = null;
         }
         frameType = 0;
         super.exitFrame();
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      private function get playerManager() : PlayerManager
      {
         return PlayerManager.instance;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function sendAddFriendRequest(param1:String, param2:int) : void
      {
         FriendManager.getInstance().sendAddFriendRequest(param1,param2);
      }
      
      public function openFindFriendFrame() : void
      {
         if(!_findFriendFrame)
         {
            _findFriendFrame = ComponentFactory.Instance.creatComponentByStylename("friends.FindFriendFrame");
            _findFriendFrame.addEventListener("dispose",__findFriendDispose);
            _findFriendFrame["show"]();
         }
      }
      
      private function __findFriendDispose(param1:Event) : void
      {
         _findFriendFrame.removeEventListener("dispose",__findFriendDispose);
         _findFriendFrame = null;
      }
      
      public function closeFindFriendFrame() : void
      {
         if(_findFriendFrame)
         {
            _findFriendFrame.dispose();
         }
         _findFriendFrame = null;
      }
      
      public function showFindFriendFrame() : void
      {
         if(_findFriendFrame)
         {
            _findFriendFrame["show"]();
         }
      }
      
      public function removeFindFriendFrame() : void
      {
         if(_findFriendFrame && _findFriendFrame.parent)
         {
            _findFriendFrame.parent.removeChild(_findFriendFrame);
         }
      }
   }
}

