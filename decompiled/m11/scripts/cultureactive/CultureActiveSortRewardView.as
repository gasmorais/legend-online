package cultureactive
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.culture.OrderRewardMsg;
   import manager.LanguageMgr;
   import yishi.manager.CultureActiveManager;
   
   public class CultureActiveSortRewardView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _rewardsScroll:ScrollPanel;
      
      private var _noteTxt:FilterFrameText;
      
      private var _rewardsVBox:VBox;
      
      public function CultureActiveSortRewardView()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _rewardsScroll = ComponentFactory.Instance.creatComponentByStylename("cultureActiveSort.ScrollPanel");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("cultureActiveSort.noteTxt");
         _rewardsVBox = ComponentFactory.Instance.creatComponentByStylename("cultureActiveSort.TaskItemVbox");
         addChild(_bg);
         _bg.width = 294;
         addChild(_rewardsScroll);
         addChild(_rewardsVBox);
         _rewardsScroll.setView(_rewardsVBox);
         _noteTxt.text = LanguageMgr.GetTranslation("CultureActiveSortRewardView.noteTxt.text");
         updateTransform();
      }
      
      protected function updateTransform() : void
      {
         var _loc2_:CultureActiveSortRewardItem = null;
         var _loc3_:int = 0;
         _rewardsVBox.beginChanges();
         _rewardsVBox.addChild(_noteTxt);
         var _loc1_:Array = CultureActiveManager.instance.rankMsg.orderReward;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new CultureActiveSortRewardItem();
            _loc2_.data = OrderRewardMsg(_loc1_[_loc3_]);
            _rewardsVBox.addChild(_loc2_);
            _loc3_++;
         }
         _rewardsVBox.commitChanges();
         _rewardsScroll.invalidateViewport(false);
         _bg.height = _rewardsScroll.y + _rewardsScroll.height + 10;
      }
      
      private function clean() : void
      {
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rewardsScroll);
         _rewardsScroll = null;
         ObjectUtils.disposeObject(_rewardsVBox);
         _rewardsVBox = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         super.dispose();
      }
   }
}

