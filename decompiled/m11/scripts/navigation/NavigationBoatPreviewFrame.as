package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class NavigationBoatPreviewFrame extends Frame
   {
      
      private var back:ScaleBitmapImage;
      
      private var boatImage1:Image;
      
      private var boatImage2:Image;
      
      private var boatImage3:Image;
      
      private var boatImage4:Image;
      
      private var boatImage5:Image;
      
      private var boatImage6:Image;
      
      private var boatImage7:Image;
      
      private var boatImage8:Image;
      
      private var boatImage9:Image;
      
      private var curUpgradeTempInfo:UpgradeTemplateInfo;
      
      public function NavigationBoatPreviewFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         back = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPreviewFrame.back");
         addToContent(back);
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            this["boatImage" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.boatImage" + _loc1_);
            (this["boatImage" + _loc1_] as Image).x = -5 + (_loc1_ - 1) % 3 * 95;
            (this["boatImage" + _loc1_] as Image).y = 5 + int((_loc1_ - 1) / 3) * 120;
            addToContent(this["boatImage" + _loc1_]);
            curUpgradeTempInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc1_,118);
            if(!(!curUpgradeTempInfo || curUpgradeTempInfo.ActiveObject == 0))
            {
               (this["boatImage" + _loc1_] as Image).tipData = LanguageMgr.GetTranslation("NavigationBoadUpgradeView.reduceTimeText.text",curUpgradeTempInfo.ActiveObject);
            }
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("navigation.NavigationBoatPreviewFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(boatImage1);
         boatImage1 = null;
         ObjectUtils.disposeObject(boatImage2);
         boatImage2 = null;
         ObjectUtils.disposeObject(boatImage3);
         boatImage3 = null;
         ObjectUtils.disposeObject(boatImage4);
         boatImage4 = null;
         ObjectUtils.disposeObject(boatImage5);
         boatImage5 = null;
         ObjectUtils.disposeObject(boatImage6);
         boatImage6 = null;
         ObjectUtils.disposeObject(boatImage7);
         boatImage7 = null;
         ObjectUtils.disposeObject(boatImage8);
         boatImage8 = null;
         ObjectUtils.disposeObject(boatImage9);
         boatImage9 = null;
         super.dispose();
      }
   }
}

