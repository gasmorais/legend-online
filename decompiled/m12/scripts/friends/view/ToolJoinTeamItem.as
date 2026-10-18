package friends.view
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.StyleSheet;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import mvc.module.friends.ApplyPlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class ToolJoinTeamItem extends Sprite implements Disposeable
   {
      
      private var _data:ApplyPlayerInfo;
      
      private var _line:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _sexBG:ScaleFrameImage;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _acceptBtn:TextButton;
      
      private var _rejectBtn:TextButton;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _menu:ChatItemMenu;
      
      public function ToolJoinTeamItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatComponentByStylename("friend.applyJoinItemLine");
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
         addChild(_line);
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
         _acceptBtn.addEventListener("click",__acceptBtnHandler);
         _rejectBtn.addEventListener("click",__rejectBtnHandler);
         _nameTxt.addEventListener("link",__link);
      }
      
      private function removeEvent() : void
      {
         _acceptBtn.removeEventListener("click",__acceptBtnHandler);
         _rejectBtn.removeEventListener("click",__rejectBtnHandler);
         _nameTxt.removeEventListener("link",__link);
      }
      
      private function __acceptBtnHandler(param1:MouseEvent) : void
      {
         FreedomTeamManager.instance.joinTeamOp(0,_data.userId);
      }
      
      private function __rejectBtnHandler(param1:MouseEvent) : void
      {
         FreedomTeamManager.instance.joinTeamOp(1,_data.userId);
      }
      
      private function __link(param1:TextEvent) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         _menu = new ChatItemMenu(_data.nickName,_data.userId,false);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY;
      }
      
      public function set data(param1:ApplyPlayerInfo) : void
      {
         if(!param1)
         {
            _nameTxt.htmlText = "";
            _gradeTxt.htmlText = "";
            _acceptBtn.visible = false;
            _rejectBtn.visible = false;
            _sexBG.visible = false;
            _vocationIcon.visible = false;
            return;
         }
         _data = param1;
         _nameTxt.htmlText = "<a href=\'event:clickLink\'>" + _data.nickName + "</a> ";
         _gradeTxt.htmlText = LanguageMgr.GetTranslation("public.level2",_data.lv);
         _sexBG.visible = true;
         _sexBG.setFrame(_data.sex + 1);
         _acceptBtn.visible = true;
         _rejectBtn.visible = true;
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         var _loc1_:SimplePlayerInfo = null;
         if(_data && _data.transGrade > 0)
         {
            _loc1_ = new SimplePlayerInfo();
            _loc1_.vocationGrades = _data.transGrade;
            _loc1_.vocationIndex = _data.transIndex;
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(ThaneInfoHelper.getJob(_data.job),_loc1_.vocationStep,_loc1_.vocationLevel);
            _vocationIcon.setFrame(_loc1_.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_sexBG);
         _sexBG = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_acceptBtn);
         _acceptBtn = null;
         ObjectUtils.disposeObject(_rejectBtn);
         _rejectBtn = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
      }
   }
}

