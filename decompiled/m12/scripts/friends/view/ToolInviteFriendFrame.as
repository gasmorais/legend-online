package friends.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ToolInviteFriendFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _titlebarImg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _operationTxt:FilterFrameText;
      
      private var _applyList:ToolInviteFriendList;
      
      public function ToolInviteFriendFrame()
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
         titleText = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteDescribeBackground");
         _titlebarImg = ComponentFactory.Instance.creatBitmap("asset.friends.InviteTitlebarBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteFrameNameTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteFrameGradeTextStyle");
         _operationTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsInviteFrameOperationTextStyle");
         _applyList = new ToolInviteFriendList();
         _applyList.x = -5;
         _applyList.y = 43;
         addToContent(_bg);
         addToContent(_titlebarImg);
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
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_respose);
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         super.dispose();
      }
   }
}

