package secretadventure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretMapInfo;
   import secretadventure.item.SecretAdventureItem;
   import secretadventure.view.SecretAdLeftView;
   import secretadventure.view.SecretAdRightView;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SecretAdventureFrame extends Frame
   {
      
      public var _leftView:SecretAdLeftView;
      
      public var _rightView:SecretAdRightView;
      
      private var _helpBtn:BaseButton;
      
      public function SecretAdventureFrame()
      {
         super();
         initView();
         initEvent();
         SecretAdventerManager.Instance.opCommon(5);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("secret.frame.title");
         _leftView = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.leftView");
         _rightView = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.rightView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretadframe.helpBtn");
         addToContent(_leftView);
         addToContent(_rightView);
         addToContent(_helpBtn);
      }
      
      private function test() : void
      {
         model.isTest = true;
         model.frameInfo.mapId = 4;
         model.frameInfo.levelId = 1;
         model.frameInfo.currHp = 10000;
         model.frameInfo.initHp = 10000;
         model.secenInfo.levelId = 1;
         model.secenInfo.currMapDataId = 4;
         model.secenInfo.mapDataIds = "4,1,5";
         model.pinfo.lastStandNodeId = 103;
         model.pinfo.standNodeId = 103;
         var _loc1_:SecretMapInfo = new SecretMapInfo();
         _loc1_.mapDataId = model.secenInfo.currMapDataId;
         model.secenInfo.putMapInfo(model.secenInfo.currMapDataId,_loc1_);
         frameInfoHandler(null);
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         model.addEventListener("SecretAdEvent.frameUpdate",frameInfoHandler);
         model.addEventListener("SecretAdEvent.selectItem",itemChangeHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         NotificationManager.instance.addEventListener("SecretAdEvent.timeClose",resetCloseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         model.removeEventListener("SecretAdEvent.frameUpdate",frameInfoHandler);
         model.removeEventListener("SecretAdEvent.selectItem",itemChangeHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         NotificationManager.instance.removeEventListener("SecretAdEvent.timeClose",resetCloseHandler);
      }
      
      private function resetCloseHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.secretadframe.helpFrame");
         _loc2_.show();
      }
      
      private function itemChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:SecretAdventureItem = param1.data as SecretAdventureItem;
         _leftView.mapLvChang(_loc2_.temp);
         _rightView.mapLvChang(_loc2_.temp);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function frameInfoHandler(param1:NotificationEvent) : void
      {
         _leftView.info = model.frameInfo;
         _rightView.info = model.frameInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}

