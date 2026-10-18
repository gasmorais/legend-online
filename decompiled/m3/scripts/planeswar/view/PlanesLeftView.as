package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.manager.PlanesWarManager;
   import yishi.view.frame.planeswar.PlanesResourceFrame;
   
   public class PlanesLeftView extends Component
   {
      
      private var reviveCount:FilterFrameText;
      
      private var keyImage:MutipleImage;
      
      private var goldKeyText:FilterFrameText;
      
      private var silverKeyText:FilterFrameText;
      
      private var getRewardBtn:IconButton;
      
      private var mapBtn:IconButton;
      
      private var skillBtn:BaseButton;
      
      private var helpBtn:IconButton;
      
      private var helpView:PlanesWarIconHelpView;
      
      public function PlanesLeftView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         reviveCount = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.reviveCount");
         keyImage = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.keyImage");
         goldKeyText = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.goldKeyText");
         silverKeyText = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.silverKeyText");
         getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.getRewardBtn");
         mapBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.mapBtn");
         helpBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.helpBtn");
         skillBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.skillBtn");
         helpView = ComponentFactory.Instance.creatCustomObject("PlanesLeftView.helpView");
         addChild(reviveCount);
         addChild(keyImage);
         addChild(goldKeyText);
         addChild(silverKeyText);
         addChild(getRewardBtn);
         getRewardBtn.x = 10;
         getRewardBtn.y = 65;
         addChild(mapBtn);
         addChild(skillBtn);
         addChild(helpBtn);
         addChild(helpView);
         helpView.visible = helpView.showState;
      }
      
      private function addEvent() : void
      {
         PlanesWarManager.instance.addEventListener("PLANES_LAYERLIST_UPDATE",__layerListUpdate);
         getRewardBtn.addEventListener("click",__getRewardClickHandler);
         mapBtn.addEventListener("click",__mapBtnClickHandler);
         helpBtn.addEventListener("click",__helpBtnClickHandler);
         skillBtn.addEventListener("click",__skillBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         PlanesWarManager.instance.removeEventListener("PLANES_LAYERLIST_UPDATE",__layerListUpdate);
         if(getRewardBtn)
         {
            getRewardBtn.removeEventListener("click",__getRewardClickHandler);
         }
         if(mapBtn)
         {
            getRewardBtn.removeEventListener("click",__mapBtnClickHandler);
         }
         if(helpBtn)
         {
            getRewardBtn.removeEventListener("click",__helpBtnClickHandler);
         }
         if(skillBtn)
         {
            skillBtn.removeEventListener("click",__skillBtnClickHandler);
         }
      }
      
      private function __layerListUpdate(param1:PlanesWarEvent) : void
      {
         refreshView();
      }
      
      private function __getRewardClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlanesResourceFrame = ComponentFactory.Instance.creatComponentByStylename("PlanesListView.PlanesResourceFrame");
         _loc2_.show();
      }
      
      private function __mapBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlanesWarLayerMapFrame = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.PlanesWarLayerMapFrame");
         _loc2_.show();
      }
      
      private function __skillBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlanesUseSkillFrame = ComponentFactory.Instance.creatComponentByStylename("PlanesLeftView.PlanesUseSkillFrame");
         _loc2_.show();
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         helpView.showState = !helpView.showState;
      }
      
      public function refreshView() : void
      {
         reviveCount.text = LanguageMgr.GetTranslation("PlanesLeftView.reviveCount.text",model.planesWarInfo.reviveLeft);
         goldKeyText.text = "x" + model.planesWarInfo.goldKeyCount;
         silverKeyText.text = "x" + model.planesWarInfo.silverKeyCount;
         skillBtn.enable = !model.planesWarInfo.isHideLayer;
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(reviveCount)
         {
            ObjectUtils.disposeObject(reviveCount);
         }
         reviveCount = null;
         if(getRewardBtn)
         {
            ObjectUtils.disposeObject(getRewardBtn);
         }
         getRewardBtn = null;
         if(keyImage)
         {
            ObjectUtils.disposeObject(keyImage);
         }
         keyImage = null;
         if(goldKeyText)
         {
            ObjectUtils.disposeObject(goldKeyText);
         }
         goldKeyText = null;
         if(silverKeyText)
         {
            ObjectUtils.disposeObject(silverKeyText);
         }
         silverKeyText = null;
         if(mapBtn)
         {
            ObjectUtils.disposeObject(mapBtn);
         }
         mapBtn = null;
         if(helpBtn)
         {
            ObjectUtils.disposeObject(helpBtn);
         }
         helpBtn = null;
         if(skillBtn)
         {
            ObjectUtils.disposeObject(skillBtn);
         }
         skillBtn = null;
         if(helpView)
         {
            ObjectUtils.disposeObject(helpView);
         }
         helpView = null;
         super.dispose();
      }
   }
}

