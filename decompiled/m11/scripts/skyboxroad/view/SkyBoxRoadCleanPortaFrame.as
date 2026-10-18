package skyboxroad.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkyTrialPortalTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SkyBoxRoadCleanPortaFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _iconArr:Array;
      
      public function SkyBoxRoadCleanPortaFrame()
      {
         super();
         _iconArr = [];
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("skyboxroad.view.SkyBoxRoadCleanPortaFrame.title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.SkyBoxRoadCleanPortaFrameBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.SkyBoxRoadCleanPortaFrameTxt");
         _txt.text = LanguageMgr.GetTranslation("skyboxroad.view.SkyBoxRoadCleanPortaFrame.txt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.SkyBoxRoadCleanPortaFrame.rewardHbox");
         addToContent(_bg);
         addToContent(_txt);
         addToContent(_hBox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         StageReferance.stage.addEventListener("resize",onResize);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         StageReferance.stage.removeEventListener("resize",onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = (StageReferance.stageWidth - this.width) / 2;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function updateView() : void
      {
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc2_:SkyTrialPortalTemplateInfo = TempleteManager.instance.skyTrialPortalTemplateCate.getTemplateById(SkyboxRoadManager.instance.model.cleanPortalId);
         var _loc4_:Array = _loc2_.ClearReward.split("|");
         _hBox.spacing = (440 - _loc4_.length * 61) / _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_ = String(_loc4_[_loc5_]).split(",");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("skyboxroad.CleanGoodsCell");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc1_[1];
            _loc6_.count = _loc1_[2];
            _loc3_.data = _loc6_;
            _hBox.addChild(_loc3_);
            _iconArr.push(_loc3_);
            _loc5_++;
         }
         _hBox.x = (414 - _hBox.width) / 2;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < _iconArr.length)
         {
            ObjectUtils.disposeObject(_iconArr[_loc1_]);
            _iconArr[_loc1_] = null;
            _loc1_++;
         }
         _iconArr = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

