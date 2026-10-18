package rapidthrouh
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.rapidThrough.RapidThroughModel;
   import yishi.datas.templates.cate.RapidThroughRewardTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class RapidThrouhRewardTipsView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _vScrollPanel:ScrollPanel;
      
      public function RapidThrouhRewardTipsView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("rapidThrough.rewardtips.vbox");
         _vScrollPanel = ComponentFactory.Instance.creatComponentByStylename("rapidThrough.rewardtips.bagScrollPanel");
         _bg.width = 253;
         _bg.height = 293;
         _vScrollPanel.setView(_vBox);
         _vScrollPanel.vScrollbar.visible = false;
         addChild(_bg);
         addChild(_vScrollPanel);
         var _loc1_:SimpleDictionary = TempleteManager.instance.rapidThroughRewardCate.getTemplates();
         refreshView(_loc1_);
      }
      
      private function refreshView(param1:SimpleDictionary) : void
      {
         var _loc7_:String = null;
         var _loc3_:FilterFrameText = null;
         var _loc6_:FilterFrameText = null;
         var _loc2_:RapidThroughRewardTemplate = null;
         var _loc5_:HBox = null;
         var _loc8_:Array = [];
         for each(var _loc4_:RapidThroughRewardTemplate in param1)
         {
            _loc7_ = _loc4_.Ranking;
            _loc8_.push(_loc7_);
         }
         _loc8_.sort(16);
         for each(_loc7_ in _loc8_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("rapidThrough.rewardtips.titleTxt");
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("rapidThrough.rewardtips.rewardTxt");
            _loc2_ = param1[_loc7_] as RapidThroughRewardTemplate;
            _loc3_.text = _loc2_.rankingString;
            _loc6_.htmlText = _loc2_.rewardArray.join("\n");
            _loc5_ = new HBox();
            _loc5_.spacing = 15;
            _loc5_.addChild(_loc3_);
            _loc5_.addChild(_loc6_);
            _vBox.addChild(_loc5_);
            if(_vBox.displayHeight > 320)
            {
               _vScrollPanel.vScrollbar.visible = true;
               _vScrollPanel.invalidateViewport();
            }
         }
      }
      
      private function get model() : RapidThroughModel
      {
         return FrameControllerManager.instance.rapidThroughController.model;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_vScrollPanel);
         _vScrollPanel = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
   }
}

