package friends.view
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.StyleSheet;
   import manager.LanguageMgr;
   import mvc.module.friends.ToolInviteInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ToolInviteFriendItem extends Sprite implements Disposeable
   {
      
      private var _colorBg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _sexBG:ScaleFrameImage;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _acceptBtn:TextButton;
      
      private var _rejectBtn:TextButton;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _data:ToolInviteInfo;
      
      private var _menu:ChatItemMenu;
      
      public function ToolInviteFriendItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerItemHightcolorBg");
         _sexBG = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendIconBG");
         _sexBG.x = 0;
         _sexBG.y = 0;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerItemNameTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerItemGradeTextStyle");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerItemAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerItemRejectBtn");
         _nameTxt.htmlText = "";
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("a:hover",{"textDecoration":"underline"});
         _nameTxt.styleSheet = _loc1_;
         _gradeTxt.text = "";
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("consortia.InvitePlayer.VocationIcon");
         addChild(_colorBg);
         addChild(_sexBG);
         _sexBG.visible = false;
         addChild(_nameTxt);
         _nameTxt.width = 100;
         _nameTxt.height = 20;
         addChild(_gradeTxt);
         _gradeTxt.width = 50;
         _gradeTxt.height = 20;
         addChild(_acceptBtn);
         _acceptBtn.visible = false;
         addChild(_rejectBtn);
         _rejectBtn.visible = false;
         addChild(_vocationIcon);
         _vocationIcon.visible = false;
      }
      
      private function initEvent() : void
      {
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
         _nameTxt.addEventListener("link",__link);
      }
      
      private function removeEvent() : void
      {
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         _nameTxt.removeEventListener("link",__link);
      }
      
      private function __link(param1:TextEvent) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         _menu = new ChatItemMenu(_data.nickName,_data.id,false,_data.serverName,false,false,false,false,false,_data.uuid);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY;
      }
      
      private function __onAcceptHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         friendHandler(true);
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         friendHandler(false);
         var _loc2_:String = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.command01");
         MessageTipManager.instance().show(_loc2_);
      }
      
      public function friendHandler(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(param1)
         {
            if(isCross)
            {
               FriendManager.getInstance().sendCrossFriendRequest(0,_data.uuid);
            }
            else
            {
               if(FriendManager.getInstance().countFriend >= FriendManager.getInstance().maxFriendCount)
               {
                  _loc2_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command02");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(FriendManager.getInstance().countFriend < FriendManager.getInstance().maxFriendCount)
               {
                  FriendManager.getInstance().sendAddFriendRequest(_data.nickName,1);
               }
            }
         }
         FriendManager.getInstance().removeToolInviteFriend(_data);
      }
      
      public function get colorBg() : ScaleFrameImage
      {
         return _colorBg;
      }
      
      private function refreshVocation() : void
      {
         var _loc1_:SimplePlayerInfo = null;
         if(_data && _data.vocationGrades > 0)
         {
            _loc1_ = new SimplePlayerInfo();
            _loc1_.vocationGrades = _data.vocationGrades;
            _loc1_.vocationIndex = _data.vocationIndex;
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(ThaneInfoHelper.getJob(_data.job),_loc1_.vocationStep,_loc1_.vocationLevel);
            _vocationIcon.setFrame(_loc1_.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function set data(param1:ToolInviteInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _nameTxt.htmlText = "<a href=\'event:clickLink\'>" + _data.nickName + "</a> ";
            _sexBG.setFrame(_data.sex + 1);
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
            _acceptBtn.visible = true;
            _rejectBtn.visible = true;
            _sexBG.visible = true;
         }
         else
         {
            _nameTxt.htmlText = "";
            _gradeTxt.text = "";
            _acceptBtn.visible = false;
            _rejectBtn.visible = false;
            _sexBG.visible = false;
         }
         refreshVocation();
      }
      
      public function get data() : ToolInviteInfo
      {
         return _data;
      }
      
      private function get isCross() : Boolean
      {
         return _data.serverName != null && _data.serverName != "" && _data.serverName != playerInfo.serviceName;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _acceptBtn = null;
         _rejectBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

