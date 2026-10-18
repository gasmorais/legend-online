package remotepet
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetFriendInfo;
   import mvc.module.remotepet.RemotePetModel;
   import remotepet.views.RemotePetFriendView;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class RemotePetFriendFrame extends Frame
   {
      
      private var _back:Scale9CornerImage;
      
      private var _upBack:ScaleBitmapImage;
      
      private var _contentBack:Bitmap;
      
      private var _downback:ScaleBitmapImage;
      
      private var _friendView:RemotePetFriendView;
      
      private var _okBtn:IconButton;
      
      public function RemotePetFriendFrame()
      {
         RemotePetManager.sendFriendPetList();
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remotepet.RemotePetFriendFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendFrame.back");
         _upBack = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendFrame.upBack");
         _contentBack = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetFriendFrame.contentBack");
         _downback = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendFrame.downBack");
         _friendView = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetFriendFrame.friendView");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendView.okBtn");
         addToContent(_back);
         addToContent(_upBack);
         addToContent(_contentBack);
         addToContent(_downback);
         addToContent(_friendView);
         addToContent(_okBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _okBtn.addEventListener("click",__onHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _okBtn.removeEventListener("click",__onHandler);
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __onHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!model.selectItem)
         {
            _loc2_ = LanguageMgr.GetTranslation("remotepet.RemotePetFriendFrame.tip");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc7_:RemotePetFriendInfo = model.selectItem;
         SimpleAlertHelper.instance.data = [alertBack];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("remotepet.RemotePetFriendFrame.content",_loc7_.friendName,_loc7_.petName,_loc7_.petFight);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,false,true);
      }
      
      private function alertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RemotePetManager.sendFriendPetInfo(model.selectItem.friendId,model.selectItem.petId);
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_upBack);
         _upBack = null;
         ObjectUtils.disposeObject(_contentBack);
         _contentBack = null;
         ObjectUtils.disposeObject(_downback);
         _downback = null;
         ObjectUtils.disposeObject(_friendView);
         _friendView = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

