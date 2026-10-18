package friends.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   
   public class ToolJoinTeamFrame extends Frame implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _operationTxt:FilterFrameText;
      
      private var _applyList:ToolJoinTeamList;
      
      public function ToolJoinTeamFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.applyJoinBtn");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friend.applyJoinBg");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("friend.applyJoinBg2");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteFrameNameTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteFrameGradeTextStyle");
         _operationTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteFrameOperationTextStyle");
         _applyList = new ToolJoinTeamList();
         _applyList.x = 0;
         _applyList.y = 39;
         addToContent(_bg);
         addToContent(_bg2);
         addToContent(_nameTxt);
         addToContent(_gradeTxt);
         addToContent(_operationTxt);
         addToContent(_applyList);
         var _loc3_:String = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendFrame.nameTxtText");
         _nameTxt.text = _loc3_;
         var _loc1_:String = LanguageMgr.GetTranslation("public.grade");
         _gradeTxt.text = _loc1_;
         var _loc2_:String = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendFrame.operationTxtText");
         _operationTxt.text = _loc2_;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_respose);
         NotificationManager.instance.addEventListener("TEAMCAPTAINCHANGE",_teamcaptainChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_respose);
         NotificationManager.instance.removeEventListener("TEAMCAPTAINCHANGE",_teamcaptainChange);
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function _teamcaptainChange(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         this.y = (StageReferance.stageHeight - 353) / 2;
      }
      
      override public function get displayHeight() : Number
      {
         return 353;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         super.dispose();
      }
   }
}

