package lordtrial.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.LordTrialTempInfo;
   import yishi.manager.TempleteManager;
   
   public class LordTrialRankRewardTipView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _vScrollPanel:ScrollPanel;
      
      public function LordTrialRankRewardTipView()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _vScrollPanel = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankRewardTipView.bagScrollPanel");
         _vBox = new VBox();
         _vBox.spacing = 10;
         _vBox.y = 10;
         addChild(_bg);
         addChild(_vScrollPanel);
         _vScrollPanel.x = 10;
         _vScrollPanel.y = 5;
         _bg.width = 350;
         _bg.height = 325;
         _vScrollPanel.setView(_vBox);
         _vScrollPanel.vScrollbar.visible = false;
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
      
      private function initData() : void
      {
         var _loc1_:LordTrialRankRewardTipItem = null;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new LordTrialRankRewardTipItem();
            _loc2_ = TempleteManager.instance.lordTrialTempCate.getRankRewrad(100 + _loc3_);
            if(_loc2_)
            {
               _loc1_.type = _loc3_ + 1;
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  _loc1_.data = _loc2_[_loc4_];
                  _loc4_++;
               }
            }
            _vBox.addChild(_loc1_);
            _loc3_++;
         }
         if(_vBox.displayHeight > 320)
         {
            _vScrollPanel.vScrollbar.visible = true;
            _vScrollPanel.invalidateViewport();
         }
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

